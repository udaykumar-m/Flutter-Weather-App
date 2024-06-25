import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../home/bottom_sheet.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Favorites"),
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios)),
      ),
      floatingActionButton: FloatingActionButton( onPressed: () { showBottomSheetModal(context); },
        child: Icon(Icons.add),),
    );
  }
}