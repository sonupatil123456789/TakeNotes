import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class Card3 extends StatefulWidget {
  String title;
  String discription;
  dynamic index;
  dynamic notesData;
  Function slideToDelet;
  Function onPressButton;

  Card3({
    super.key,
    required this.title,
    required this.discription,
    required this.index,
    required this.slideToDelet,
    required this.onPressButton,
    required this.notesData,
  });

  @override
  State<Card3> createState() => _Card3State();
}

class _Card3State extends State<Card3> {
  PdfViewerController controller = PdfViewerController();

  late dynamic document = null;

  @override
  void initState() {
    super.initState();

    Future pdfViewer(pdf) async {
       document = await PDFDocument.fromURL(pdf);
       setState(() {
         
       });
    }
    pdfViewer(widget.discription);
  }

  Widget build(BuildContext context) {
    final dynamic screenhight = MediaQuery.of(context).size.height;
    final dynamic screenwidth = MediaQuery.of(context).size.width;
    return InkWell(
        onTap: () {
          widget.onPressButton(widget.index, widget.notesData);
        },
        child: Dismissible(
            key: Key(widget.index.toString()),
            onDismissed: (direction) {
              widget.slideToDelet(widget.index);
            },
            child: Container(
                width: screenwidth * 0.46,
                height: screenhight * 0.30,
                decoration: BoxDecoration(
                  color: HexColor('#FFFFFF'),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x337c99b3),
                      blurRadius: 30,
                      offset: Offset(6, 6),
                    ),
                    BoxShadow(
                      color: Color(0x1c5690c5),
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),

                child: document == null ? const Center(child: Text("Loading..."))
              : ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: PDFViewer(
                  progressIndicator:const Center(child: Text("Loading...")) ,
                  document: document,
                  showIndicator: false,
                  enableSwipeNavigation: true,
                  showNavigation: false,
                  showPicker: false,
                  
                  ),
              )
              )));
                
                
  }
}
