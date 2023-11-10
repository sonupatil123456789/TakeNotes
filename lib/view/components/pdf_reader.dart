import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class PdfReader extends StatefulWidget {
  dynamic notesData;

  PdfReader({
    super.key,
    required this.notesData,
  });

  @override
  State<PdfReader> createState() => _PdfReaderState();
}

class _PdfReaderState extends State<PdfReader> {
  PdfViewerController controller = PdfViewerController();

  late dynamic document = null;

  late dynamic data = null;

  @override
  void initState() {
    super.initState();

    data = widget.notesData['notesData'];
    Future pdfViewer(pdf) async {
      document = await PDFDocument.fromURL(pdf);
      setState(() {});
    }

    pdfViewer(data['paragraph']);
  }

  Widget build(BuildContext context) {
    final dynamic screenhight = MediaQuery.of(context).size.height;
    final dynamic screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#000000"),
        title: Text(data['title']),
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: InkWell(
          onTap: () {
            // widget.onPressButton(widget.index, widget.notesData);
          },
          child: Container(
              width: screenwidth,
              height: screenhight,
              decoration: BoxDecoration(
                color: HexColor('#000000'),
                borderRadius: BorderRadius.circular(10),
              ),
              child: document == null
                  ? const Center(child: Text("Loading..."))
                  : PDFViewer(
                      scrollDirection: Axis.vertical,
                      progressIndicator:
                          const Center(child: Text("Loading...")),
                      document: document,
                      showIndicator: false,
                      enableSwipeNavigation: true,
                      showNavigation: false,
                      showPicker: false,
                    ))),
    );
  }
}
