import 'package:bmi_app/history_function.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('latestRecord returns the most recent saved calculation', () {
    final history = BmiHistory();
    history.clearHistory();

    history.addNewRecord(22.0, 1.70, 60.0, 'Normal weight');
    history.addNewRecord(28.0, 1.70, 80.0, 'Overweight');

    expect(history.latestRecord?.bmi, 28.0);
    expect(history.latestRecord?.type, 'Overweight');
  });
}
