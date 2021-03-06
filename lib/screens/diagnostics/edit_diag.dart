import 'dart:convert';

import 'package:admin_quizz/screens/diagnostics/all_diag.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditDiag extends StatefulWidget {
  static const screenName = "EditDiag";

  const EditDiag({Key? key}) : super(key: key);
  @override
  _EditDiagState createState() => _EditDiagState();
}

class _EditDiagState extends State<EditDiag> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController idController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  bool isLoading = false;

  @override
  Future<void> didChangeDependencies() async {
    final Map? diagnostics = ModalRoute.of(context)!.settings.arguments as Map?;
    if (diagnostics != null) {
      idController.text = diagnostics['id'].toString();
      titleController.text = diagnostics['title'].toString();
      descriptionController.text = diagnostics['description'].toString();
      imageController.text = diagnostics['image'].toString();
    } else {
      idController.text = 'null';
    }
    super.didChangeDependencies();
  }

  DropdownMenuItem<String?> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      );
  DropdownMenuItem<String?> buildMenuItem1(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Diagnostics'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return const AllDiag();
                },
              ),
            );
          },
          child: const Icon(Icons.arrow_back),
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
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'title'),
                        textInputAction: TextInputAction.next,
                        controller: titleController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'can not be empty';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          titleController.text = value!;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                        keyboardType: TextInputType.multiline,
                        maxLines: 6,
                        maxLength: 20000,
                        controller: descriptionController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Can't be empty";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          descriptionController.text = value!;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'image'),
                        textInputAction: TextInputAction.next,
                        controller: imageController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Can't be empty";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          imageController.text = value!;
                        },
                      ),
                      const SizedBox(
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
                                'https://rayanzinotblans.000webhostapp.com/create_diag.php',
                              );
                              final response = await http.post(
                                url,
                                body: {
                                  'title': titleController.text,
                                  'description': descriptionController.text,
                                  'image': imageController.text,
                                },
                              );
                              if (response.statusCode == 200) {
                                if (json.decode(response.body)['status']) {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const AllDiag();
                                      },
                                    ),
                                  );
                                } else {
                                  // ignore: avoid_print
                                  print(json.decode(response.body)['message']);
                                }
                              } else {
                                // ignore: avoid_print
                                print('field create diag');
                                // ignore: avoid_print
                                print(
                                  'Response status: ${response.statusCode}',
                                );
                              }
                            } else {
                              final url = Uri.parse(
                                'https://rayanzinotblans.000webhostapp.com/update_diag.php',
                              );
                              final response = await http.post(
                                url,
                                body: {
                                  'id_diag': idController.text,
                                  'title': titleController.text,
                                  'description': descriptionController.text,
                                  'image': imageController.text,
                                },
                              );
                              if (response.statusCode == 200) {
                                if (json.decode(response.body)['status']) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const AllDiag(),
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
                                  // ignore: avoid_print
                                  print(json.decode(response.body)['message']);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('field create / update diag'),
                                  ),
                                );
                                // ignore: avoid_print
                                print('field create diag');
                                // ignore: avoid_print
                                print(
                                  'Response status: ${response.statusCode}',
                                );
                              }
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('field try create/ update diag'),
                              ),
                            );
                            // ignore: avoid_print
                            print('field to try create diag');
                            // ignore: avoid_print
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
                          child: const Center(
                            child: Text('Confirme'),
                          ),
                        ),
                      ),
                      const SizedBox(
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
                                'https://rayanzinotblans.000webhostapp.com/delete_diag.php',
                              );
                              final response = await http.post(
                                url,
                                body: {
                                  'id': idController.text,
                                },
                              );
                              if (response.statusCode == 200) {
                                if (json.decode(response.body)['status']) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const AllDiag(),
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
                                  // ignore: avoid_print
                                  print(json.decode(response.body)['message']);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('field delete diag'),
                                  ),
                                );
                                // ignore: avoid_print
                                print('field delete diag');
                                // ignore: avoid_print
                                print(
                                  'Response status: ${response.statusCode}',
                                );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('field try delete diag'),
                                ),
                              );
                              // ignore: avoid_print
                              print('field to try delete diag');
                              // ignore: avoid_print
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
                            child: const Center(
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
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Chargement...'),
                ],
              ),
            ),
    );
  }
}
