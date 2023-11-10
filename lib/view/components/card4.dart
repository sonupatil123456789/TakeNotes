import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:notes/utils/constants/assets.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class Card4 extends StatefulWidget {
  String title;
  String discription;
  dynamic index;
  dynamic notesData;
  Function slideToDelet;
  Function onPressButton;

  Card4({
    super.key,
    required this.title,
    required this.discription,
    required this.index,
    required this.slideToDelet,
    required this.onPressButton,
    required this.notesData,
  });

  @override
  State<Card4> createState() => _Card4State();
}

class _Card4State extends State<Card4> {

  @override
  void initState() {
    super.initState();

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
                height: screenhight * 0.15,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AssetImgLinks.videoPlayer, fit: BoxFit.contain, width: screenwidth*0.10,height: screenwidth*0.10,),
                  ],
                ) 
              )));
                
                
  }
}
