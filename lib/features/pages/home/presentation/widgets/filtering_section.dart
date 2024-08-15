import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/filter_screen.dart';
import 'package:flutter/material.dart';

class FilterSection extends StatefulWidget {
  final VoidCallback? onFilterApplied;

  FilterSection({this.onFilterApplied});

  @override
  _FilterSectionState createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
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

  final Map<String, bool> colorFilters = {
    'Red': false,
    'Black': false,
    'Pink': false,
  };

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
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
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
                          backgroundColor: Color.fromARGB(255, 240, 195, 199),
                        ),
                        child: const Text(
                          'Clear',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFAAAB1),
                        ),
                        child: const Text(
                          'Apply',
                          style: TextStyle(color: Colors.black),
                        ),
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          SizedBox(
            height: 60, // Adjust height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5, // Updated to 5 to include all filter options
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return _buildFilterChip(
                      'Filter',
                      context,
                      _navigateToFilterScreen,
                    );
                  case 1:
                    return _buildFilterChip(
                      'Sort By',
                      context,
                      _showSortOptions,
                    );
                  case 2:
                    return _buildFilterChip(
                      'Categories',
                      context,
                      () => _showFilters('Categories', categoryFilters),
                    );
                  case 3:
                    return _buildFilterChip(
                      'Material',
                      context,
                      () => _showFilters('Material', materialFilters),
                    );
                  case 4:
                    return _buildFilterChip(
                      'Color',
                      context,
                      () => _showFilters('Color', colorFilters),
                    );
                  default:
                    return SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
      String label, BuildContext context, VoidCallback onSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(label),
        onSelected: (bool value) {
          onSelected();
        },
      ),
    );
  }
}
