import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/api1.dart';
class example extends StatefulWidget {
  const example({Key? key}) : super(key: key);

  @override
  State<example> createState() => _exampleState();
}

class _exampleState extends State<example> {
  late Future<board> _future;
  Future<board> Getbored() async{
    print("in");
    final resp=await http.get(Uri.parse("https://www.boredapi.com/api/activity"));
    print("1");
    //print(resp.body);
    //print(resp.statusCode);
    return board.fromJson(jsonDecode(resp.body));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = Getbored();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<board>(
            future: _future,
            builder: (context, snapshot)
            {
              if (snapshot.hasData)
              {
                return Column(
                  children: [
                    Text(snapshot.data!.activity.toString()),
                    //Text(snapshot.data!.type.toString()),
                    Text(snapshot.data!.participants.toString()),
                    Text(snapshot.data!.price.toString()),
                   Text(snapshot.data!.link.toString()),
                    //Text(snapshot.data!.key.toString()),
                   // Text(snapshot.data!.accessibility.toString()),


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
        ),
      ),
    );
  }
}
