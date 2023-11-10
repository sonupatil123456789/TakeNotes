import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class ImageReader extends StatelessWidget {
  dynamic notesData;

  ImageReader({
    super.key,
    required this.notesData,
  });



  Widget build(BuildContext context) {
    final dynamic screenhight = MediaQuery.of(context).size.height;
    final dynamic screenwidth = MediaQuery.of(context).size.width;
    dynamic data = notesData['notesData'];

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
              ),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    data['paragraph'],
                    fit: BoxFit.contain,
                  )))),
    );
  }
}
