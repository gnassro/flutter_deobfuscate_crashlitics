import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_deobfuscate_crashlytics/flutter_not_installed_widget.dart';
import 'package:flutter_deobfuscate_crashlytics/home_page.dart';
import 'package:process_run/which.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:yaru/yaru.dart';

final talker = Talker(
    loggerOutput: debugPrint,
    loggerSettings: const TalkerLoggerSettings(
        enableColors: true
    )
);

void main() async {
  runZonedGuarded(() async {
    var isFlutterInstalled = await which('flutter');

    talker.log('$isFlutterInstalled');
    if (isFlutterInstalled == null) {
      talker.error('COMMAND ERROR: Flutter not installed');
    }

    runApp(MyApp(flutterInstalled: isFlutterInstalled != null,));
  }, (error, stack) {
    talker.handle(error, stack, 'Uncaught app exception');
  });

}

class MyApp extends StatelessWidget {
  final bool flutterInstalled;

  const MyApp({
    Key? key,
    required this.flutterInstalled
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter De-obfuscate Crashlytics's Stacktrace",
      debugShowCheckedModeBanner: false,
      home: YaruTheme(
        child: flutterInstalled ? const HomePage() : const  FlutterNotInstalledWidget(),
      ),
    );
  }
}

