import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openai_app/features/home/homepage.dart';
import 'package:openai_app/features/home/internet_connection.dart';
import 'package:openai_app/features/APIcall/bloc/quotes_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: BlocProvider(
        create: (context) => QuotesBloc(),
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
