part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class ProductInitialEvent extends ProductEvent{}

class AmountClickedEvent extends ProductEvent{
  final CarModel carModel;

  AmountClickedEvent({required this.carModel});
}