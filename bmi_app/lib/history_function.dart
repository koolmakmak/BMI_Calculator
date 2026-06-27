class BmiRecord{
  final double bmi;
  final double heightM;
  final double weightKg;
  final String type;
  final String date;
  BmiRecord({required this.bmi, required this.heightM, required this.weightKg, required this.type, required this.date})
;}

class BmiHistory {
  BmiHistory._internal();

  static final BmiHistory _instance = BmiHistory._internal();

  factory BmiHistory() => _instance;

  static final List<BmiRecord> _history = [];

  List<BmiRecord> get history => _history;

  BmiRecord? get latestRecord => _history.isEmpty ? null : _history.last;

  void addNewRecord(double bmi, double heightM, double weightKg, String type) {
    _history.add(
      BmiRecord(
        bmi: bmi,
        heightM: heightM,
        weightKg: weightKg,
        type: type,
        date: DateTime.now().toString(),
      ),
    );
  }

  void clearHistory() {
    _history.clear();
  }
}