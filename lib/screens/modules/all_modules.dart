import 'dart:convert';

import 'package:admin_quizz/home_page.dart';
import 'package:admin_quizz/models/modules.dart';
import 'package:admin_quizz/screens/modules/edit_module.dart';
import 'package:admin_quizz/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllModules extends StatefulWidget {
  const AllModules({Key? key}) : super(key: key);

  @override
  _AllModulesState createState() => _AllModulesState();
}

class _AllModulesState extends State<AllModules> {
  List<Modules>? modules = [];
  @override
  void initState() {
    getUsers();
    super.initState();
  }

  bool isLoading = false;
  Future<List<Modules?>?> getUsers() async {
    setState(() {
      isLoading = true;
    });
    modules!.clear();
    try {
      final url =
          Uri.parse('https://rayanzinotblans.000webhostapp.com/get_module.php');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // ignore: avoid_print
        print('seccus get module');
        final data = json.decode(response.body)["modules"];
        setState(() {
          for (final Map<String, dynamic> i in data) {
            modules!.add(Modules.fromJson(i));
          }
        });
      } else {
        // ignore: avoid_print
        print('field get module');
        // ignore: avoid_print
        print('Response status: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('field to try get module');
      // ignore: avoid_print
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
        title: const Text('tous les Modules'),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return const HomePage();
                },
              ),
            );
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: isLoading == false
          ? SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const EditModult();
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: 150,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
                      ),
                      child: const Center(
                        child: Text('ajout un module'),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: getColumns([
                        'id',
                        'annee',
                        'semestre',
                        'module',
                        'image',
                        'view'
                      ]),
                      rows: getRows(modules!),
                    ),
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

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      return DataColumn(
        label: Text(column),
      );
    }).toList();
  }

  List<DataRow> getRows(List<Modules> module) => module.map((Modules module) {
        final cells = [
          module.id,
          module.annee,
          module.semestre,
          module.nom,
          module.image,
          module.view,
        ];

        return DataRow(
          cells: Utils.modelBuilder(cells, (index, cell) {
            final showEditIcon = index == 0;
            return DataCell(
              Text('$cell'),
              showEditIcon: showEditIcon,
              onTap: () {
                final Map<String, String> mod = {
                  'id': module.id,
                  'annee': module.annee,
                  'semestre': module.semestre,
                  'nom': module.nom,
                  'image': module.image,
                };
                Navigator.of(context)
                    .pushNamed(EditModult.screenName, arguments: mod);
              },
            );
          }),
        );
      }).toList();
}
