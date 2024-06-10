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
        title: Text("AI pal"),
      ),
      body: const Column(
        children: [
          Quotes(),
          Buttons(),
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
      children: [
        ElevatedButton.icon(
          onPressed: (){
            
          }, 
          label: Text("Like"), 
          icon: Icon(Icons.favorite)
        ),
    
    
    
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
