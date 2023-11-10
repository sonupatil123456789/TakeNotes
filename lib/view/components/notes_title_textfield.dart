import 'package:flutter/material.dart';


class NotesTextfield extends StatelessWidget {
  String placeholder;
  double width;
  late TextEditingController controller;
  dynamic coustomStyle;
  FocusNode FocusNodeNames ;
  var changeFocusNode;
  var maxline;
  Function getTextData ;

  NotesTextfield({
    super.key,
    required this.placeholder,
    required this.width,
    required this.controller,
    required this.maxline,
    required this.FocusNodeNames,
    required this.changeFocusNode,
    required this.coustomStyle,
    required this.getTextData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.deepOrange,
          width: width,
          child: TextFormField(
              // onEditingComplete: () => FocusScope.of(context).nextFocus(),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (String value) {
                FocusScope.of(context).requestFocus(changeFocusNode);
              },
              autocorrect: true,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
               keyboardType: TextInputType.multiline,
               maxLines: null,
              validator: (value) {},
              controller: controller,
              focusNode: FocusNodeNames,
              style: coustomStyle,
              onChanged: (value) {
                getTextData(value);
                
              },
              decoration: InputDecoration(
                hintText: placeholder,
                isDense: true,
                hintStyle: coustomStyle,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide:
                      BorderSide(color: Colors.transparent, width: 1),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide:
                      BorderSide(color: Colors.transparent, width: 1),
                ),
              )),
        );

  }
}
