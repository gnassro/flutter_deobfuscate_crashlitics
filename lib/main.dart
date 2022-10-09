import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_deobfuscate_crashlytics/flutter_not_installed_widget.dart';
import 'package:flutter_deobfuscate_crashlytics/home_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:process_run/utils/process_result_extension.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:yaru/yaru.dart';
import 'package:hive_flutter/hive_flutter.dart';

final talker = Talker(
    loggerOutput: debugPrint,
    loggerSettings: const TalkerLoggerSettings(
        enableColors: true
    )
);

void main() async {
  runZonedGuarded(() async {
    await Hive.initFlutter();
    await Hive.openBox<String>('flutter_path');

    Directory appDocDir = await getApplicationSupportDirectory();
    String appDocPath = appDocDir.path;
    talker.info('Working directory: $appDocPath');
    var lsCommand = await Process.run(
        'eval', ['echo "\$PATH"'],
        runInShell: true,
        workingDirectory: appDocPath
    );
    talker.info(lsCommand.outText);

    var result = await Process.run(
      'flutter', ['doctor', '-v'],
      runInShell: true,
      workingDirectory: appDocPath
    );

    talker.info('${result.exitCode}');
    if (result.exitCode != 0) {
      talker.error('COMMAND ERROR: ${result.outText} \n ${result.errText}');
    }
    else {
      talker.info('Flutter info: ${result.outText}');
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

