import 'dart:io';
import 'package:flutter/material.dart';
import 'package:paddy_doc/main.dart';

class SecondPage extends StatelessWidget {
  final String imagePath;
  final String predictedDisease;

  SecondPage({required this.imagePath, required this.predictedDisease});

  // Create a dictionary with the key-value pairs for disease remedies
  final Map<String, String> diseaseRemedies = {
    'bacterial_leaf_blight': '''
    - Plant resistant varieties.
    - Avoid water stagnation in fields.
    - Crop rotation.
    - Use balanced fertilization to avoid excessive nitrogen application.
  ''',
    'bacterial_leaf_streak': '''
    - Practice field sanitation by removing crop residues.
    - Crop rotation with non-host crops.
    - Plant resistant varieties if available.
    - Application of copper-based bactericides.
  ''',
    'bacterial_panicle_blight': '''
    - Use disease-free seeds.
    - Avoid overhead irrigation to reduce humidity.
    - Timely application of fungicides.
    - Crop rotation and field sanitation.
  ''',
    'blast': '''
    - Plant resistant varieties.
    - Balanced fertilization to avoid excessive nitrogen.
    - Proper water management to prevent waterlogged conditions.
    - Application of fungicides at the early stages of the disease.
  ''',
    'brown_spot': '''
    - Crop rotation.
    - Proper water management.
    - Use disease-free seeds.
    - Timely application of fungicides.
    - Balanced fertilization practices.
  ''',
    'dead_heart': '''
    - Use resistant varieties.
    - Field sanitation to remove crop residues.
    - Biological control methods for pest management.
    - Early detection and removal of affected plants.
  ''',
    'downy_mildew': '''
    - Improve field drainage.
    - Timely removal of infected plant debris.
    - Plant resistant varieties.
    - Fungicide application during the early stages of the disease.
  ''',
    'hispa': '''
    - Use resistant varieties.
    - Implement biological control methods such as introducing natural predators.
    - Use chemical control methods if infestation is severe, following recommended dosages.
  ''',
    'normal': '''
    - Practice good agricultural practices to maintain plant health.
    - Monitor crops regularly for any signs of diseases or pests.
    - Ensure proper water and nutrient management.
    - Use disease-resistant or tolerant varieties whenever possible.
  ''',
    'tungro': '''
    - Use resistant varieties.
    - Control the population of insect vectors through appropriate measures such as insecticides or biological control agents.
    - Remove and destroy infected plants to prevent further spread.
    - Planting healthy seedlings and avoiding waterlogging can also help in managing Tungro.
  '''
  };

  @override
  Widget build(BuildContext context) {
    // Get the remedy for the predicted disease
    String remedy =
        diseaseRemedies[predictedDisease.toLowerCase()] ?? 'Remedy not found';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
              (route) => false),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Result',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 24.0,
            color: Color(0xFFFFFFFF),
          ),
        ),
        backgroundColor: const Color(0xFFA0C056),
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
