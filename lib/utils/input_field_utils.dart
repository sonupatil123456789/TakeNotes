
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InputFielUtils {
  // late String getFilePath = "";
  // late String getFileName = "";
  // late String getFileExtensionName = "";
  // late File imageFile = File("");
  // late Map imageDetails = <dynamic, dynamic>{};

  // late Map<String, String> inputFieldData;



// login text controllers 
    static TextEditingController nameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passowrdController = TextEditingController();
   static TextEditingController numberController = TextEditingController();

// login focus nodes 
  static FocusNode emailFocusNode = FocusNode();
  static FocusNode passwordFocusNode = FocusNode();
  static FocusNode nameFocusNode = FocusNode();
  static FocusNode numberFocusNode = FocusNode();



  static TextEditingController titleController = TextEditingController();
  static TextEditingController paragraphController = TextEditingController();
  
  static  FocusNode paragraphTextFocusnode  = FocusNode();
  static  FocusNode titleTextFocusnode  = FocusNode();

  static final scaffoldKey = GlobalKey<ScaffoldState>();


  static Future getMyFile(List<String> allowedExtension,FileType fileType) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: fileType, 
        allowedExtensions: allowedExtension,
      );

      if (result != null) {

      PlatformFile file = result.files.first;
       if (kDebugMode) {
        print('File picked: ${file.name}');
        print('File picked: ${file.extension}');
        print('File path: ${file.path}');
        print('File size: ${file.size}');
       }
       

      return file;
      
      } else {
        // User canceled the file picker
        print('File picking canceled');
      }
    } catch (e) {

      print('Error picking file: $e');
    }
  }




}
