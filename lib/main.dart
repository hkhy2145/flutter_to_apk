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
  var x = "نص";
  int messageCount = 0;
  Timer? timer;

  Future<void> sendToDiscordWebhook(String message) async {
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
      setState(() {
        messageCount++;
      });
    } else {
      messageCount = -1;
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
        title: Text('إرسال رسالة إلى Discord'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('عدد الرسائل المرسلة: $messageCount'),
            ElevatedButton(
              onPressed: () {
                if (buttonPressed) {
                  x = ('توقف عن الإرسال');
                  buttonPressed = false;
                  timer = Timer.periodic(Duration(seconds: 10), (timer) {
                    sendToDiscordWebhook("نص الرسالة");
                  });
                } else {
                  x = ('ابدأ الإرسال');
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
