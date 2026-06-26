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
      backgroundColor: const Color.fromRGBO(83, 157, 121, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Let calculate your BMI',
              style: TextStyle(fontSize: 80, color: Colors.white),
            ),
            const SizedBox(height: 60),
            Image.asset('assets/images/Chen1.jpg', width: 250, height: 250, fit: BoxFit.cover),
            const SizedBox(height: 60),
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