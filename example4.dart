import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/api4.dart';
class Dog extends StatefulWidget {
  const Dog({Key? key}) : super(key: key);

  @override
  State<Dog> createState() => _DogState();
}

class _DogState extends State<Dog> {
  late Future<Dogs> _future;
  Future<Dogs> Getdogs() async{
    final resp=await http.get(Uri.parse("https://dog.ceo/api/breeds/image/random"));
    return Dogs.fromJson(jsonDecode(resp.body));
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = Getdogs();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  FutureBuilder<Dogs>(
        future: _future,
        builder: (context, snapshot)
        {
          if (snapshot.hasData)
          {
            return Column(
              children: [
                Text(snapshot.data!.message.toString()),
                Text(snapshot.data!.status.toString()),
                        ],
            );
          }
          else if (snapshot.hasError)
          {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
