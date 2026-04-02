import 'package:flutter/material.dart';
import '../api_service.dart';
import 'live_screen.dart';

class CamerasScreen extends StatefulWidget {
  @override
  _CamerasScreenState createState() => _CamerasScreenState();
}

class _CamerasScreenState extends State<CamerasScreen> {
  final ApiService api = ApiService();
  late Future<List> cameras;

  @override
  void initState() {
    super.initState();
    cameras = api.getCameras();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cameras')),
      body: FutureBuilder<List>(
        future: cameras,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final cam = data[index];
                return ListTile(
                  title: Text(cam['name']),
                  subtitle: Text(cam['location']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LiveScreen(url: cam['streamUrl']),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}