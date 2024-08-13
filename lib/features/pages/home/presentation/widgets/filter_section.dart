import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/filter_screen.dart';

import 'package:flutter/material.dart';

class Filtering extends StatefulWidget {
  const Filtering(
      {super.key,
      required String initialSortOption,
      required Map<String, bool> initialPriceFilters,
      required Map<String, bool> initialCategoryFilters,
      required Map<String, bool> initialMaterialFilters,
      required Null Function(dynamic filters) onFilterApplied});

  @override
  _FilteringState createState() => _FilteringState();
}

class _FilteringState extends State<Filtering> {
  final List<String> sortOptions = [
    'Relevance',
    'Popularity',
    'Price -- Low to High',
    'Price -- High to Low',
    'Newest First',
  ];

  String selectedSortOption = 'Relevance';

  final Map<String, bool> priceFilters = {
    'Rs. 299 and below': false,
    'Rs. 300 - Rs. 499': false,
    'Rs. 500 - Rs. 699': false,
    'Rs. 700 - Rs. 999': false,
    'Rs. 1000 - Rs. 1499': false,
    'Rs. 1500 and above': false,
  };

  final Map<String, bool> categoryFilters = {
    'Maxi Dress': false,
    'Midi Dress': false,
    'Mini Dress': false,
    'Shift Dress': false,
    'Wrap Dress': false,
    'Bodycon Dress': false,
  };

  final Map<String, bool> materialFilters = {
    'Cotton': false,
    'Silk': false,
    'Wool': false,
    'Linen': false,
    'Polyester': false,
  };

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: sortOptions.map((String option) {
            return ListTile(
              title: Text(option),
              trailing: selectedSortOption == option
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                setState(() {
                  selectedSortOption = option;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _navigateToFilterScreen() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => FilterScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1.0, 0.0);
          const end = Offset(0.0, 0.0);
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  void _showCategoriesFilters() {
    _showFilters('Categories', categoryFilters);
  }

  void _showPriceFilters() {
    _showFilters('Price', priceFilters);
  }

  void _showMaterialFilters() {
    _showFilters('Materials', materialFilters);
  }

  void _showFilters(String title, Map<String, bool> filters) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      children: filters.keys.map((String key) {
                        return CheckboxListTile(
                          title: Text(key),
                          value: filters[key],
                          onChanged: (bool? value) {
                            setState(() {
                              filters[key] = value!;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            filters.updateAll((key, value) => false);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                        child: Text('Clear'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Apply filters logic here
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: Text('Apply'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTopBarButton(
                      'Sort By', Icons.arrow_drop_down, _showSortOptions),
                  _buildTopBarButton(
                      'Filter', Icons.filter_list, _navigateToFilterScreen),
                  _buildTopBarButton(
                      'Categories', Icons.category, _showCategoriesFilters),
                  _buildTopBarButton(
                      'Price', Icons.price_change, _showPriceFilters),
                  _buildTopBarButton(
                      'Type', Icons.filter_list, _showMaterialFilters),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBarButton(
      String title, IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: Text(title),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          side: BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
