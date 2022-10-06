import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_deobfuscate_crashlytics/flutter_not_installed_widget.dart';
import 'package:flutter_deobfuscate_crashlytics/home_page.dart';
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
    var result = await Process.run(
      'bash', ['-c', 'which flutter'],
      runInShell: true,
    );

    talker.log('${result.exitCode}');
    if (result.exitCode != 0) {
      talker.error('COMMAND ERROR: ${result.stdout}');
    }

    runApp(MyApp(flutterInstalled: result.exitCode == 0,));
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

