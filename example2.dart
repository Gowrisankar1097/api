import 'dart:convert';

import 'package:api/model/api2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class example2 extends StatefulWidget {
  const example2({Key? key}) : super(key: key);

  @override
  State<example2> createState() => _example2State();
}

class _example2State extends State<example2> {
  Future<List<Entries>> getAPI() async{
    final resp=await http.get(Uri.parse("https://api.publicapis.org/entries"));
    var data=jsonDecode(resp.body)['entries'];
   return(data as List).map((x) => Entries.fromJson(x)).toList();

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
          child: FutureBuilder<List<Entries>>(
          future: getAPI(),
            builder: (context, snapshot)
            {
              if (snapshot.hasData)
              {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(snapshot.data![index].description.toString()),
                        Text(snapshot.data![index].category.toString()),
                        //Text(snapshot.data![index].ca)
                      ],
                    );
                  },
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
