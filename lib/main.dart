import 'package:admin_quizz/home_page.dart';
import 'package:admin_quizz/screens/diagnostics/edit_diag.dart';
import 'package:admin_quizz/screens/modules/edit_module.dart';
import 'package:admin_quizz/screens/questions/edit_questions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin medQUIZZ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        EditModult.screenName: (context) => const EditModult(),
        EditQuestions.screenName: (context) => const EditQuestions(),
        EditDiag.screenName: (context) => const EditDiag(),
      },
    );
  }
}
