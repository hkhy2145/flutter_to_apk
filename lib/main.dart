import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key); // أضفت مُعرِّف "key" هنا
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String latestSms = "No SMS available";

  Future<void> fetchLatestSms() async {
    Telephony telephony = Telephony.instance;
    List<SmsMessage> messages = await telephony.getInboxSms();
    if (messages.isNotEmpty) {
      SmsMessage latestMessage = messages.first;
      setState(() {
        latestSms = "Latest SMS: ${latestMessage.body}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SMS Reader'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(latestSms),
            ElevatedButton(
              onPressed: fetchLatestSms,
              child: const Text('Fetch Latest SMS'),
            ),
          ],
        ),
      ),
    );
  }
}
