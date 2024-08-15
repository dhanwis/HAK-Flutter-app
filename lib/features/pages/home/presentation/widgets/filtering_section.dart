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
  final Map<String, bool> ColorFilters = {
    'Red': false,
    'Black': false,
    'Pink': false,
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
              itemCount: 10,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return _buildFilterChip(
                      'Sort By',
                      context,
                      _showSortOptions,
                    );
                  case 1:
                    return _buildFilterChip(
                      'Price',
                      context,
                      () => _showFilters('Price', priceFilters),
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
                      () => _showFilters('color', ColorFilters),
                    );
                  default:
                    return SizedBox
                        .shrink(); // Return an empty widget if index is out of bounds
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
