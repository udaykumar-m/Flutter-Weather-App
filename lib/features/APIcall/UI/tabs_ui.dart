import 'dart:convert';

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
  String queryText = '';

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
              if (searchText != '' && queryText != '') {
                context.read<QuotesBloc>().add(
                    GetTabsAPI(searchText: searchText, queryText: queryText));
              }
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 25, right: 25),
                hintText: "Enter text to search... ",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35))),
          ),
        ),
        searchText == ''
            ? const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Enter text above and voilaa......",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        textAlign: TextAlign.center),
                  ],
                ),
              )
            : Expanded(child: BlocBuilder<QuotesBloc, QuotesState>(
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case TabsAPILoadingState:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case TabsAPISuccessfullState:
                      final responseState = state as TabsAPISuccessfullState;
                      return Container(
                        margin: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(utf8.decode((responseState
                                    .TabsAPI.choices?[0].message?.content)
                                .toString()
                                .runes
                                .toList())),
                          ],
                        ),
                      );
                    default:
                      return const SizedBox();
                  }
                },
              ))
      ],
    );
  }
}
