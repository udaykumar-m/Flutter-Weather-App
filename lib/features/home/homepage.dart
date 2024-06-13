import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:openai_app/features/APIcall/UI/tabs_ui.dart';
import 'package:openai_app/features/home/internet_connection.dart';
import 'package:openai_app/features/APIcall/UI/quotes_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:openai_app/features/APIcall/bloc/quotes_bloc.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternetConnection();
  }

  bool? _hasConnection;

  Future<void> checkInternetConnection() async {
    _hasConnection = await InternetConnectionChecker().hasConnection;
    print(_hasConnection);
    print("-------------------------------");
    networkLogic();
    setState(() {
      
    });
  }


  void networkLogic(){
    
    WidgetsBinding.instance!.addPostFrameCallback((_){
      if (_hasConnection != true) {
        showDialog(context: context, builder: (BuildContext context ) => InternetConnection(onPressed: ()async {
          _hasConnection = await InternetConnectionChecker().hasConnection;
          if(_hasConnection == true) 
            Navigator.pop(context);
          
          setState(() {
      
          });
        },));
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("AI pal"),
      ),
      body: Column(
        children: [
          if(_hasConnection == true)
          const Expanded(
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
          const Expanded(
            flex: 3,
            child: DefaultTabController(
              initialIndex: 1,
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(icon: Icon(FontAwesomeIcons.instagram)),
                      Tab(icon: Icon(FontAwesomeIcons.spellCheck)),
                      Tab(icon: Icon(FontAwesomeIcons.twitter)),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        tabs(),
                        tabs(),
                        tabs(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
