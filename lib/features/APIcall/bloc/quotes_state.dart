part of 'quotes_bloc.dart';

@immutable
sealed class QuotesState {}

final class QuotesInitial extends QuotesState {}


class QuotesLoadingState extends QuotesState {}

class QuotesErrorState extends QuotesState {}

class QuotesSuccessfullState extends QuotesState {
  OpenAiRes quotes;
  QuotesSuccessfullState({required this.quotes});
}