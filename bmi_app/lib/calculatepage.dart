import 'package:flutter/material.dart';
import 'package:bmi_app/bmi_function.dart';
import 'package:bmi_app/history_function.dart';

class CalculatePage extends StatefulWidget {
  const CalculatePage({super.key});

  @override
  State<CalculatePage> createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final BmiHistory _history = BmiHistory();

  double? _bmi;
  String _advice = '';

  static const Color _bgGreen = Color(0xFF4A9B6F);
  static const Color _cardYellow = Color(0xFFFFF1B7);
  static const Color _borderGold = Color(0xFFD1C27F);
  static const Color _darkGreen = Color(0xFF1B4D35);
  static const Color _brightGreen = Color(0xFF2E7D32);

  @override
  void initState() {
    super.initState();
    _restoreLatestResult();
  }

  void _restoreLatestResult() {
    final latest = _history.latestRecord;
    if (latest == null) {
      return;
    }

    final bmiResult = Bmi(weightKg: latest.weightKg, heightM: latest.heightM);
    _weightController.text = latest.weightKg.toString();
    _heightController.text = (latest.heightM * 100).toStringAsFixed(0);

    setState(() {
      _bmi = bmiResult.value;
      _advice = bmiResult.advice;
    });
  }

  void _clearHistory() {
    _history.clearHistory();
    _weightController.clear();
    _heightController.clear();

    setState(() {
      _bmi = null;
      _advice = '';
    });
  }

  void _calculate() {
    final String weightText = _weightController.text.trim();
    final String heightText = _heightController.text.trim();

    void _showWarning(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red[600],
          duration: const Duration(seconds: 2),
        ),
      );
    }

    if (weightText.isEmpty) {
      _showWarning('Please enter your weight');
      return;
    }

    if (heightText.isEmpty) {
      _showWarning('Please enter your height');
      return;
    }

    final double? weight = double.tryParse(weightText);
    final double? height = double.tryParse(heightText);

    if (weight == null) {
      _showWarning('Weight must be a valid number');
      return;
    }

    if (height == null) {
      _showWarning('Height must be a valid number');
      return;
    }

    if (weight <= 0) {
      _showWarning('Weight must be greater than 0');
      return;
    }

    if (height <= 0) {
      _showWarning('Height must be greater than 0');
      return;
    }

    final double heightM = height / 100;
    final bmiInstance = Bmi(weightKg: weight, heightM: heightM);

    _history.addNewRecord(bmiInstance.value, heightM, weight, bmiInstance.type);

    setState(() {
      _bmi = bmiInstance.value;
      _advice = bmiInstance.advice;
    });
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgGreen,
      appBar: AppBar(
        backgroundColor: _bgGreen,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).maybePop(),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 12),
              Icon(Icons.arrow_back, color: Colors.white, size: 22),
              SizedBox(width: 4),
              Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        leadingWidth: 100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input card
            _buildInputCard(),
            const SizedBox(height: 20),

            // BMI result card
            if (_bmi != null) ...[
              _buildBmiCard(),
              const SizedBox(height: 24),

              // Advice section
              _buildAdviceSection(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInputCard() {
    return Container(
      decoration: BoxDecoration(
        color: _cardYellow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _borderGold, width: 7),
      ),
      padding: const EdgeInsets.fromLTRB(28, 36, 28, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Weight field
          const Text(
            'Weight ( kg. )',
            style: TextStyle(
              color: _darkGreen,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _weightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(color: _darkGreen, fontSize: 16),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: _darkGreen, width: 1.5),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: _darkGreen, width: 1.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: _darkGreen, width: 2),
              ),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 6),
            ),
          ),
          const SizedBox(height: 32),

          // Height field
          const Text(
            'Height ( cm. )',
            style: TextStyle(
              color: _darkGreen,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _heightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(color: _darkGreen, fontSize: 16),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: _darkGreen, width: 1.5),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: _darkGreen, width: 1.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: _darkGreen, width: 2),
              ),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 6),
            ),
          ),
          const SizedBox(height: 24),

          // Calculate + Clear buttons — right-aligned
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: _calculate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _borderGold,
                    foregroundColor: _darkGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  child: const Text('Calculate'),
                ),
                if (_bmi != null) ...[
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _clearHistory,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: _darkGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: _darkGreen, width: 1.5),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    child: const Text('Clear'),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBmiCard() {
    return Container(
      decoration: BoxDecoration(
        color: _cardYellow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _borderGold, width: 7),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          const Text(
            'BMI',
            style: TextStyle(
              color: _darkGreen,
              fontSize: 40,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            _bmi!.toStringAsFixed(2),
            style: const TextStyle(
              color: _brightGreen,
              fontSize: 44,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            '(kg/m²)',
            style: TextStyle(
              color: _darkGreen,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdviceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Advice :',
          style: TextStyle(
            color: _cardYellow,
            fontSize: 34,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          _advice,
          style: const TextStyle(
            color: _cardYellow,
            fontSize: 18,
            fontWeight: FontWeight.normal,
            height: 1.55,
          ),
        ),
      ],
    );
  }
}
