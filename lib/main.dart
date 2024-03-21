import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:luxury_car_renatal_app/features/onBoarding/ui/onBoardingPage.dart';
import 'package:http/http.dart'as http;

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
  "pk_test_51OvjEYSGWwB7XuMbH0P1ijnr7hxDX24iXLUR4VSr7JawBHHbaIexz3Er17uuy8avfy6UHUh2nsmNATKLeiDGNIn900J1uv5HvK";
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingPage(),
    );
  }
}
