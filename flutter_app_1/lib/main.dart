import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import 'second_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paddy Disease Detection App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/second': (context) => SecondPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  Future<void> _uploadImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Image picked successfully, print the file path
      print('Picked image path: ${pickedFile.path}');

      // Proceed to upload the image to the server
      File imageFile = File(pickedFile.path);

      // Prepare the multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://830e-34-16-178-115.ngrok-free.app/upload'),
      );

      // Add the image file to the request
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          imageFile.path,
          contentType: MediaType('image', 'png'),
        ),
      );

      // Send the request
      var response = await request.send();

      // Check the response status
      if (response.statusCode == 200) {
        // Image successfully uploaded
        // Parse the response JSON
        final responseBody = await response.stream.bytesToString();
        final parsedResponse = jsonDecode(responseBody);

        // Extract predicted disease from the response
        final predictedDisease = parsedResponse['Predicted_disease'];

        // Navigate to the second page and pass the predicted disease as argument
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SecondPage(predictedDisease: predictedDisease),
          ),
        );
      } else {
        // Handle upload error
        print('Error uploading image: ${response.reasonPhrase}');
      }
    } else {
      // User canceled image picking
      print('Image picking canceled');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Paddy Disease Detection App',
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
      body: Column(
        children: [
          Container(
            height: 16.0,
            color: Colors.white,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Image.asset(
                    'assets/paddy_image.jpg',
                    height: 300.0,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Paddy Doc ML App',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Upload a picture to\ndetect the paddy disease',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton.icon(
                  onPressed: () {
                    _uploadImage(context); // Call the function to pick image from gallery
                  },
                  icon: Icon(
                    Icons.upload_rounded,
                    color: Colors.white70,
                  ),
                  label: Text(
                    'Upload',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFFA0C056)),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    shadowColor: MaterialStateProperty.all(
                        Colors.black.withOpacity(0.5)),
                    elevation: MaterialStateProperty.all(5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
