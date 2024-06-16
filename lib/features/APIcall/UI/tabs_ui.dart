import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/quotes_bloc.dart';

// ignore: camel_case_types
class tabs extends StatefulWidget {
  final String tabPage;

  const tabs({super.key, required this.tabPage});

  @override
  State<tabs> createState() => _tabsState();
}

// ignore: camel_case_types
class _tabsState extends State<tabs> {
  String searchText = '';
  String? queryText;

  @override
  void initState() {
    super.initState();
    queryText = widget.tabPage;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
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
        Expanded(child: BlocBuilder<QuotesBloc, QuotesState>(
          builder: (context, state) {
            return Center(
                child: Text(
              queryText!,
              style: const TextStyle(fontSize: 25),
            ));
          },
        ))
      ],
    );
  }
}
