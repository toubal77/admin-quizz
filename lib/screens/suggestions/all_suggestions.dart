import 'dart:convert';

import 'package:admin_quizz/models/suggestions.dart';
import 'package:admin_quizz/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllSuggestions extends StatefulWidget {
  const AllSuggestions({Key? key}) : super(key: key);

  @override
  _AllSuggestionsState createState() => _AllSuggestionsState();
}

class _AllSuggestionsState extends State<AllSuggestions> {
  List<Suggestions>? suggestions = [];
  @override
  void initState() {
    getUsers();
    super.initState();
  }

  bool isLoading = false;
  Future<List<Suggestions?>?> getUsers() async {
    setState(() {
      isLoading = true;
    });
    suggestions!.clear();
    try {
      var url = Uri.parse(
          'https://rayanzinotblans.000webhostapp.com/get_suggestions.php');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print('seccus get sugggestions');
        final data = json.decode(response.body)["messages"];
        setState(() {
          for (Map<String, dynamic> i in data) {
            suggestions!.add(Suggestions.fromJson(i));
          }
        });
      } else {
        print('field get suggestions');
        print('Response status: ${response.statusCode}');
      }
    } catch (e) {
      print('field to try get suggestions');
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
        title: Text('Les Suggestions'),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: isLoading == false
          ? SingleChildScrollView(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: getColumns(['id', 'nom', 'email', 'message']),
                  rows: getRows(suggestions!),
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

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      return DataColumn(
        label: Text(column),
      );
    }).toList();
  }

  List<DataRow> getRows(List<Suggestions> users) =>
      users.map((Suggestions sugg) {
        final cells = [sugg.id, sugg.username, sugg.email, sugg.message];

        return DataRow(
          cells: Utils.modelBuilder(cells, (index, cell) {
            return DataCell(
              Text('$cell'),
              onTap: () {
                print('edit');
              },
            );
          }),
        );
      }).toList();
}
