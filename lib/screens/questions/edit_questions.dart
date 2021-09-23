import 'dart:convert';

import 'package:admin_quizz/screens/questions/all_questions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditQuestions extends StatefulWidget {
  static const screenName = "EditQuestions";
  @override
  _EditQuestionsState createState() => _EditQuestionsState();
}

class _EditQuestionsState extends State<EditQuestions> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController idController = TextEditingController();
  TextEditingController anneeController = TextEditingController();
  TextEditingController semestreController = TextEditingController();
  TextEditingController questionsController = TextEditingController();
  TextEditingController moduleController = TextEditingController();
  TextEditingController reponse1Controller = TextEditingController();
  TextEditingController reponse2Controller = TextEditingController();
  TextEditingController reponse3Controller = TextEditingController();
  TextEditingController reponse4Controller = TextEditingController();
  TextEditingController reponse5Controller = TextEditingController();
  TextEditingController explicationController = TextEditingController();
  bool checkedValue1 = false;
  bool checkedValue2 = false;
  bool checkedValue3 = false;
  bool checkedValue4 = false;
  bool checkedValue5 = false;
  bool isLoading = false;
  final annee = ['1', '2', '3', '4', '5', '6'];
  final semestre = ['1', '2'];
  String? value;
  String? value1;
  @override
  Future<void> didChangeDependencies() async {
    final Map? questions = ModalRoute.of(context)!.settings.arguments as Map?;
    if (questions != null) {
      idController.text = questions['id'].toString();
      anneeController.text = questions['semestre'].toString();
      semestreController.text = questions['annee'].toString();
      moduleController.text = questions['module'].toString();
      questionsController.text = questions['question'].toString();
      explicationController.text = questions['explication'].toString();
      reponse5Controller.text = questions['rep5'].toString();
      reponse4Controller.text = questions['rep4'].toString();
      reponse3Controller.text = questions['rep3'].toString();
      reponse2Controller.text = questions['rep2'].toString();
      reponse1Controller.text = questions['rep1'].toString();
      final value3 = questions['respo1'].toString();
      if (value3 == 'true') {
        checkedValue1 = true;
      } else if (value3 == 'false') {
        checkedValue1 = false;
      }
      final value4 = questions['respo2'].toString();
      if (value4 == 'true') {
        checkedValue2 = true;
      } else if (value4 == 'false') {
        checkedValue2 = false;
      }
      final value5 = questions['respo3'].toString();
      if (value5 == 'true') {
        checkedValue3 = true;
      } else if (value5 == 'false') {
        checkedValue3 = false;
      }
      final value6 = questions['respo4'].toString();
      if (value6 == 'true') {
        checkedValue4 = true;
      } else if (value6 == 'false') {
        checkedValue4 = false;
      }
      final value7 = questions['respo5'].toString();
      if (value7 == 'true') {
        checkedValue5 = true;
      } else if (value7 == 'false') {
        checkedValue5 = false;
      }
      value = questions['annee'].toString();
      value1 = questions['semestre'].toString();
    } else {
      idController.text = 'null';
    }
    super.didChangeDependencies();
  }

  DropdownMenuItem<String?> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      );
  DropdownMenuItem<String?> buildMenuItem1(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit questions'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return AllQuestions();
                },
              ),
            );
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: isLoading == false
          ? SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text('annee'),
                      Container(
                        width: 300,
                        margin: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String?>(
                            value: value,
                            isExpanded: true,
                            iconSize: 36,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            items: annee.map(buildMenuItem).toList(),
                            onChanged: (value) => setState(() {
                              this.value = value;
                              anneeController.text = value.toString();
                            }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Semestre'),
                      Container(
                        width: 300,
                        margin: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String?>(
                            value: value1,
                            isExpanded: true,
                            iconSize: 36,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            items: semestre.map(buildMenuItem1).toList(),
                            onChanged: (value) => setState(() {
                              value1 = value;
                              semestreController.text = value.toString();
                            }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'module'),
                        textInputAction: TextInputAction.next,
                        controller: moduleController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'can not be empty';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          moduleController.text = value!;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'questions'),
                        textInputAction: TextInputAction.next,
                        controller: questionsController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'can not be empty';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          questionsController.text = value!;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'reponse1'),
                        textInputAction: TextInputAction.next,
                        controller: reponse1Controller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'can not be empty';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          reponse1Controller.text = value!;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CheckboxListTile(
                        title: Text("couche si la reponse 1 est correct"),
                        value: checkedValue1,
                        onChanged: (newValue) {
                          setState(() {
                            checkedValue1 = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'reponse2'),
                        textInputAction: TextInputAction.next,
                        controller: reponse2Controller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'can not be empty';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          reponse2Controller.text = value!;
                        },
                      ),
                      CheckboxListTile(
                        title: Text("couche si la reponse 2 est correct"),
                        value: checkedValue2,
                        onChanged: (newValue) {
                          setState(() {
                            checkedValue2 = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'reponse3'),
                        textInputAction: TextInputAction.next,
                        controller: reponse3Controller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'can not be empty';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          reponse3Controller.text = value!;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CheckboxListTile(
                        title: Text("couche si la reponse 3 est correct"),
                        value: checkedValue3,
                        onChanged: (newValue) {
                          setState(() {
                            checkedValue3 = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'reponse4'),
                        textInputAction: TextInputAction.next,
                        controller: reponse4Controller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'can not be empty';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          reponse4Controller.text = value!;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CheckboxListTile(
                        title: Text("couche si la reponse 4 est correct"),
                        value: checkedValue4,
                        onChanged: (newValue) {
                          setState(() {
                            checkedValue4 = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'reponse5'),
                        textInputAction: TextInputAction.next,
                        controller: reponse5Controller,
                        validator: (value) {
                          return null;
                        },
                        onSaved: (value) {
                          if (value!.isEmpty) {
                            reponse5Controller.text = 'null';
                          } else {
                            reponse5Controller.text = value;
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CheckboxListTile(
                        title: Text("couche si la reponse 5 est correct"),
                        value: checkedValue5,
                        onChanged: (newValue) {
                          setState(() {
                            checkedValue5 = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'explication'),
                        textInputAction: TextInputAction.next,
                        controller: explicationController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'can not be empty';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          explicationController.text = value!;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          _formKey.currentState!.save();
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            if (idController.text == 'null') {
                              final url = Uri.parse(
                                'https://rayanzinotblans.000webhostapp.com/create_question.php',
                              );
                              final response = await http.post(
                                url,
                                body: {
                                  'module': moduleController.text,
                                  'semester': semestreController.text,
                                  'annee': anneeController.text,
                                  'qcm': questionsController.text,
                                  'answer1': reponse1Controller.text,
                                  'answer1resp': checkedValue1.toString(),
                                  'answer2': reponse2Controller.text,
                                  'answer2resp': checkedValue2.toString(),
                                  'answer3': reponse3Controller.text,
                                  'answer3resp': checkedValue3.toString(),
                                  'answer4': reponse4Controller.text,
                                  'answer4resp': checkedValue4.toString(),
                                  'answer5': reponse5Controller.text,
                                  'answer5resp': checkedValue5.toString(),
                                  'explic': explicationController.text,
                                },
                              );
                              if (response.statusCode == 200) {
                                if (json.decode(response.body)['status']) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return AllQuestions();
                                      },
                                    ),
                                  );
                                } else {
                                  print(json.decode(response.body)['message']);
                                }
                              } else {
                                print('field create module');
                                print(
                                  'Response status: ${response.statusCode}',
                                );
                              }
                            } else {
                              final url = Uri.parse(
                                'https://rayanzinotblans.000webhostapp.com/update_question.php',
                              );
                              final response = await http.post(
                                url,
                                body: {
                                  'id_qcm': idController.text,
                                  'module': moduleController.text,
                                  'semester': semestreController.text,
                                  'annee': anneeController.text,
                                  'qcm': questionsController.text,
                                  'answer1': reponse1Controller.text,
                                  'answer1resp': checkedValue1.toString(),
                                  'answer2': reponse2Controller.text,
                                  'answer2resp': checkedValue2.toString(),
                                  'answer3': reponse3Controller.text,
                                  'answer3resp': checkedValue3.toString(),
                                  'answer4': reponse4Controller.text,
                                  'answer4resp': checkedValue4.toString(),
                                  'answer5': reponse5Controller.text,
                                  'answer5resp': checkedValue5.toString(),
                                  'explic': explicationController.text,
                                },
                              );
                              if (response.statusCode == 200) {
                                if (json.decode(response.body)['status']) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return AllQuestions();
                                      },
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        json
                                            .decode(response.body)['message']
                                            .toString(),
                                      ),
                                    ),
                                  );
                                  print(json.decode(response.body)['message']);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('field create / update question'),
                                  ),
                                );
                                print('field create module');
                                print(
                                  'Response status: ${response.statusCode}',
                                );
                              }
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('field try create / update question'),
                              ),
                            );
                            print('field to try create module');
                            print(e.toString());
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: Container(
                          width: 150,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Center(
                            child: Text('Confirme'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      if (idController.text != 'null')
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              final url = Uri.parse(
                                'https://rayanzinotblans.000webhostapp.com/delete_question.php',
                              );
                              final response = await http.post(
                                url,
                                body: {
                                  'id': idController.text,
                                },
                              );
                              if (response.statusCode == 200) {
                                if (json.decode(response.body)['status']) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return AllQuestions();
                                      },
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        json
                                            .decode(response.body)['message']
                                            .toString(),
                                      ),
                                    ),
                                  );
                                  print(json.decode(response.body)['message']);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('field delete question'),
                                  ),
                                );
                                print('field delete question');
                                print(
                                  'Response status: ${response.statusCode}',
                                );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('field try delete question'),
                                ),
                              );
                              print('field to try delete question');
                              print(e.toString());
                            }
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: Container(
                            width: 150,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.red.shade300,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            child: Center(
                              child: Text('Delete'),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
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
}
