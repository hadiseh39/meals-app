import 'package:flutter/material.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  final List<Meal> _FavoriteMeals = [];

  void _showInfoMessage(String massage) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(massage)));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
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

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const FiltersScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    String activePageTitle = 'Select a category';

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
    );

    if (_selectedPageIndex == 1) {
      activePageTitle = 'Favorite meals';
      activePage = MealsScreen(
        meals: _FavoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(activePageTitle),
        ),
        drawer: MainDrawer(onSelectedScreen: _setScreen),
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
        ));
  }
}
