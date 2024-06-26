 import 'package:flutter/material.dart';

void showBottomSheetModal(context) {

   final List<String> items = ["Item 1", "Item 2", "Item 3", "Item 4"];
   final List<String> items2 = ["Item ", "Item 2", "Item 3", "Item 4"];

  final List<String> selectedItems = [];

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isDismissible: true,
      context: context,
      builder: (context) {
        return Modal(items: items, selectedItems: selectedItems);
      },
    );
  }

class Modal extends StatefulWidget {
  const Modal({
    Key? key,
    required this.items,
    required this.selectedItems,
  }) : super(key: key);

  final List<String> items;
  final List<String> selectedItems;

  @override
  _ModalState createState() => _ModalState();
}

class _ModalState extends State<Modal> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2.0),
                              color: Colors.white
                            ),
                padding: const EdgeInsets.all(8.0),
                child: const Icon(Icons.close),
        
              ),
            ),
            Container(
               decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                            color: Colors.white
                          ),
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: Column(
                children: [
                  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 3,
                    ),
                    shrinkWrap: true,
                    itemCount: widget.items.length,
                    itemBuilder: (context, index) {
                      final item = widget.items[index];
                      final isSelected = widget.selectedItems.contains(item);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              widget.selectedItems.remove(item);
                            } else {
                              widget.selectedItems.add(item);
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.blue : Colors.grey[200],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              item,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(onPressed: (){}, 
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        Text("Next"),
                        Icon(Icons.arrow_right),
                        ],
                      )),
                    ],
                  )
                ],
              ),
              
            ),
          ],
        ),
      ],
    );
  }
}