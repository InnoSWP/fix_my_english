import 'package:fix_my_english/analysis_data.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'analyzed_text_widget.dart';
import 'api_interactions.dart';
import 'pdf_reader.dart';

///Starting page widget with upload button, text field, and logo
class StartPageWidget extends StatelessWidget {
  //Callback that called after user upload files
  final Function(List<Future<AnalysisData>>) onFileUploaded;
  //Controller to get text from text field
  final TextEditingController textEditingController = TextEditingController();

  StartPageWidget({Key? key, required this.onFileUploaded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              maxLines: 4,
              keyboardType: TextInputType.multiline,
              controller: textEditingController,
            ),
            ElevatedButton(
              onPressed: () {
                //If user typed something into text field send it to IExtract API, then call callback
                onFileUploaded([sendToIExtract(textEditingController.text)]);
              },
              child: const Text("Upload as text"),
            ),
            ElevatedButton(
              onPressed: () async {
                //Pick pdf files from device
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                    allowMultiple: true,
                    type: FileType.custom,
                    allowedExtensions: ['pdf']);

                if (result != null) {
                  //If user picked something, then extract text and send to IExtract API, then call callback
                  onFileUploaded([
                    sendToIExtract(
                        PDFToRawTextConverter(result.files[0].bytes!).result)
                  ]);
                }
              },
              child: const Text("Upload files (pdf)"),
            ),
          ],
        ),
      )),
    );
  }
}

///Main page widget. Works with futures to show text analyses
class MainPageWidget extends StatefulWidget {
  //List with all analyses that user has
  final List<Future<AnalysisData>> analysisRequests = [];

  MainPageWidget({Key? key}) : super(key: key);

  ///Adds new analysis to list. Needs future of AnalysisData [request]
  void addNewAnalysis(Future<AnalysisData> request) {
    analysisRequests.add(request);
  }

  ///Adds multiple analysis to list. Needs list of futures of AnalysisData [request]
  void addManyAnalyses(List<Future<AnalysisData>> requests) {
    for (Future<AnalysisData> request in requests) {
      analysisRequests.add(request);
    }
  }

  @override
  State<MainPageWidget> createState() => _MainPageWidget();
}

///Class that represents state controll of MainPageWidget
class _MainPageWidget extends State<MainPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnalyzedTextWidget(
          analysis: widget.analysisRequests.first,
        ),
      ),
    );
  }
}
