import 'package:flutter/material.dart';
import 'package:flutter_deobfuscate_crashlytics/home_page.dart';
import 'package:yaru/yaru.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter De-obfuscate Crashlytics log',
      debugShowCheckedModeBanner: false,
      home: YaruTheme(
        child: HomePage(),
      ),
    );
  }
}