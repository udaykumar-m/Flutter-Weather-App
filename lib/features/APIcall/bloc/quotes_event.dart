part of 'quotes_bloc.dart';

@immutable
sealed class QuotesEvent {}

class GetQuotesInitial extends QuotesEvent {}

class GetTabsAPI extends QuotesEvent {
  final String searchText;
  final String queryText;
  GetTabsAPI({required this.searchText, required this.queryText});
}
