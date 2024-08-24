import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class MealDetails extends StatelessWidget {
  const MealDetails({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 14,),
            Text(
              'ingredients', 
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 10,),
            for(final ingredient in meal.ingredients) Text(ingredient, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 20,),
            Text(
              'steps', 
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 10,),
            for(final steps in meal.steps) Text(steps, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),)
          ],
        ),
      ),
    );
  }
}