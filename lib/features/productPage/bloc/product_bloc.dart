import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:luxury_car_renatal_app/features/homePage/model/modelData.dart';
import 'package:luxury_car_renatal_app/modelData/amount.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
  on<ProductInitialEvent>(productInitialEvent);
  on<AmountClickedEvent>(amountClickedEvent);
  }

  FutureOr<void> productInitialEvent(ProductInitialEvent event, Emitter<ProductState> emit) {
emit(ProductLoadedState());
  }

  FutureOr<void> amountClickedEvent(AmountClickedEvent event, Emitter<ProductState> emit) {

    final amount = event.carModel.pricePerDay;
    emit(AmountClickedActionState());
  }
}
