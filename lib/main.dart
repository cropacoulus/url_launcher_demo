import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('URL Launcher Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LaunchButton(
              onTap: () async {
                await call('+1-408-555-1212');
              },
              text: 'Call',
            ),
            LaunchButton(
              onTap: () async {
                await sendSms('+1-408-555-1212');
              },
              text: 'SMS',
            ),
            LaunchButton(
              onTap: () async {
                await sendEmail('rifkipanglima9@gmail.com');
              },
              text: 'Email',
            ),
            LaunchButton(text: 'URL External', onTap: () async {
              await openUrl('https://flutter.dev');
            },),
            LaunchButton(
              onTap: () async {
                await openUrlInWebView('https://flutter.dev');
              },
              text: 'URL WebView',
            ),
          ],
        ),
      ),
    );
  }
}

class LaunchButton extends StatelessWidget {
  const LaunchButton({Key? key, required this.text, this.onTap}) : super(key: key);

  final Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(text),
      ),
    );
  }
}

Future<void> call(String phoneNumber) async {
  await launchUrl(Uri.parse('tel:$phoneNumber'));
}

Future<void> sendSms(String phoneNumber) async {
  await launchUrl(Uri.parse('sms:$phoneNumber'));
}

Future<void> sendEmail(String email) async {
  await launchUrl(Uri.parse('mailto:$email'));
}

Future<void> openUrl(String url) async {
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  }
}

Future<void> openUrlInWebView(String url) async {
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url,
        mode: LaunchMode.inAppWebView,
        webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{
            'my_header_key': 'my_header_value',
          },
        ));
  } else {
    throw 'Could not launch $url';
  }
}
