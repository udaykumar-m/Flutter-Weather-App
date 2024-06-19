part of 'tabs_bloc.dart';

@immutable
sealed class TabsEvent {}

class GetTabsAPI extends TabsEvent {
  final String searchText;
  final String queryText;
  GetTabsAPI({required this.searchText, required this.queryText});
}
