import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var buttonPressed = false;
  var x = "text";
  int messageCount = 0;
  Timer? timer;

  Future<void> sendToDiscordWebhook(String message) async {
    //print("start timer");
    String webhookUrl =
        "https://discord.com/api/webhooks/1165290854416646225/NFI2Puw2SYeWNetzEm9sr_KtCSjEA-6CS54hTQZDCy7LD-EYLuv0rM2oioO7ObazFZvU";
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, dynamic> data = {'content': message};
    final String jsonData = json.encode(data);

    final response = await http.post(
      Uri.parse(webhookUrl),
      headers: headers,
      body: jsonData,
    );

    if (response.statusCode == 204) {
      //print('Message sent successfully to Discord webhook');
      setState(() {
        messageCount++;
      });
    } else {
      //print(
          'Failed to send message to Discord webhook. Status code: ${response.statusCode}');
      //print('Response body: ${response.body}');
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discord Message Sender'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Messages Sent: $messageCount'),
            ElevatedButton(
              onPressed: () {
                if (buttonPressed) {
                  x = ('Stop Sending');
                  buttonPressed = false;
                  const Timer.periodic(Duration(seconds: 10), (timer) {
                    sendToDiscordWebhook("hkhttat now");
                  });
                } else {
                  x = ('Start Sending');
                  buttonPressed = true;
                }
              },
              child: Text(x),
            ),
          ],
        ),
      ),
    );
  }
}
