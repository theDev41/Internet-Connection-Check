import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Internet_connection_main());
}


class Internet_connection_main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckConnectionPage(),
    );
  }
}

class CheckConnectionPage extends StatefulWidget {
  @override
  _CheckConnectionPageState createState() => _CheckConnectionPageState();
}

class _CheckConnectionPageState extends State<CheckConnectionPage> {
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  Future<void> _checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        _isConnected = true;
      });

      // Navigate to the main page after a short delay
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      });
    } else {
      setState(() {
        _isConnected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isConnected
            ? Text(
          'Connected! Redirecting...',
          style: TextStyle(fontSize: 20, color: Colors.green),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No Internet Connection',
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkInternetConnection,
              child: Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main Page')),
      body: Center(
        child: Text('Welcome to the Main Page!',
            style: TextStyle(fontSize: 24)),
      ),
    );
  }
}