import 'package:flutter/material.dart';
import 'package:flutter_animation/pizza_order/bloc/pizza_order_bloc.dart';

class PizzaOrderProvider extends InheritedWidget {
  PizzaOrderProvider({this.bloc, @required this.child}) : super(child: child);
  final PizzaOrderBLoC bloc;
  final Widget child;

  static PizzaOrderBLoC of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<PizzaOrderProvider>().bloc;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
