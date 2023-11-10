import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/controllers/auth_controllers.dart';
import 'package:notes/controllers/notes_controllers.dart';
import 'package:notes/utils/routes/routes.dart';
import 'package:notes/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NotesControllers()),
        ChangeNotifierProvider(create: (context) => AuthControllers()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        initialRoute: RoutesName.splashScreen,
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}

