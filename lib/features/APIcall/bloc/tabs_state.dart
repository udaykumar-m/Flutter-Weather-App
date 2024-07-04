part of 'tabs_bloc.dart';

@immutable
sealed class TabsState {}

final class TabsInitial extends TabsState {}

class TabsAPILoadingState extends TabsState {}

class TabsAPIErrorState extends TabsState {}

class TabsAPISuccessfullState extends TabsState {
  final OpenAiRes TabsAPI;
  TabsAPISuccessfullState({required this.TabsAPI});
}
