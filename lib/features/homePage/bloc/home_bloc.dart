import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:luxury_car_renatal_app/modelData/carModel.dart';
import 'package:meta/meta.dart';

import '../model/modelData.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<ImageClickedEvent>(imageClickedEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) {
    emit(HomeLoadedState());
  }

  FutureOr<void> imageClickedEvent(
      ImageClickedEvent event, Emitter<HomeState> emit) {
    emit(ImageClickedActionState(carModel: event.selectedModel));
  }
}
