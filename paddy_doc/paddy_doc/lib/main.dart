import 'dart:convert'; // Add this line to import the dart:convert library
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:paddy_doc/history_page.dart';
import 'package:paddy_doc/model/history_model.dart';
import 'package:paddy_doc/second_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Paddy Disease Detection App',
      home: HomePage(),
    );
  }
}

List<HistoryModel> historyList = [];

class HomePage extends StatelessWidget {
  void addToHistoryList(XFile pickedFile, String date, String disease) async {
    // getting a directory path for saving
    final appDocDir = await getApplicationDocumentsDirectory();
    final String path = appDocDir.path;
    File file = File(pickedFile.path);

    // copy the file to a new path
    final File newImage =
        await file.copy('$path/image${historyList.length}.png');

    historyList.add(HistoryModel(
        imagePath: newImage.path,
        date: DateTime.now().toString(),
        diseaseIdentified: disease));
  }

  Future<void> _uploadImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print('Picked image path: ${pickedFile.path}');

      // Prepare the multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://138c-34-132-197-59.ngrok-free.app/upload'),
      );

      // Infer the file name and type from the picked file path
      String fileName = pickedFile.path.split('/').last;
      String fileType = fileName.split('.').last;

      // Add the image file to the request
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          pickedFile.path,
          contentType: MediaType('image', fileType),
        ),
      );

      // Send the request
      var response = await request.send();

      // Read and log the response
      var responseBody = await response.stream.bytesToString();
      print('Response: $responseBody');

      // Extract the predicted disease value from the API response
      final jsonResponse = jsonDecode(responseBody);
      final List<dynamic> predictedDiseaseList =
          jsonResponse['Predicted_disease'];
      final String predictedDisease =
          predictedDiseaseList.isNotEmpty ? predictedDiseaseList.first : '';

      //add this to history
      addToHistoryList(pickedFile, DateTime.now().toString(), predictedDisease);
      // Navigate to the second page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondPage(
            imagePath: pickedFile.path,
            predictedDisease: predictedDisease,
          ),
        ),
      );
    } else {
      // Handle case when image picking is canceled
      print('Image picking canceled');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Paddy Doc ML App', // Changed the app title
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 24.0,
              color: Color(0xFFFFFFFF),
            ),
          ),
          backgroundColor: const Color(0xFFA0C056),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HistoryPage(
                            historyList: historyList,
                          )),
                ),
                icon: const Icon(
                  Icons.history,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            )
          ]),
      backgroundColor: const Color(0xFFFFFFFF),
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
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Image.asset(
                    'assets/paddy_image.jpg',
                    height: 300.0,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Upload a picture to detect the paddy disease', // Added the description
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                ElevatedButton.icon(
                  onPressed: () {
                    _uploadImage(context);
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
