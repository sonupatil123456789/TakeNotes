// import 'package:flutter/material.dart';
// import 'package:flutter_quill/flutter_quill.dart';
// import 'package:notes/controllers/notes_controllers.dart';
// import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

// // ignore: must_be_immutable
// class NotesParaTextfield extends StatefulWidget {
//   Function getEditerData;
//   FocusNode FocusNodeNames;
//   NotesParaTextfield(
//       {super.key, required this.getEditerData, required this.FocusNodeNames});

//   @override
//   State<NotesParaTextfield> createState() => _NotesParaTextfieldState();
// }

// class _NotesParaTextfieldState extends State<NotesParaTextfield> {
//   NotesControllers notesController = NotesControllers();

//   @override
//   void initState() {
//     super.initState();
//     // notesController= Provider.of<NotesControllers>(context,listen: false);

//     notesController.quilEditerController.addListener(() {
//       final deltaJson =
//           notesController.quilEditerController.document.toDelta().toJson();
//       final converter = QuillDeltaToHtmlConverter(
//         List.castFrom(deltaJson),
//         ConverterOptions.forEmail(),
//       );
//       dynamic html = converter.convert();
//       dynamic htmldata = '$html';
//       print(htmldata);
//       widget.getEditerData(htmldata);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return QuillProvider(
//       configurations:
//           QuillConfigurations(controller: notesController.quilEditerController),
//       child: Column(
//         // mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Expanded(
//             child: QuillEditor(
//               focusNode: widget.FocusNodeNames,
//               configurations: QuillEditorConfigurations(
//                 readOnly: false,
//                 scrollable: true,
//                 padding: EdgeInsets.symmetric(horizontal: width * 0.04),
//                 autoFocus: false,
//                 expands: false, // true for view only mode
//               ),
//               scrollController: notesController.scrollController,
//             ),
//           ),
//           Container(
//             height: height * 0.08,
//             alignment: Alignment.centerLeft,
//             child: const SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: QuillToolbar(
//                 configurations: QuillToolbarConfigurations(
//                     showFontFamily: false,
//                     showSearchButton: false,
//                     showSubscript: false,
//                     axis: Axis.horizontal,
//                     toolbarSectionSpacing: 1.2),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
