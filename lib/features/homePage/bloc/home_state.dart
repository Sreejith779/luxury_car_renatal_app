part of 'home_bloc.dart';

@immutable
abstract class HomeState {}
abstract class HomeActionState extends HomeState{}

class HomeInitial extends HomeState {}
class HomeLoadedState extends HomeState{

  final List<CarModel>carModel = luxuryCars.map((e) => CarModel(id: e['id'], name: e['name'],
      rating: e['rating'], pricePerHour: e['pricePerHour'], description: e['description'], engine:e ['engine'],
      wheelbase: e['wheelbase'], model: e['model'], image: e['image'],
      image1:e ['image1'], image2: e['image2'], reviews: e['reviews'], pricePerDay: e['pricePerDay'])).toList();
}

class ImageClickedActionState extends HomeActionState{
  final CarModel carModel;

  ImageClickedActionState({required this.carModel});
}