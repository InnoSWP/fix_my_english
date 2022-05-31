import 'package:syncfusion_flutter_pdf/pdf.dart';

//Class to convert PDF (in bytes format) to solid text
//Usage: PDFToRawTextConverter(bytes).result -> returns String
class PDFToRawTextConverter {
  final List<int> bytes;
  late final String result;

  PDFToRawTextConverter(this.bytes) {
    //Load the PDF document by bytes
    PdfDocument document = PdfDocument(inputBytes: bytes);

    //Create the new instance of the PdfTextExtractor.
    PdfTextExtractor extractor = PdfTextExtractor(document);

    //Extract all the text from the document.
    result = extractor.extractText();

    //Dispose document
    document.dispose();
  }
}
