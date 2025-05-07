import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class Tambah extends StatefulWidget {
  @override
  _TambahState createState() => _TambahState();
}

class _TambahState extends State<Tambah> {
  TextEditingController kodeController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController spekController = TextEditingController();
  TextEditingController merkController = TextEditingController();

  void tambahData() {
    var url = Uri.parse("https://api.bams-iwima.my.id/akademik/barang");

    http.post(url, body: {
      "kode": kodeController.text,
      "nama": namaController.text,
      "harga": hargaController.text,
      "spesifikasi": spekController.text,
      "merk": merkController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Data"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Text(
              "Input Data Barang",
              style: TextStyle(
                color: Colors.red,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: kodeController,
              decoration: InputDecoration(
                labelText: "Kode",
              ),
            ),
            TextField(
              controller: namaController,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: hargaController,
              decoration: InputDecoration(labelText: "Harga"),
            ),
            TextField(
              controller: spekController,
              decoration: InputDecoration(labelText: "Spesifikasi"),
            ),
            TextField(
              controller: merkController,
              decoration: InputDecoration(labelText: "Merk"),
            ),
            SizedBox(
              height: 50,
            ),
            MaterialButton(
              color: Colors.blue,
              onPressed: () {
                tambahData();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                  (Route<dynamic> route) => false,
                );
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Data berhasil disimpan'),
                ));
              },
              child: Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
