import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/widgets/meal_filter_check.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:tab_container/tab_container.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/provider/favorites_provider.dart';

class MealDetails extends ConsumerWidget {
  const MealDetails({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeal = ref.watch(favoritesMealsProvider);
    final isFavorite = favoriteMeal.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () {
                final wasAdded = ref
                    .read(favoritesMealsProvider.notifier)
                    .toggleMealFavoriteStatus(meal);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(wasAdded
                        ? 'Removed from favorite meals.'
                        : 'Added to favorite meals.'),
                  ),
                );
              },
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  key: ValueKey(isFavorite),
                ),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MealItemTrait(
                  icon: Icons.schedule,
                  label: '${meal.duration} min',
                ),
                const SizedBox(
                  width: 15,
                ),
                MealItemTrait(
                  icon: Icons.work,
                  label: meal.complexity.name[0].toUpperCase() +
                      meal.complexity.name.substring(1),
                ),
                const SizedBox(
                  width: 15,
                ),
                MealItemTrait(
                  icon: Icons.attach_money,
                  label: meal.affordability.name[0].toUpperCase() +
                      meal.affordability.name.substring(1),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      FilterCheck(
                          filter: meal.isGlutenFree, text: 'Gluten-free'),
                      FilterCheck(
                          filter: meal.isLactoseFree, text: 'Lactose-free'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      FilterCheck(
                          filter: meal.isVegetarian, text: 'Vegetarian'),
                      FilterCheck(filter: meal.isVegan, text: 'Vegan'),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TabContainer(
                tabEdge: TabEdge.top,
                tabsStart: 0.05,
                tabsEnd: 0.9,
                borderRadius: BorderRadius.circular(15),
                tabBorderRadius: BorderRadius.circular(15),
                childPadding: const EdgeInsets.all(20.0),
                selectedTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                unselectedTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
                colors: [
                  Theme.of(context).colorScheme.onSecondary,
                  Theme.of(context).colorScheme.onPrimary,
                ],
                tabs: const [
                  Text('ingredients'),
                  Text('steps'),
                ],
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    child: Column(
                      children: [
                        for (final ingredient in meal.ingredients)
                          Text(
                            ingredient,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    child: Column(
                      children: [
                        for (final steps in meal.steps)
                          Text(
                            steps,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
