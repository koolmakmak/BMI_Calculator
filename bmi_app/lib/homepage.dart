import 'package:flutter/material.dart';
import 'package:bmi_app/calculatepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Let calculate your BMI',
              style: TextStyle(fontSize: 80),
            ),
            const SizedBox(height: 80),
            ElevatedButton(onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const CalculatePage()),);
            }, child: const Text('Calculate'))
          ],
        ),
      )
    );
  }
}