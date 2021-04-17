import 'package:flutter/material.dart';
import 'package:flutter_animation/pizza_order/main_pizza_order.dart';

void main() {
  runApp(MaterialApp(
    title: "Pizza Animation",
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: MainPizzaOrderApp(),
  ));
}
