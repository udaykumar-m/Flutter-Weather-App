part of 'quotes_bloc.dart';

@immutable
sealed class QuotesEvent {}

class GetQuotesInitial extends QuotesEvent {}

class GetQuotes extends QuotesEvent{}
