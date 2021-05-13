import 'package:flutter/material.dart';
import 'package:flutter_animation/expandable_nav_bar/expandable_nav_bar.dart';
import 'package:flutter_animation/pizza_order/main_pizza_order.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Animation"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => MainPizzaOrderApp()));
                  },
                  child: Text("Pizza Animation")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ExpandableNavBar()));
                  },
                  child: Text("Bottom Nav Animation")),
            ),
          ],
        ),
      ),
    );
  }
}
