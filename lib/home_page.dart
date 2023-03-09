// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:crud_sederhana/models/request_model.dart';
import 'package:crud_sederhana/utils/network_manager.dart';
import 'package:crud_sederhana/models/comic_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final judulController = TextEditingController();
  final stockController = TextEditingController();
  final dateController = TextEditingController();
  final hargaController = TextEditingController();

  List<Comic> comics = [];

  bool isLoading = false;

  Future<void> refreshData() async {
    final result = await NetworkManager().getAll();
    comics = result.data;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: const [],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: comics.length,
              physics: const ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(comics[index].attributes.judul),
                    subtitle: Text(comics[index].attributes.harga.toString()),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          formData();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void formData() async {
    bool confirm = false;
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextFormField(
                  controller: judulController,
                  // initialValue: judulController.text, gak usah pake initialValue kalo nge lempar ke controller, solved in : https://stackoverflow.com/questions/52691887/flutter-initialvalue-null-controller-null-is-not-true-error
                  maxLength: 20,
                  decoration: const InputDecoration(
                    labelText: 'Judul',
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                    helperText: "Masukan Judul",
                  ),
                  onChanged: (value) {},
                ),
                TextFormField(
                  controller: stockController,
                  // initialValue: stockController.text,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    labelText: 'Stock',
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                    helperText: "Masukan Stock Dari Comic",
                  ),
                  onChanged: (value) {},
                ),
                InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                  },
                  child: TextFormField(
                    controller: dateController,
                    // initialValue: dateController.text,
                    maxLength: 20,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Tangal Masuk :',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                        ),
                      ),
                      suffixIcon: Icon(Icons.date_range),
                      helperText: "Masukan Tanggal Masuk",
                    ),
                    onChanged: (value) {},
                  ),
                ),
                TextFormField(
                  controller: hargaController,
                  // initialValue: hargaController.text,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    labelText: 'Harga',
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                    helperText: "Masukan Harga Comic",
                  ),
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[600],
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              onPressed: () {
                confirm = true;
                Navigator.pop(context);
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );

    if (confirm) {
      var dateTime = new DateTime.now();
      RequestComic data = RequestComic(
          judulController.text,
          int.parse(stockController.text),
          DateTime.parse(dateController.toString()),
          int.parse(hargaController.text));
      NetworkManager().addData(data);
      refreshData();
    }
  }
}
