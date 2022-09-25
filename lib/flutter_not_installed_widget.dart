import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FlutterNotInstalledWidget extends StatelessWidget {
  const FlutterNotInstalledWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/flutter-brand-icon.png'),
            const SizedBox(height: 20,),
            _flutterNotInstalledText()
          ],
        ),
      ),
    );
  }

  Widget _flutterNotInstalledText() {
    TextStyle defaultStyle = const TextStyle(
      fontSize: 30.0,
    );
    TextStyle linkStyle = const TextStyle(decoration: TextDecoration.underline,);
    return Text.rich(TextSpan(
      children: <TextSpan>[
        const TextSpan(text: "This tool required flutter command. You can install it by following this "),
        TextSpan(
            text: "documentation.",
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                await launchUrl(
                    Uri.parse('https://docs.flutter.dev/get-started/install/linux'),
                    mode: LaunchMode.externalNonBrowserApplication
                );
              })
      ],
    ),
      style: defaultStyle,
      textAlign: TextAlign.center,);
  }
}
