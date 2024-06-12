import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnection extends StatefulWidget {
  const InternetConnection({super.key});

  @override
  State<InternetConnection> createState() => _InternetConnectionState();
}

class _InternetConnectionState extends State<InternetConnection> {

  late bool _hasConnection;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternetConnection();
  }

   Future<void> checkInternetConnection() async {
    _hasConnection = await InternetConnectionChecker().hasConnection;
  }

  @override
  Widget build(BuildContext context)  {
    if(_hasConnection == true) {
      return Container();
    } else {
      return AlertDialog(
        title: const Text('AlertDialog Title'),
        content: const Text('AlertDialog description'),
        actions: <Widget>[
          ElevatedButton(onPressed: ()=>{setState(() {
            _hasConnection = false;
          })}, child: const Row(
            children: [
              Icon(FontAwesomeIcons.rotateRight),
              Text("Retry"),
            ],
          ))
        ],
      );
    }
  }
}
