import 'package:flutter/material.dart';
import 'package:openai_app/features/local_storage.dart';

void showBottomSheetModal(context, Null Function() refresh) {
  final List<String> language = [
    "Hindi",
    "English",
  ];
  final List<String> topics = [
    "Motivation",
    "Love",
    "Life",
    "Friendship",
    "Success",
    "Science",
    "Music",
    "Video Games",
    "Comedy",
    "Sports",
    "Self-Love"
  ];

  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isDismissible: true,
    context: context,
    builder: (context) {
      return Modal(language: language, topics: topics, refresh: refresh);
    },
  );
}

class Modal extends StatefulWidget {
  const Modal({
    super.key,
    required this.language,
    required this.topics,
    this.refresh,
  });

  final List<String> language;
  final List<String> topics;
  final Function()? refresh;

  @override
  _ModalState createState() => _ModalState();
}

class _ModalState extends State<Modal> {
  @override
  void initState() {
    super.initState();
    displayItems = widget.language;
  }

  late List<String> displayItems;
  List<String> selectedItems = ["English"];
  String header = "Select a preferred Language :";
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: Wrap(
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  PreferenceHelper.setString(key: 'language', value: "English");
                  widget.refresh!();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.0),
                        color: Colors.white),
                    padding: const EdgeInsets.all(8.0),
                    child: const Icon(Icons.close),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    color: Colors.white),
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            header,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 3,
                      ),
                      shrinkWrap: true,
                      itemCount: displayItems.length,
                      itemBuilder: (context, index) {
                        final item = displayItems[index];
                        final isSelected = selectedItems.contains(item);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (displayItems == widget.language &&
                                  item != displayItems[1]) {
                                errorText = "*This may not work as expected";
                              } else {
                                errorText = '';
                              }

                              if (isSelected) {
                                selectedItems.remove(item);
                              } else {
                                displayItems == widget.language
                                    ? selectedItems[0] = item
                                    : selectedItems.add(item);
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  isSelected ? Colors.blue : Colors.grey[200],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                item,
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    errorText != ''
                        ? Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(errorText,
                                style: const TextStyle(color: Colors.red)),
                          )
                        : const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          displayItems == widget.topics
                              ? ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      displayItems = widget.language;
                                      header = "Select a preferred language :";
                                      if (displayItems == widget.language &&
                                          selectedItems[0] != displayItems[1]) {
                                        errorText =
                                            "*This may not work as expected";
                                      } else {
                                        errorText = '';
                                      }
                                    });
                                  },
                                  child: const Row(
                                    children: [
                                      Icon(Icons.arrow_left),
                                      Text("Prev"),
                                    ],
                                  ))
                              : const SizedBox(),
                          ElevatedButton(
                              onPressed: () {
                                if (displayItems == widget.topics) {
                                  PreferenceHelper.setString(
                                      key: 'language', value: selectedItems[0]);
                                  PreferenceHelper.setStringList(
                                      key: 'topics',
                                      value: selectedItems.sublist(1));
                                  widget.refresh!();
                                  Navigator.of(context).pop();
                                } else {
                                  setState(() {
                                    displayItems = widget.topics;
                                    errorText = '';
                                    header =
                                        "Select Few topics that interests you :";
                                  });
                                }
                              },
                              child: const Row(
                                children: [
                                  Text("Next"),
                                  Icon(Icons.arrow_right),
                                ],
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
