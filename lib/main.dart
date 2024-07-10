import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:openai_app/features/home/homepage.dart';
import 'package:openai_app/features/APIcall/bloc/quotes_bloc.dart';
import 'package:openai_app/features/local_storage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'features/Favorites/bloc/firebase_bloc.dart';
import 'features/Favorites/repo/firestore_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await PreferenceHelper.initiate();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<QuotesBloc>(
            create: (context) => QuotesBloc(),
          ),
          BlocProvider<FirebaseBloc>(
            create: (context) => FirebaseBloc(FirestoreService()),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
          ),
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          home: const Homepage(),
        ),
      ),
    );
  }
}
