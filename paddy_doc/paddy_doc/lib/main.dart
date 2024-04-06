import 'package:flutter/material.dart';
import 'package:paddy_doc/second_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paddy Disease Detection App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  Future<void> _uploadImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      print('Picked image path: ${pickedFile.path}');

      // Prepare the multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://3add-34-106-111-180.ngrok-free.app/upload'),
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

      // Navigate to the second page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondPage(imagePath: pickedFile.path),
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
                  'Hello, Flutter!',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
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
