import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  String content = '';
  bool textBox = false;

  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    queryText = widget.tabPage;
    switch (queryText) {
      case 'Meaning':
        content = "Meaning & Usage";
        break;
      case 'Instagram':
        content = "Instagram Caption";
        break;
      case 'Twitter':
        content = "Generate Tweet";
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Text(content,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
            controller: textController,
            onTapOutside: (event) {},
            onSubmitted: (value) {
              setState(() {
                textBox = true;
                searchText = value;
              });
              if (searchText != '' && queryText != '') {
                context.read<QuotesBloc>().add(
                    GetTabsAPI(searchText: searchText, queryText: queryText));
              }
            },
            decoration: InputDecoration(
              suffixIcon: textBox ? IconButton(onPressed :() { setState(() {
                textController.clear();
                textBox = false;
              });}, icon: Icon(FontAwesomeIcons.circleXmark)) : null,
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
                        margin:
                            const EdgeInsets.only(left: 15, right: 15, top: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // queryText == "Meaning"
                                    //     ? Text('$queryText : ',
                                    //         style: const TextStyle(
                                    //             fontSize: 18,
                                    //             fontWeight: FontWeight.bold))
                                    //     : const Text(''),
                                    Expanded(
                                      child: Text(
                                        utf8.decode((responseState.TabsAPI
                                                .choices?[0].message?.content)
                                            .toString()
                                            .runes
                                            .toList()),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () => {
                                      context.read<QuotesBloc>().add(GetTabsAPI(
                                          searchText: searchText,
                                          queryText: queryText))
                                    },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(FontAwesomeIcons.rotateRight),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "Regenerate",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      );
                    default:
                      return const SizedBox();
                  }
                },
              )),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
