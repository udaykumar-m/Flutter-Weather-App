import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:openai_app/features/home/internet_connection.dart';

class networkLogicClass {
  Future<bool> networkConnection() async =>
      await InternetConnectionChecker().hasConnection;

  static void networkLogic(
      BuildContext context, bool? hasConnection, VoidCallback updateState) {
    if (hasConnection != true) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => InternetConnection(
                onPressed: () async {
                  bool? newConnectionStatus =
                      await InternetConnectionChecker().hasConnection;
                  if (newConnectionStatus == true) {
                    print("working");
                    Navigator.pop(context);
                    updateState();
                  }
                },
              ));
    }
  }
}
