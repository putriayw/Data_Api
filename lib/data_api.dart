import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListDigimon extends StatelessWidget {
  final String apiUrl = "https://digimon-api.vercel.app/api/digimon";

  const ListDigimon({super.key});
  Future<List<dynamic>> _fecthListDigimon() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digimon List'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fecthListDigimon(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: Color.fromARGB(255, 0, 0, 0),
                          backgroundImage:
                              NetworkImage('${snapshot.data[index]['img']}')),
                      title: Text(
                        snapshot.data[index]['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.justify,
                      ),
                      subtitle: Text(
                        snapshot.data[index]['level'],
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
