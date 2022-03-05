import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {
      'page': CategoriesScreen(),
      'name': 'Categories Screen',
    },
    {
      'page': FavoritesScreen(),
      'name': 'Favorites Screen',
    },
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      // child: Scaffold(
      //   appBar: AppBar(
      //     title: Text('Meals'),
      //     bottom: TabBar(
      //       tabs: [
      //         Tab(
      //           icon: Icon(Icons.category),
      //           text: 'Categories',
      //         ),
      //         Tab(
      //           icon: Icon(Icons.star),
      //           text: 'Favorites',
      //         ),
      //       ],
      //     ),
      //   ),
      //   body: TabBarView(children: [
      //     CategoriesScreen(),
      //     FavoritesScreen(),
      //   ]),
      // ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedPageIndex]['name'] as String),
        ),
        body: _pages[_selectedPageIndex]['page'] as Widget,
        drawer: Drawer(
          child: Text('data'),
        ),
        bottomNavigationBar: BottomNavigationBar(
            onTap: _selectPage,
            backgroundColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.white,
            selectedItemColor: Theme.of(context).accentColor,
            currentIndex: _selectedPageIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                title: Text('Categories'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                title: Text('Favorites'),
              )
            ]),
      ),
    );
  }
}
