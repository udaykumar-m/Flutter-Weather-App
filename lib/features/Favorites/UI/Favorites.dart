import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udid/flutter_udid.dart';

import '../bloc/firebase_bloc.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  String udid = '';

  @override
  void initState() {
    context.read<FirebaseBloc>().add(DataLoading());
    super.initState();
    _fetchUDID();
  }

  Future<void> _fetchUDID() async {
    String udid = await FlutterUdid.consistentUdid;
    setState(() {
      udid = udid;
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
      body: BlocBuilder<FirebaseBloc, FirebaseState>(builder: (context, state) {
        if (state is FirebaseInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FirebaseLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FirebaseLoaded) {
          return ListView.builder(
            itemCount: state.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.data[index].quote),
                subtitle: Text(state.data[index].word),
                trailing: IconButton(
                  onPressed: () {
                    context.read<FirebaseBloc>().add(
                          DeleteData(state.data[index]),
                        );

                    context.read<FirebaseBloc>().add(DataLoading());
                  },
                  icon: const Icon(Icons.delete),
                ),
              );
            },
          );
        } else if (state is FirebaseError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is FirebaseSuccess) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: Text("Something went wrong"),
          );
        }
      }),
    );
  }
}
