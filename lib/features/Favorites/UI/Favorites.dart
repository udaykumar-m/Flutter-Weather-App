import 'package:flutter/material.dart';

import '../../home/bottom_sheet.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Favorites"),
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios)),
      ),
      floatingActionButton: FloatingActionButton( onPressed: () { showBottomSheetModal(context); },
        child: const Icon(Icons.add),),
    );
  }
}