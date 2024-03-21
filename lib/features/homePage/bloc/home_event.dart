part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent{}

class ImageClickedEvent extends HomeEvent{
  final CarModel selectedModel;

  ImageClickedEvent({required this.selectedModel});
}