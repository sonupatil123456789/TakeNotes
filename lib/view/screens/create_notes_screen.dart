import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:notes/controllers/notes_controllers.dart';
import 'package:notes/view/components/notes_title_textfield.dart';
import 'package:provider/provider.dart';
import '../../utils/input_field_utils.dart';

class CreateNotesScreen extends StatefulWidget {
  CreateNotesScreen({super.key});

  @override
  State<CreateNotesScreen> createState() => _CreateNotesScreenState();
}

class _CreateNotesScreenState extends State<CreateNotesScreen> {

  NotesControllers notesController = NotesControllers();
 


  @override
  void initState() {
     notesController= Provider.of<NotesControllers>(context,listen: false);
     notesController.setTitle("");
     notesController.setParagraph("");
    InputFielUtils.titleController.clear();
    InputFielUtils.paragraphController.clear();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final dynamic screenhight = MediaQuery.of(context).size.height;
    final dynamic screenwidth = MediaQuery.of(context).size.width;

    return Consumer<NotesControllers>(
      builder:
          (BuildContext context, NotesControllers notesValue, Widget? child) {
        return WillPopScope(
          onWillPop: () async {
            if (notesValue.notesTitleText.toString().isEmpty ||
                notesValue.notesParagraphText.toString().isEmpty) {
            InputFielUtils.titleController.clear();
                    InputFielUtils.paragraphController.clear();
              Navigator.pop(context);
              return false;
            } else {
              Map<String, dynamic> data = {
                "title": notesValue.notesTitleText.toString(),
                "paragraph": notesValue.notesParagraphText.toString()
              };
              notesValue.uploadNotesControllerData(context,notesValue.seassionData['uid'] , "TEXT-NOTES", data);
              InputFielUtils.titleController.clear();
                    InputFielUtils.paragraphController.clear();
              Navigator.pop(context);
              return true;
            }
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: HexColor("#133C58"),
              title: const Text("Add a note"),
              leading: InkWell(
                onTap: () async {
                  if (notesValue.notesTitleText.toString().isEmpty &&
                      notesValue.notesParagraphText.toString().isEmpty) {
                    InputFielUtils.titleController.clear();
                    InputFielUtils.paragraphController.clear();
                    Navigator.pop(context);
                  } else {
                    Map<String, dynamic> data = {
                      "title": notesValue.notesTitleText.toString(),
                      "paragraph": notesValue.notesParagraphText.toString()
                    };
                    notesValue.uploadNotesControllerData(context,notesValue.seassionData['uid'] , "TEXT-NOTES", data);
                    InputFielUtils.titleController.clear();
                    InputFielUtils.paragraphController.clear();
                    Navigator.pop(context);
                  }
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                width: screenwidth,
                height: screenhight * 0.90,
                // color: Colors.amber,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenhight * 0.02,
                        ),
                        NotesTextfield(
                          controller: InputFielUtils.titleController,
                          maxline: 1,
                          placeholder: 'Title',
                          width: screenwidth * 0.96,
                          FocusNodeNames: InputFielUtils.titleTextFocusnode,
                          changeFocusNode:
                              InputFielUtils.paragraphTextFocusnode,
                          coustomStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: screenwidth * 0.056,
                              color: HexColor('#000000')),
                          getTextData: (value) {
                        
                            notesValue.setTitle(value);
                          },
                        ),
                        NotesTextfield(
                          controller: InputFielUtils.paragraphController,
                          maxline: 1,
                          placeholder: 'Add a note',
                          width: screenwidth * 0.96,
                          FocusNodeNames: InputFielUtils.paragraphTextFocusnode,
                          changeFocusNode:
                              InputFielUtils.paragraphTextFocusnode,
                          coustomStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: screenwidth * 0.036,
                              color: HexColor('#000000')),
                          getTextData: (value) {
                            notesValue.setParagraph(value);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
