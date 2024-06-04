
import 'package:flutter/material.dart';
import 'package:openai_app/APICall/APIcall.dart';
import 'package:openai_app/model/api_model.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: APIData(),
      ),
    );
  }
}


class APIData extends StatefulWidget {
  const APIData({super.key});

  @override
  State<APIData> createState() => _APIDataState();
}

class _APIDataState extends State<APIData> {

  final List<Welcome>? userModel = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  dynamic _getData() async{
    final user = await ApiService().getUsers();
    user?.forEach((x) => userModel?.add(x) );
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
    (userModel?.isEmpty ?? true )? Center(child: CircularProgressIndicator()) : ListView.builder(
      shrinkWrap: true,
      itemCount: userModel?.length,
      itemBuilder: (context, index){
        return ListTile(
          title: Column(
            children: [
              Text("Id : $index"),
              Text(userModel![index].body.toString()),
            ],
          ),
        );
      }
      );
  }
}