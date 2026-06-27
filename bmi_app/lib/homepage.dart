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
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(300),
                border: Border.all(
                  color: Color.fromRGBO(209, 194, 127, 1),
                  width: 10,
                ),
                image: const DecorationImage(
                  image: AssetImage('assets/images/Chen1.jpg'),
                  fit: BoxFit.cover,
                )
              ),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(209, 194, 127, 1),
              )
              ,onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const CalculatePage()),);
            }, child: const Text('Calculate', style: TextStyle(color: Colors.black),))
          ],
        ),
      )
    );
  }
}