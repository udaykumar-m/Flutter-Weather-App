import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InternetConnection extends StatelessWidget {
  const InternetConnection({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Text('Network Error  '),
          Icon(Icons.wifi_off, color: Colors.red)
        ],
      ),
      content: const Text('Please check you network connection and try again'),
      actions: <Widget>[
        ElevatedButton(
            onPressed: onPressed,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.rotateRight),
                SizedBox(width: 20),
                Text(
                  "Retry",
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(width: 20),
              ],
            ))
      ],
    );
  }
}
