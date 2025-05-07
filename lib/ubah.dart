import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class Ubah extends StatefulWidget {
  final String? kode;
  final String? nama;
  final String? harga;
  final String? spek;
  final String? merk;

  Ubah({this.kode, this.nama, this.harga, this.spek, this.merk});

  @override
  _UbahState createState() => _UbahState();
}

class _UbahState extends State<Ubah> {
  TextEditingController kodeController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController spekController = TextEditingController();
  TextEditingController merkController = TextEditingController();

  Future<void> ubahData() async {
    var url = Uri.parse(
        "https://api.bams-iwima.my.id/akademik/barang/${kodeController.text}");
    await http.put(url, body: {
      "nama": namaController.text,
      "harga": hargaController.text,
      "spesifikasi": spekController.text,
      "merk": merkController.text,
    });
  }

  Future<void> hapusData() async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Menghapus barang dengan kode: ${kodeController.text}'),
    ));
    var url = Uri.parse(
        "https://api.bams-iwima.my.id/akademik/barang/${kodeController.text}");
    final response = await http.delete(url);

    if (response.statusCode == 200 || response.statusCode == 204) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Data berhasil dihapus dari server.'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Gagal menghapus data. Status: ${response.statusCode}\nRespons: ${response.body}')));
    }
  }

  void konfirmasi() {
    AlertDialog alertDialog = AlertDialog(
      content: Text("Apakah anda yakin akan menghapus data ${widget.nama}"),
      actions: <Widget>[
        MaterialButton(
          color: Colors.red,
          child: Text(
            "OK DELETE!",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () async {
            await hapusData();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        MaterialButton(
          color: Colors.green,
          child: Text("CANCEL", style: TextStyle(color: Colors.black)),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  @override
  void initState() {
    kodeController = TextEditingController(text: widget.kode);
    namaController = TextEditingController(text: widget.nama);
    hargaController = TextEditingController(text: widget.harga);
    spekController = TextEditingController(text: widget.spek);
    merkController = TextEditingController(text: widget.merk);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Text(
              "Ubah Data Barang",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  color: Colors.orange,
                  onPressed: () async {
                    await ubahData();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                      (Route<dynamic> route) => false,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Data berhasil diubah'),
                    ));
                  },
                  child: Text("Ubah"),
                ),
                // MaterialButton(
                //   color: Colors.red,
                //   onPressed: () {
                //     konfirmasi();
                //   },
                //   child: Text("Hapus"),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
