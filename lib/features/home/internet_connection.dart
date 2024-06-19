import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InternetConnection extends StatelessWidget {
  const InternetConnection({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Network Error'),
      content: const Text('Please check you network connection and try again'),
      actions: <Widget>[
        ElevatedButton( onPressed: onPressed, child: const Row(
          children: [
            Icon(FontAwesomeIcons.rotateRight),
            Text("Retry"),
          ],
        ))
      ],
    );
  }
}
