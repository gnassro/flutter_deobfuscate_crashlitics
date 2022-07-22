
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textObfuscatedController = TextEditingController(text: '');
  final TextEditingController _filePathController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _textObfuscatedController,
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.multiline,
                    expands: true,
                    maxLines: null,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(9),
                      filled: true,
                    ),
                  ),
                )
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                FilePickerResult? result = await FilePicker.platform.pickFiles();

                                if (result != null) {
                                  _filePathController.text = result.files.single.path ?? '';
                                }
                              },
                              child: const Text('Pick Symbols file')),
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: TextField(
                                  controller: _filePathController,
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(9),
                                    filled: true,
                                  ),
                                ),
                              )
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: ElevatedButton.icon(
                                onPressed: () async {
                                  var result = await Process.run('flutter', ['doctor']);
                                  stdout.write(result.stdout);
                                },
                                label: const Text('Process'),
                              icon: const Icon(
                                Icons.arrow_left,
                                color: Colors.white,
                            ),),
                          )
                        ],
                      )
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
