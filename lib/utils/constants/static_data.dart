import 'package:flutter/material.dart';
import 'package:notes/models/drawer_model.dart';
import 'package:notes/utils/routes/routes_name.dart';
import 'package:notes/view/screens/file_screen.dart';
import 'package:notes/view/screens/home_screen.dart';
import 'package:notes/view/screens/image_screen.dart';
import 'package:notes/view/screens/notes_screen.dart';
import 'package:notes/view/screens/video_screen.dart';

class StaticData {

  static List<DrawerData> drawerDatas = [
    DrawerData( id: 1,name: "Home" , icon:Icons.home, navigateTo:RoutesName.home ),
    DrawerData( id: 2,name: "Notes" , icon:Icons.edit_square, navigateTo:RoutesName.notes),
    DrawerData( id: 5,name: "Images" , icon:Icons.photo_library, navigateTo:RoutesName.home ),
    DrawerData( id: 3,name: "File" , icon:Icons.attach_file, navigateTo:RoutesName.file ),
    DrawerData( id: 4,name: "Video" , icon:Icons.video_file, navigateTo:RoutesName.video ),
  ];

    static List bottomSheetData = [
      {
        "name":"Notes",
        "icon" :Icons.edit_square
      },
      {
        "name":"Image",
        "icon" :Icons.photo_library
      },
      {
        "name":"File",
        "icon" :Icons.attach_file
      },
       {
        "name":"Video",
        "icon" :Icons.video_file
      }
  ];

  static List screens = [
    HomeScreen(),
    NotesScreen(),
    ImageScreen(),
    FileScreen(),
    VideoScreen()
  ];

  List<String> noteCategories = [
  "Personal Notes",
  "Work Notes",
  "School/Study Notes",
  "To-Do Lists",
  "Meeting Notes",
  "Travel Notes",
  "Recipes",
  "Health and Fitness",
  "Financial Notes",
  "Creative Ideas",
  "Journal/Diary",
  "Reading Notes",
  "Project Management",
  "Bucket List",
  "Inspirational Quotes",
  "Gift Ideas",
  "Home Improvement",
  "Gardening Notes",
  "Hobbies and Interests",
  "Contacts and Addresses",
  "Passwords and Security",
  "Event Planning",
  "Art and Music",
  "Travel Logs",
  "Educational Resources",
  "Sustainability",
  "Gratitude Journal",
  "Pet Care",
  "Language Learning",
  "Emotional Wellbeing",
];



   
}
