import 'dart:io';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final String imagePath;
  final String predictedDisease;

  SecondPage({required this.imagePath, required this.predictedDisease});

  // Create a dictionary with the key-value pairs for disease remedies
  final Map<String, String> diseaseRemedies = {
    'blast': 'Test remedy',
  };

  @override
  Widget build(BuildContext context) {
    // Get the remedy for the predicted disease
    String remedy = diseaseRemedies[predictedDisease.toLowerCase()] ?? 'Remedy not found';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Result',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 24.0,
            color: Color(0xFFFFFFFF),
          ),
        ),
        backgroundColor: Color(0xFFA0C056),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Color(0xFFF7F8DF).withOpacity(0.9),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Image.file(
                        File(imagePath),
                        height: 150.0,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        predictedDisease,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Color(0xFFF7F8DF).withOpacity(0.9),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Remedy',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        remedy,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
