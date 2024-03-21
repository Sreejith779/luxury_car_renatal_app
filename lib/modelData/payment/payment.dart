import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

Map<String, dynamic>? paymentIntent;

void makePayment() async {
  try {
    // Step 1: Create payment intent
    paymentIntent = await createPaymentIntent();

    // Step 2: Initialize payment sheet
    var gpay = const PaymentSheetGooglePay(
      merchantCountryCode: "US",
      currencyCode: "USD",
      testEnv: true,
    );
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntent!["client_secret"],
        style: ThemeMode.dark,
        merchantDisplayName: "Luxury Cars",
        googlePay: gpay,
      ),
    );

    // Step 3: Display payment sheet
    await displayPaymentSheet();
  } catch (e) {
    print(e.toString());
  }
}

Future<void> displayPaymentSheet() async {
  try {
    await Stripe.instance.presentPaymentSheet();
    print("done");
  } catch (e) {
    print("Failed to present payment sheet: $e");
  }
}

Future<Map<String, dynamic>> createPaymentIntent() async {
  try {
    Map<String, dynamic> body = {
      "amount": 5000,
      "currency": "USD",
    };
    http.Response response = await http.post(
      Uri.parse("https://api.stripe.com/v1/payment_intents"),
      body: body,
      headers: {
        "Authorization":
        "Bearer sk_test_51OvjEYSGWwB7XuMbWvz1YXa9NltKcCwTTkZG8NFxDMnSMfRB4aRM1dhy9jXbjvmTvKj82sVJJihTMn57PcEGoGFX00RkP8c5KX",
        "Content-Type": "application/x-www-form-urlencoded",
      },
    );
    return json.decode(response.body);
  } catch (e) {
    throw Exception(e.toString());
  }
}
