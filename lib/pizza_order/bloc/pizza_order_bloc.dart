import 'package:flutter/foundation.dart' show ChangeNotifier, ValueNotifier;
import 'package:flutter_animation/pizza_order/constant/ingredient.dart';

class PizzaOrderBLoC extends ChangeNotifier{
  final listIngredients = <Ingredient>[];
  final notifierTotal = ValueNotifier(15);
  final notifierDeletedIngredient = ValueNotifier<Ingredient>(null);
  void addIngredient(Ingredient ingredient){
    listIngredients.add(ingredient);
    notifierTotal.value++;
  }

  bool containsIngredient(Ingredient ingredient){
    for (Ingredient i in listIngredients) {
      if (i.compare(ingredient)) {
        return true;
      }
    }
    return false;
  }

  void removeIngredient(Ingredient ingredient) {
    listIngredients.remove(ingredient);
    notifierTotal.value--;
    notifierDeletedIngredient.value =ingredient;

  }

  void refreshDeletedIngredient() {
    notifierDeletedIngredient.value = null;
  }

}