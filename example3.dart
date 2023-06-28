import 'dart:convert';

import 'package:api/model/api3.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class example3 extends StatefulWidget {
  const example3({Key? key}) : super(key: key);

  @override
  State<example3> createState() => _example3State();
}

class _example3State extends State<example3> {

  Future<List<Annotations>> Dataa() async{
    final resp=await http.get(Uri.parse("https://datausa.io/api/data?drilldowns=Nation&measures=Population"));
    var data=jsonDecode(resp.body)['Annotations'];
    return(data as List).map((x) => Annotations.fromJson(x)).toList();
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
          child: FutureBuilder<List<Annotations>>(
            future:Dataa(),
            builder: (context, snapshot)
            {
              if (snapshot.hasData)
              {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(snapshot.data![index].sourceName.toString()),
                        Text(snapshot.data![index].sourceDescription.toString()),
                        Text(snapshot.data![index].datasetName.toString()),
                        Text(snapshot.data![index].datasetLink.toString()),
                        Text(snapshot.data![index].tableId.toString()),
                        Text(snapshot.data![index].topic.toString()),
                        Text(snapshot.data![index].subtopic.toString()),


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
