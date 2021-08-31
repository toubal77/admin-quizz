import 'dart:convert';

import 'package:admin_quizz/screens/modules/all_modules.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditModult extends StatefulWidget {
  static final screenName = "\EditModule";
  @override
  _EditModultState createState() => _EditModultState();
}

class _EditModultState extends State<EditModult> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController idController = TextEditingController();
  TextEditingController anneeController = TextEditingController();
  TextEditingController semestreController = TextEditingController();
  TextEditingController moduleController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  bool isLoading = false;
  final annee = ['1', '2'];
  final semestre = ['1', '2'];
  String? value;
  String? value1;
  void didChangeDependencies() async {
    Map? module = ModalRoute.of(context)!.settings.arguments as Map?;
    if (module != null) {
      idController.text = module['id'].toString();
      anneeController.text = module['annee'].toString();
      semestreController.text = module['semestre'].toString();
      moduleController.text = module['nom'].toString();
      imageController.text = module['image'].toString();
      value = module['annee'].toString();
      value1 = module['semestre'].toString();
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
        title: Text('Edit modules'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return AllModules();
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                              this.value1 = value;
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
                        decoration: InputDecoration(labelText: 'image'),
                        textInputAction: TextInputAction.next,
                        controller: imageController,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !(value.contains('png') ||
                                  value.contains('jpg') ||
                                  value.contains('jpeg'))) {
                            return 'supporte png, jpg, jpeg';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          imageController.text = value!;
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
                              var url = Uri.parse(
                                  'https://rayanzinotblans.000webhostapp.com/create_module.php');
                              var response = await http.post(url, body: {
                                'name': moduleController.text,
                                'semester': semestreController.text,
                                'annee': anneeController.text,
                                'image': imageController.text,
                              });
                              if (response.statusCode == 200) {
                                if (json.decode(response.body)['status']) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return AllModules();
                                      },
                                    ),
                                  );
                                } else {
                                  print(json.decode(response.body)['message']);
                                }
                              } else {
                                print('field create module');
                                print(
                                    'Response status: ${response.statusCode}');
                              }
                            } else {
                              var url = Uri.parse(
                                  'https://rayanzinotblans.000webhostapp.com/update_module.php');
                              var response = await http.post(url, body: {
                                'id_mod': idController.text,
                                'name': moduleController.text,
                                'semester': semestreController.text,
                                'annee': anneeController.text,
                                'image': imageController.text,
                              });
                              if (response.statusCode == 200) {
                                if (json.decode(response.body)['status']) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AllModules(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(json
                                          .decode(response.body)['message']),
                                    ),
                                  );
                                  print(json.decode(response.body)['message']);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('field create / update module'),
                                  ),
                                );
                                print('field create module');
                                print(
                                    'Response status: ${response.statusCode}');
                              }
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('field try create/ update module'),
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
                            border: Border.all(color: Colors.grey, width: 1),
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
                              var url = Uri.parse(
                                  'https://rayanzinotblans.000webhostapp.com/delete_module.php');
                              var response = await http.post(url, body: {
                                'id': idController.text,
                              });
                              if (response.statusCode == 200) {
                                if (json.decode(response.body)['status']) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AllModules(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(json
                                          .decode(response.body)['message']),
                                    ),
                                  );
                                  print(json.decode(response.body)['message']);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('field delete module'),
                                  ),
                                );
                                print('field delete module');
                                print(
                                    'Response status: ${response.statusCode}');
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('field try delete module'),
                                ),
                              );
                              print('field to try delete module');
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
                              border: Border.all(color: Colors.grey, width: 1),
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
