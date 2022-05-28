import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

//Starting widget with upload button and logo
class StartPageWidget extends StatelessWidget {
  const StartPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
              allowMultiple: true,
              type: FileType.custom,
              allowedExtensions: ['pdf']);

          if (result != null) {
            for (var element in result.names) {
              print(element);
            }
          }
        },
        child: const Text("Upload files (pdf)"),
      ),
    );
  }
}
