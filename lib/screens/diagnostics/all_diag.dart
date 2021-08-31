import 'dart:convert';
import 'package:admin_quizz/home_page.dart';
import 'package:admin_quizz/models/diagnostics.dart';
import 'package:admin_quizz/screens/diagnostics/edit_diag.dart';
import 'package:admin_quizz/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllDiag extends StatefulWidget {
  const AllDiag({Key? key}) : super(key: key);

  @override
  _AllDiagState createState() => _AllDiagState();
}

class _AllDiagState extends State<AllDiag> {
  List<Diagnostics>? diag = [];
  @override
  void initState() {
    getUsers();
    super.initState();
  }

  bool isLoading = false;
  Future<List<Diagnostics?>?> getUsers() async {
    setState(() {
      isLoading = true;
    });
    diag!.clear();
    try {
      var url =
          Uri.parse('https://rayanzinotblans.000webhostapp.com/get_diag.php');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print('seccus get diagnostics');
        final data = json.decode(response.body)["diag"];
        setState(() {
          for (Map<String, dynamic> i in data) {
            diag!.add(Diagnostics.fromJson(i));
          }
        });
      } else {
        print('field get diagnostics');
        print('Response status: ${response.statusCode}');
      }
    } catch (e) {
      print('field to try get diagnostics');
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
        title: Text('les Diagnostics'),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return HomePage();
              }));
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: isLoading == false
          ? SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return EditDiag();
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
                      child: Text('ajout un diagnostics'),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      columns:
                          getColumns(['id', 'tilte', 'descriptions', 'image']),
                      rows: getRows(diag!)),
                ),
              ]),
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

  List<DataRow> getRows(List<Diagnostics> diags) =>
      diags.map((Diagnostics diag) {
        final cells = [
          diag.id,
          diag.title,
          diag.description,
          diag.image,
        ];

        return DataRow(
          cells: Utils.modelBuilder(cells, (index, cell) {
            final showEditIcon = index == 0;
            return DataCell(
              Text('$cell'),
              showEditIcon: showEditIcon,
              onTap: () {
                Map<String, String>? mod = {
                  'id': diag.id,
                  'title': diag.title,
                  'description': diag.description,
                  'image': diag.image,
                };
                Navigator.of(context)
                    .pushNamed(EditDiag.screenName, arguments: mod);
              },
            );
          }),
        );
      }).toList();
}
