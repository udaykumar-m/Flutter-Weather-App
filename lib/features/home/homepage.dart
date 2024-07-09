import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openai_app/features/APIcall/UI/tabs_ui.dart';
import 'package:openai_app/features/APIcall/bloc/tabs_bloc.dart';
import 'package:openai_app/features/APIcall/repo/networkLogic.dart';
import 'package:openai_app/features/APIcall/UI/quotes_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:openai_app/features/APIcall/bloc/quotes_bloc.dart';
import 'package:openai_app/features/Favorites/UI/Favorites.dart';
import 'package:openai_app/features/Favorites/bloc/firebase_bloc.dart';
import 'package:openai_app/features/home/bottom_sheet.dart';
import 'package:openai_app/features/local_storage.dart';

import '../Favorites/repo/firestore_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool language = false;

  @override
  void initState() {
    super.initState();

    checkInternetConnection();

    _tabController = TabController(initialIndex: 1, length: 3, vsync: this);

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging || _tabController.indexIsChanging) {
        hideKeyboard(context);
      }
    });

    // PreferenceHelper.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      PreferenceHelper.getString('language') == ''
          ? showBottomSheetModal(context, () {
              setState(() {
                language = true;
              });
            })
          : language = true;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool? _hasConnection;

  Future<void> checkInternetConnection() async {
    _hasConnection = await networkLogicClass().networkConnection();
    networkLogicClass.networkLogic(context, _hasConnection, () {
      setState(() {
        _hasConnection = true;
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("AI pal"),
          actions: [
            kDebugMode
                ? IconButton(
                    onPressed: () {
                      // PreferenceHelper.clear();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                    create: (context) =>
                                        FirebaseBloc(FirestoreService()),
                                    child: const Favorites(),
                                  )));
                    },
                    icon: const Icon(Icons.favorite))
                : const SizedBox()
          ],
        ),
        body: Column(
          children: [
            if (_hasConnection == true)
              BlocProvider(
                create: (context) => QuotesBloc(),
                child: Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
                            child: language ? Quotes() : SizedBox(),
                          ),
                        ),
                        const Buttons(),
                      ],
                    )),
              ),
            BlocProvider(
              create: (context) => TabsBloc(),
              child: Expanded(
                flex: 7,
                child: DefaultTabController(
                  initialIndex: 1,
                  length: 3,
                  child: Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        tabs: const [
                          Tab(icon: Icon(FontAwesomeIcons.instagram)),
                          Tab(icon: Icon(FontAwesomeIcons.spellCheck)),
                          Tab(icon: Icon(FontAwesomeIcons.twitter)),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: const [
                            tabs(tabPage: "Instagram"),
                            tabs(tabPage: "Meaning"),
                            tabs(tabPage: "Twitter"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}

class Buttons extends StatefulWidget {
  const Buttons({
    super.key,
  });

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  void showToast(BuildContext context) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    print(isDarkTheme);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: "Saving ",
              style:
                  TextStyle(color: isDarkTheme ? Colors.black : Colors.white),
              children: <TextSpan>[
                TextSpan(
                  text: "Quotes",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDarkTheme ? Colors.black : Colors.white),
                ),
                TextSpan(
                  text: " will be available from next Update",
                  style: TextStyle(
                      color: isDarkTheme ? Colors.black : Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      behavior: SnackBarBehavior.floating,
      // width: 260.0,
      duration: const Duration(milliseconds: 1500),
      elevation: 0,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
            onPressed: () => showToast(context),
            label: const Text("Like"),
            icon: const Icon(Icons.favorite)),
        const SizedBox(
          width: 15,
        ),
        ElevatedButton.icon(
            onPressed: () async {
              bool hasConnection =
                  await networkLogicClass().networkConnection();
              networkLogicClass.networkLogic(context, hasConnection, () {
                setState(() {
                  hasConnection = true;
                });
              });
              if (hasConnection == true) {
                context.read<QuotesBloc>().add(GetQuotesInitial());
              }
            },
            label: const Text("Next"),
            icon: const Icon(Icons.arrow_forward_ios)),
      ],
    );
  }
}
