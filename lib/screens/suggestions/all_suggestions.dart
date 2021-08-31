import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllSuggestions extends StatelessWidget {
  // List<Suggestions>? suggestions = [];
  // @override
  // void initState() {
  //   getUsers();
  //   super.initState();
  // }

  // bool isLoading = false;
  // Future<List<Suggestions?>?> getUsers() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   suggestions!.clear();
  //   try {
  //     var url = Uri.parse(
  //         'https://rayanzinotblans.000webhostapp.com/get_suggestions.php');
  //     var response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       print('seccus get sugggestions');
  //       final data = json.decode(response.body)["messages"];
  //       setState(() {
  //         for (Map<String, dynamic> i in data) {
  //           suggestions!.add(Suggestions.fromJson(i));
  //         }
  //       });
  //     } else {
  //       print('field get suggestions');
  //       print('Response status: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('field to try get suggestions');
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
        title: Text('Les Suggestions'),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('suggestion').snapshots(),
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
                      Text(snapshot.data.docs[index]['username']),
                      SizedBox(
                        height: 3,
                      ),
                      Text(snapshot.data.docs[index]['time']),
                      SizedBox(
                        height: 10,
                      ),
                      Text(snapshot.data.docs[index]['message']),
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
    );
    //   body: isLoading == false
    //       ? SingleChildScrollView(
    //           child: SingleChildScrollView(
    //             scrollDirection: Axis.horizontal,
    //             child: DataTable(
    //               columns: getColumns(['id', 'nom', 'email', 'message']),
    //               rows: getRows(suggestions!),
    //             ),
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

    // List<DataColumn> getColumns(List<String> columns) {
    //   return columns.map((String column) {
    //     return DataColumn(
    //       label: Text(column),
    //     );
    //   }).toList();
    // }

    // List<DataRow> getRows(List<Suggestions> users) =>
    //     users.map((Suggestions sugg) {
    //       final cells = [sugg.id, sugg.username, sugg.email, sugg.message];

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
}
