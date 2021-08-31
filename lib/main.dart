import 'package:admin_quizz/home_page.dart';
import 'package:admin_quizz/screens/diagnostics/edit_diag.dart';
import 'package:admin_quizz/screens/modules/edit_module.dart';
import 'package:admin_quizz/screens/questions/edit_questions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin medQUIZZ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        EditModult.screenName: (context) => EditModult(),
        EditQuestions.screenName: (context) => EditQuestions(),
        EditDiag.screenName: (context) => EditDiag(),
      },
    );
  }
}
