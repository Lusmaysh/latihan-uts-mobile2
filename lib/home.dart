import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'tambah.dart';
import 'ubah.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List> getData() async {
    final response = await http.get(
      Uri.parse("https://api.bams-iwima.my.id/akademik/barang"),
    );
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Data Barang"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Tambah(),
            ),
          );
        },
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? Container(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                  child: Card(
                    child: ListView.builder(
                      itemCount:
                          snapshot.data == null ? 0 : snapshot.data!.length,
                      itemBuilder: (context, i) {
                        return Column(
                          children: [
                            GestureDetector(
                              child: ListTile(
                                title: Text(snapshot.data![i]['nama']),
                                leading: Icon(Icons.person),
                                subtitle: Text("${snapshot.data![i]['kode']}"),
                                trailing: Icon(Icons.navigate_next_rounded),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Ubah(
                                        kode: snapshot.data![i]['kode'],
                                        nama: snapshot.data![i]['nama'],
                                        harga: snapshot.data![i]['harga'],
                                        spek: snapshot.data![i]['spesifikasi'],
                                        merk: snapshot.data![i]['merk']),
                                  ),
                                );
                              },
                            ),
                            Divider(
                              color: Colors.black,
                              indent: 10,
                              endIndent: 10,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
