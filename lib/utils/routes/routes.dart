import 'package:flutter/material.dart';
import 'package:notes/app.dart';
import 'package:notes/utils/routes/routes_name.dart';
import 'package:notes/view/authantication/auth_screen.dart';
import 'package:notes/view/components/image_reader.dart';
import 'package:notes/view/components/pdf_reader.dart';
import 'package:notes/view/components/video_player.dart';
import 'package:notes/view/screens/create_notes_screen.dart';
import 'package:notes/view/screens/home_screen.dart';
import 'package:notes/view/screens/search_notes_screen.dart';
import 'package:notes/view/screens/update_notes_screen.dart';
import 'package:notes/view/splash_screen.dart';



class Routes {
  static MaterialPageRoute generateRoutes(RouteSettings settings) {
    switch (settings.name) {

      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (buildContext) => SplashSCreen());
   
      case RoutesName.searchScreen:
        return MaterialPageRoute(builder: (buildContext) => SearchNotesScreen());

      case RoutesName.createNotesScreen:
        return MaterialPageRoute(builder: (buildContext) => CreateNotesScreen());

      case RoutesName.home:
        return MaterialPageRoute(builder: (buildContext) => HomeScreen());

      case RoutesName.image:
        return MaterialPageRoute(builder: (buildContext) => HomeScreen());

      case RoutesName.fileReader:
      Object? notesData = settings.arguments;
        return MaterialPageRoute(builder: (buildContext) => PdfReader(notesData: notesData,));

      case RoutesName.imageReader:
      Object? notesData = settings.arguments;
        return MaterialPageRoute(builder: (buildContext) => ImageReader(notesData: notesData,));

      case RoutesName.videoReader:
      Object? notesData = settings.arguments;
        return MaterialPageRoute(builder: (buildContext) => CoustomVideoPlayer(notesData: notesData,));

      case RoutesName.app:
        return MaterialPageRoute(builder: (buildContext) => App());

      case RoutesName.updateNotesScreen:
      Object? notesData = settings.arguments;
        return MaterialPageRoute(builder: (buildContext) => UpdateNotesScreen(notesData: notesData,));

      case RoutesName.authantication:
        return MaterialPageRoute(builder: (buildContext) => AuthScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(child: Text("Default")),
          );
        });
    }
  }
}
