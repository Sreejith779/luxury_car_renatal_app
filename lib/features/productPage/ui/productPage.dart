import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:luxury_car_renatal_app/features/homePage/model/modelData.dart';
import 'package:luxury_car_renatal_app/modelData/amount.dart';
import 'package:luxury_car_renatal_app/modelData/payment/payment.dart';
import 'package:http/http.dart'as http;

import '../bloc/product_bloc.dart';


class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.selectedCarModel});
  final CarModel selectedCarModel;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {


  @override
  void initState() {
   productBloc.add(ProductInitialEvent());
    super.initState();
  }
  final ProductBloc productBloc = ProductBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      bloc: productBloc,

      listenWhen: (previous,current)=>(current is ProductActionState),
      buildWhen: (previous,current)=>(current is !ProductActionState),
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {

        switch(state.runtimeType){
          case ProductLoadedState:
           late  double finalAmount;

             Map<String,dynamic>?paymentIntend;
            return Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(widget.selectedCarModel.image),
                    fit: BoxFit.cover  )
                    ),
                  ),
                  const SizedBox(height: 10,),

                  Container(

                    margin: const EdgeInsets.only(left: 10,right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.selectedCarModel.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600
                        ),),
                         Row(
                          children: [
                            const Icon(Icons.star,color: Colors.yellow,),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(widget.selectedCarModel.rating.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18
                            ),),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(widget.selectedCarModel.reviews,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.brown
                            ),),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.withOpacity(0.8),
                              ),

                              child: Center(child: Text("Rs ${widget.selectedCarModel.pricePerHour.toString()}/hour",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                              ),)),
                            ),
                            const SizedBox(width: 10,),
                              InkWell(
                              onTap: (){
                             setState(() {
                               finalAmount = widget.selectedCarModel.pricePerDay;
                                print("selected");
                             });
                              },
                              child:

                   Container(
                                height: 50,
                                width: 150,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: Colors.grey.withOpacity(0.8),
                               ),
                                child: Center(child: Text("Rs ${widget.selectedCarModel.pricePerDay.toString()}/Day",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500
                                  ),)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(widget.selectedCarModel.description,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,

                        ),),//description
                        const SizedBox(
                          height: 20,
                        ),
                         Container(
                           padding: EdgeInsets.all(10),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Engine",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                              ),),
                              Text(widget.selectedCarModel.engine,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600
                                  )),

                            ],
                                                   ),
                         ), //engine

                        Container(
                          margin: EdgeInsets.only(left: 10,right: 10),
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(width:2,color: Colors.black54)
                              )
                          ),
                        ), //
                        // border

                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Wheelbase",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600
                                ),),
                              Text(widget.selectedCarModel.wheelbase.toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600
                                  )),

                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),

                        InkWell(
                          onTap: (){
                         makePayment();
                          },
                          child: Container(
                            height: 60,
                                                width: double.maxFinite,
                                                decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.brown,
                                                ),
                          child: Center(child: Text("Book Now",
                          style: TextStyle(fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.9)),)),
                          ),
                        )//book now


                      ],
                    ),
                  ),

                ],
              ),
            );
            break;
          default:
            return const Center(child: Text("Error"));
        }

      },
    );
  }

  Future<void> makePayment() async {
    try {
      final paymentIntent = await createPaymentIntent();
      await initAndPresentPaymentSheet(paymentIntent);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent() async {

    try {
      final body = {
        "amount": "250000",
        "currency": "INR",
      };

      final response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        headers: {
          'Authorization': 'Bearer ADD YOUR KEY',
          'Content-type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );

      return json.decode(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> initAndPresentPaymentSheet(Map<String, dynamic> paymentIntent) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          style: ThemeMode.light,
          merchantDisplayName: 'Luxury Cars',
        ),
      );
      await Stripe.instance.presentPaymentSheet();
      print("Payment successful");
    } catch (e) {
      print(e.toString());
    }
  }
}
