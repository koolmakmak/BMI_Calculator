class BmiRecord{
  final double bmi;
  final double heightM;
  final double weightKg;
  final String type;
  final String date;
  BmiRecord({required this.bmi, required this.heightM, required this.weightKg, required this.type, required this.date})
;}

class BmiHistory {
  static final List<BmiRecord> _history = [];

  List<BmiRecord> get history => _history;

  void addNewRecord(double bmi, double heightM, double weightKg, String type) {
    _history.add(
      BmiRecord(
        bmi: bmi, 
        heightM: heightM, 
        weightKg: weightKg,
        type: type,
        date: DateTime.now().toString())
    );
  }

  void clearHistory() {
    _history.clear();
  }
}