import 'dart:convert';

import 'package:admin_quizz/home_page.dart';
import 'package:admin_quizz/models/questions.dart';
import 'package:admin_quizz/screens/questions/edit_questions.dart';
import 'package:admin_quizz/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class AllQuestions extends StatefulWidget {
  const AllQuestions({Key? key}) : super(key: key);

  @override
  _AllQuestionsState createState() => _AllQuestionsState();
}

class _AllQuestionsState extends State<AllQuestions> {
  late List<Questions>? questions = [];
  @override
  void initState() {
    //this.questions = List.of(allQuestions);
    getUsers();
    super.initState();
  }

  bool isLoading = false;
  Future<List<Questions?>?> getUsers() async {
    setState(() {
      isLoading = true;
    });
    questions!.clear();
    try {
      var url = Uri.parse(
          'https://rayanzinotblans.000webhostapp.com/get_question.php');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print('seccus get questions');
        final data = json.decode(response.body)["questions"];
        setState(() {
          for (Map<String, dynamic> i in data) {
            questions!.add(Questions.fromJson(i));
          }
        });
      } else {
        print('field get questions');
        print('Response status: ${response.statusCode}');
      }
    } catch (e) {
      print('field to try get questions');
      print(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questions / reponses'),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return HomePage();
                  },
                ),
              );
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: isLoading == false
          ? SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return EditQuestions();
                        }),
                      );
                    },
                    child: Container(
                      width: 150,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
                      ),
                      child: Center(
                        child: Text('ajout une question'),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        columns: getColumns([
                          'id',
                          'annee',
                          'semester',
                          'module',
                          'questions',
                          'reponse 1',
                          'repo1',
                          'reponse 2',
                          'repo2',
                          'reponse 3',
                          'repo3',
                          'reponse 4',
                          'repo4',
                          'reponse 5',
                          'repo5',
                        ]),
                        rows: getRows(questions!)),
                  ),
                ],
              ),
            )
          : Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Chargement...'),
                ],
              ),
            ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      return DataColumn(
        label: Text(column),
      );
    }).toList();
  }

  List<DataRow> getRows(List<Questions> question) =>
      question.map((Questions question) {
        final cells = [
          question.id,
          question.annee,
          question.semestre,
          question.module,
          question.question,
          question.rep1,
          question.respo1,
          question.rep2,
          question.respo2,
          question.rep3,
          question.respo3,
          question.rep4,
          question.respo4,
          question.rep5,
          question.respo5,
        ];

        return DataRow(
          cells: Utils.modelBuilder(cells, (index, cell) {
            final showEditIcon = index == 0;
            return DataCell(
              Text('$cell'),
              showEditIcon: showEditIcon,
              onTap: () {
                Map<String, String>? quest = {
                  'id': question.id,
                  'annee': question.annee,
                  'semestre': question.semestre,
                  'module': question.module,
                  'question': question.question,
                  'rep1': question.rep1,
                  'respo1': question.respo1,
                  'rep2': question.rep2,
                  'respo2': question.respo2,
                  'rep3': question.rep3,
                  'respo3': question.respo3,
                  'rep4': question.rep4,
                  'respo4': question.respo4,
                  'rep5': question.rep5,
                  'respo5': question.respo5,
                };
                Navigator.of(context)
                    .pushNamed(EditQuestions.screenName, arguments: quest);

                print('edit');
              },
            );
          }),
        );
      }).toList();
}
