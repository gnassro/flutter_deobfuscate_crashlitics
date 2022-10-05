import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:yaru/yaru.dart';

import '../main.dart';


class LogButton extends StatelessWidget {
  const LogButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => YaruTheme(
                    child: TalkerScreen(talker: talker)
                ),
              )
          );
        },
        child: const Text('Log')
    );
  }
}
