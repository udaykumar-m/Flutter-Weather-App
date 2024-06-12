import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openai_app/features/quotes/UI/quotes_ui.dart';
import 'package:openai_app/features/quotes/bloc/quotes_bloc.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("AI pal"),
      ),
      body: const Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                    child: Quotes(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Buttons(),
                ),
              ],
            )
          ),
          Expanded(
            flex: 2,
            child: const Placeholder(),
          )
        ],
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: (){
            
          }, 
          label: Text("Like"), 
          icon: Icon(Icons.favorite)
        ),
    
       const SizedBox(width: 15,),
    
        ElevatedButton.icon(
          onPressed: (){
            context.read<QuotesBloc>().add(GetQuotesInitial());
          }, 
          label: Text("Next"), 
          icon: Icon(Icons.arrow_forward_ios)
        ),
      ],
    );
  }
}
