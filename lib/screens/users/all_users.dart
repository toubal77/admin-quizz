import 'dart:convert';

import 'package:admin_quizz/models/users.dart';
import 'package:admin_quizz/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllUsers extends StatelessWidget {
  // List<User>? users = [];
  // @override
  // void initState() {
  //   getUsers();
  //   super.initState();
  // }

  // bool isLoading = false;
  // Future<List<User?>?> getUsers() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   users!.clear();
  //   try {
  //     var url =
  //         Uri.parse('https://rayanzinotblans.000webhostapp.com/get_users.php');
  //     var response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       print('seccus get users');
  //       final data = json.decode(response.body)["users"];
  //       setState(() {
  //         for (Map<String, dynamic> i in data) {
  //           users!.add(User.fromJson(i));
  //         }
  //       });
  //     } else {
  //       print('field get users');
  //       print('Response status: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('field to try get users');
  //     print(e.toString());
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('tous les utilisateurs'),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs!.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(7),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('email: ' + snapshot.data.docs[index]['email']),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'username: ' + snapshot.data.docs[index]['username']),
                    ],
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ); //   body: isLoading == false
    //       ? SingleChildScrollView(
    //           child: SingleChildScrollView(
    //             scrollDirection: Axis.horizontal,
    //             child: DataTable(
    //                 columns: getColumns(['id', 'nom', 'email', 'date']),
    //                 rows: getRows(users!)),
    //           ),
    //         )
    //       : Center(
    //           child: Column(
    //             children: [
    //               SizedBox(
    //                 height: MediaQuery.of(context).size.height * 0.4,
    //               ),
    //               CircularProgressIndicator(),
    //               SizedBox(
    //                 height: 20,
    //               ),
    //               Text('Chargement...'),
    //             ],
    //           ),
    //         ),
    // );
  }

  // List<DataColumn> getColumns(List<String> columns) {
  //   return columns.map((String column) {
  //     return DataColumn(
  //       label: Text(column),
  //     );
  //   }).toList();
  // }

  // List<DataRow> getRows(List<User> users) => users.map((User user) {
  //       final cells = [user.id, user.nom, user.email, user.doc];

  //       return DataRow(
  //         cells: Utils.modelBuilder(cells, (index, cell) {
  //           return DataCell(
  //             Text('$cell'),
  //             onTap: () {
  //               print('edit');
  //             },
  //           );
  //         }),
  //       );
  //     }).toList();
}
