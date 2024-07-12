import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/firebase_bloc.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  void initState() {
    context.read<FirebaseBloc>().add(DataLoading());
    super.initState();
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
        final stateHandlers = {
          FirebaseInitial: () =>
              const Center(child: CircularProgressIndicator()),
          FirebaseLoading: () =>
              const Center(child: CircularProgressIndicator()),
          FirebaseLoaded: (FirebaseLoaded state) => cardView(state),
          FirebaseError: (FirebaseError state) =>
              Center(child: Text(state.message)),
          FirebaseSuccess: (FirebaseSuccess state) =>
              Center(child: Text(state.message)),
          FirebaseDeleteSuccess: (FirebaseDeleteSuccess state) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  duration: const Duration(seconds: 2),
                  backgroundColor: Colors.green,
                ),
              );
            });
          }
        };

        var widgetBuilder = stateHandlers[state.runtimeType];
        if (widgetBuilder != null) {
          return (state is FirebaseLoaded ||
                  state is FirebaseError ||
                  state is FirebaseSuccess ||
                  state is FirebaseDeleteSuccess)
              ? widgetBuilder(state)
              : widgetBuilder();
        } else {
          return const Center(child: Text("Something went wrong"));
        }
      }),
    );
  }

  ListView cardView(FirebaseLoaded state) {
    return ListView.builder(
      itemCount: state.data.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async => await Clipboard.setData(
              ClipboardData(text: state.data[index].text)),
          child: Card(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(state.data[index].word,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    CircleAvatar(
                      radius: 24,
                      backgroundColor:
                          Theme.of(context).highlightColor.withAlpha(80),
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor:
                            Theme.of(context).cardColor.withOpacity(0.8),
                        child: IconButton(
                          icon: const Icon(Icons.share),
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
              ),
              subtitle: Row(
                children: [
                  Expanded(child: Text(state.data[index].text)),
                  IconButton(
                    onPressed: () {
                      context
                          .read<FirebaseBloc>()
                          .add(DeleteData(state.data[index]));
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
