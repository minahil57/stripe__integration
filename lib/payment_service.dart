// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:stripe_integration/secret_keys.dart';

class PaymentService {
 

  static Future<void> initialize() async {
    Stripe.publishableKey = publishableKey;
    await Stripe.instance.applySettings();
  }

  static Future<PaymentIntent> createPaymentIntent(
      String amount, String currency) async {
    try {
      // Create payment intent on the server
      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          'amount': amount.toString(),
          'currency': currency,
          'payment_method_types[]': 'card'
        },
      );

      log('Stripe Response: ${response.body}'); // Log the response

      final jsonResponse = jsonDecode(response.body);

// Check if Stripe returned an error
      if (jsonResponse.containsKey('error')) {
        throw Exception(
            'Stripe API Error: ${jsonResponse['error']['message']}');
      }

// Ensure jsonResponse has the expected structure
      if (!jsonResponse.containsKey('client_secret')) {
        throw Exception('Invalid response: Missing client_secret.');
      }

      return PaymentIntent.fromJson(jsonResponse);
    } catch (e) {
      throw Exception('Failed to create payment intent: $e');
    }
  }

  static Future<void> processPayment(String amount, String currency) async {
    try {
      // Create payment intent
      final paymentIntent = await createPaymentIntent(amount, currency);

      // Initialize payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent.clientSecret,
          merchantDisplayName: 'Indasy',
          style: ThemeMode.dark,
        ),
      );

      // Present payment sheet
      await Stripe.instance.presentPaymentSheet();

      // Payment successful
      log('Payment completed');
    } catch (e) {
      if (e is StripeException) {
        log('Error from Stripe: ${e.error.localizedMessage}');
      } else {
        log('Error: $e');
      }
      throw Exception(e);
    }
  }
}
class PaymentIntent {
  final String id;
  final String clientSecret;
  final int amount; // Ensure amount is int
  final String currency;
  final int created; // Ensure created is int

  PaymentIntent({
    required this.id,
    required this.clientSecret,
    required this.amount,
    required this.currency,
    required this.created,
  });

  factory PaymentIntent.fromJson(Map<String, dynamic> json) {
    return PaymentIntent(
      id: json['id'],
      clientSecret: json['client_secret'],
      amount: json['amount'],  // Ensure amount is int
      currency: json['currency'],
      created: json['created'], // Ensure created is int
    );
  }
}
