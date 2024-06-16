import 'package:flutter/material.dart';

// ignore: camel_case_types
class tabs extends StatefulWidget {
  const tabs({super.key});

  @override
  State<tabs> createState() => _tabsState();
}

// ignore: camel_case_types
class _tabsState extends State<tabs> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
            onTapOutside: (event) {},
            onSubmitted: (value) {
              setState(() {
                searchText = value;
              });
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 25, right: 25),
                hintText: "Enter text to search... ",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35))),
          ),
        ),
        Expanded(
            child: Center(
                child: Text(
          searchText,
          style: const TextStyle(fontSize: 25),
        )))
      ],
    );
  }
}
