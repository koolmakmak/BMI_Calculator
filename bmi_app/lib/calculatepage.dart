import 'package:flutter/material.dart';

class CalculatePage extends StatelessWidget {
  const CalculatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculate BMI'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text(
          'นี่คือหน้าคำนวณ BMI',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}