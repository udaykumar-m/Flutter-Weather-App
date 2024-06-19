import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:openai_app/features/APIcall/model/Open_ai_model.dart';
import 'package:openai_app/features/APIcall/repo/quotes_repo.dart';

part 'quotes_event.dart';
part 'quotes_state.dart';

class QuotesBloc extends Bloc<QuotesEvent, QuotesState> {
  QuotesBloc() : super(QuotesInitial()) {
    on<GetQuotesInitial>(QuotesInitialEvent);
  }

  FutureOr<void> QuotesInitialEvent(
      GetQuotesInitial event, Emitter<QuotesState> emit) async {
    emit(QuotesLoadingState());
    OpenAiRes quote = await QuotesRepo.GetQuotesAPI();
    emit(QuotesSuccessfullState(quotes: quote));
  }
}
