import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/quotes_bloc.dart';

class Quotes extends StatelessWidget {
  const Quotes({super.key});

  @override
  Widget build(BuildContext context) {
    return QuotesBody();
  }
}

class QuotesBody extends StatefulWidget {
  const QuotesBody({super.key});

  @override
  State<QuotesBody> createState() => _QuotesBodyState();
}

class _QuotesBodyState extends State<QuotesBody> {
  @override
  void initState() {
    context.read<QuotesBloc>().add(GetQuotesInitial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black87,
      child: BlocBuilder<QuotesBloc, QuotesState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case QuotesLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case QuotesSuccessfullState:
              final responseState = state as QuotesSuccessfullState;
              return Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text((responseState.quotes.choices?[0].message?.content)
                        .toString()),
                  ],
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
