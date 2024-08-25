import 'package:flutter/material.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/meal.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  final List<Meal> _FavoriteMeals = [];

  void _showInfoMessage(String massage){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(massage)));
  }

  void _toggleMealFavoriteStatus(Meal meal){
    final isExisting = _FavoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _FavoriteMeals.remove(meal);
      });
      _showInfoMessage('removed');
    } else {
      setState(() {
        _FavoriteMeals.add(meal);
      });
      _showInfoMessage('added');
    }
  }

  void _selectPage(int index){
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      );

    if(_selectedPageIndex == 1){
      activePage = MealsScreen(
        title: 'Favorite meals', 
        meals: _FavoriteMeals, 
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
    }


    return Scaffold(
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
        ],
      )
    );
  }
}