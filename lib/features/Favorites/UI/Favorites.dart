import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  String udid = '';

  @override
  void initState() {
    super.initState();
    _fetchUDID();
  }

  Future<void> _fetchUDID() async {
    String _udid = await FlutterUdid.udid;
    setState(() {
      udid = _udid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Favorites"),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        children: [
        ],
      ),
    );
  }
}
