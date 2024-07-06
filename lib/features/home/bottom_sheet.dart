import 'package:flutter/material.dart';
import 'package:openai_app/features/local_storage.dart';

void showBottomSheetModal(context) {
  final List<String> language = [
    "Hindi",
    "English",
    "Telugu",
  ];
  final List<String> topics = [
    "Sports",
    "Movie",
    "life",
    "Love",
    "Breakup",
    "Work"
  ];

  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isDismissible: true,
    context: context,
    builder: (context) {
      return Modal(items: language, test: topics);
    },
  );
}

class Modal extends StatefulWidget {
  const Modal({
    super.key,
    required this.items,
    required this.test,
  });

  final List<String> items;
  final List<String> test;

  @override
  _ModalState createState() => _ModalState();
}

class _ModalState extends State<Modal> {
  @override
  void initState() {
    super.initState();
    displayItems = widget.items;
  }

  late List<String> displayItems;
  List<String> selectedItems = ["English"];
  String header = "Select a preferred Language :";

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
                              if (isSelected) {
                                selectedItems.remove(item);
                              } else {
                                displayItems == widget.items
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
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          displayItems == widget.test
                              ? ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      displayItems = widget.items;
                                      header = "Select a preferred language :";
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
                                if (displayItems == widget.test) {
                                  PreferenceHelper.setString(
                                      key: 'language', value: selectedItems[0]);
                                  PreferenceHelper.setStringList(
                                      key: 'topics',
                                      value: selectedItems.sublist(1));
                                  Navigator.of(context).pop();
                                } else {
                                  setState(() {
                                    displayItems = widget.test;

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
