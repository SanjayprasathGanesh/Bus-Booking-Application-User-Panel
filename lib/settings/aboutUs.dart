import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  final String uEmail;
  final String downloadUrl = "https://example.com/expense_tracker_app.apk"; // Replace with actual download URL

  const AboutUs({Key? key, required this.uEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us",style: TextStyle(
          color: Colors.black,
          fontSize: 17.0,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('images/sanjay.jpg'),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Author Name: Sanjay Prasath Ganesh',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway',
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Designation: App Developer',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.grey,
                fontFamily: 'Raleway',
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Roles in App Designing',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway',
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              ' - Developed all aspects of the app',
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'Raleway',
              ),
            ),
            // Add more roles as needed
            const SizedBox(height: 16.0),
            const Text(
              'Additional Points',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway',
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              ' - Passionate about creating user-friendly experiences',
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'Raleway',
              ),
            ),
            const Text(
              ' - Committed to delivering high-quality software',
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'Raleway',
              ),
            ),
            // Add more points as needed
            const SizedBox(height: 16.0),
            const Text(
              'Studies',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway',
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              ' - Bachelor\'s in Computer Science, at Sri Shakthi Institute of Engineering and Technology',
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'Raleway',
              ),
            ),
            const Text(
              'Projects',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildProjectItem(
              context,
              'Expense Tracker Android Application',
                  () {
                _launchDownloadUrl();
              },
            ),
            // Add more study details as needed
          ],
        ),
      ),
    );
  }

  Widget _buildProjectItem(BuildContext context, String projectName, VoidCallback onPressed) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          projectName,
          style: const TextStyle(fontFamily: 'Raleway', fontSize: 16),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: onPressed,
          child: const Text(
            'Download',
            style: TextStyle(fontFamily: 'Raleway'),
          ),
        ),
      ],
    );
  }

  _launchDownloadUrl() async {
    if (await canLaunch(downloadUrl)) {
      await launch(downloadUrl);
    } else {
      throw 'Could not launch $downloadUrl';
    }
  }
}
