import 'package:flutter/material.dart';

class Bmi {
  final double weightKg;
  final double heightM;
  const Bmi({required this.weightKg, required this.heightM});

  double get value {
    if (weightKg <= 0 || heightM <= 0 || heightM > 2.5 || weightKg > 250) {
      return 0;
    }
    return weightKg / (heightM * heightM);
  }

  String get type {
    final bmi = value;
    if (bmi == 0) return 'Invalid';
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal weight';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  String get advice {
    switch (type) {
      case 'Underweight':
        return 'You are below the normal weight range. Try to eat more food and go bulk.';
      case 'Normal weight':
        return 'Your BMI is within the healthy range. Good Boy!';
      case 'Overweight':
        return 'You are above the healthy weight range. More regular exercise and a healthier diet.';
      case 'Obese':
        return 'Your BMI is in the obese range. Consult with Pun for personalized Gym training.';
      default:
        return 'Please enter valid weight and height values.';
    }
  }
}
