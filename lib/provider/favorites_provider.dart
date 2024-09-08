import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoritesMealsNotiftier extends StateNotifier<List<Meal>> {
  FavoritesMealsNotiftier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return true;
    } else {
      state = [...state, meal];
      return false;
    }
  }
}

final favoritesMealsProvider =
    StateNotifierProvider<FavoritesMealsNotiftier, List<Meal>>((ref) {
  return FavoritesMealsNotiftier();
});
