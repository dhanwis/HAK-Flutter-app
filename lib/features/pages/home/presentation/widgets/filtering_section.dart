import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'filter_screen.dart';

class FilterSection extends StatefulWidget {
  final VoidCallback? onFilterApplied;

  FilterSection({this.onFilterApplied});

  @override
  _FilterSectionState createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  List<int> _selectedIndices = [];
  final List<String> sortOptions = [
    'Relevance',
    'Popularity',
    'Price -- Low to High',
    'Price -- High to Low',
  ];

  String selectedSortOption = 'Relevance';

  final Map<String, bool> priceFilters = {
    'Rs. 299 and below': false,
    'Rs. 300 - Rs. 499': false,
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
  };

  final Map<String, bool> colorFilters = {
    'Red': false,
    'Black': false,
  };

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
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildFilterChip(
                  index,
                  context,
                  () => _handleChipSelection(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
      int index, BuildContext context, VoidCallback onSelected) {
    final isSelected = _selectedIndices.contains(index) ||
        (index == 2 && _hasSelectedAnyFilters(categoryFilters)) ||
        (index == 3 && _hasSelectedAnyFilters(materialFilters)) ||
        (index == 4 && _hasSelectedAnyFilters(colorFilters)) ||
        (index == 5 && _hasSelectedAnyFilters(priceFilters));

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(_getChipLabel(index)),
        selected: isSelected,
        selectedColor: Color(0xFFFAAAB1),
        backgroundColor: Colors.grey[200],
        onSelected: (bool value) {
          setState(() {
            if (value) {
              _selectedIndices.add(index);
            } else {
              _selectedIndices.remove(index);
            }
          });
          onSelected();
        },
      ),
    );
  }

  bool _hasSelectedAnyFilters(Map<String, bool> filters) {
    return filters.values.contains(true);
  }

  void _handleChipSelection(int index) {
    switch (index) {
      case 0:
        _navigateToFilterScreen();
        break;
      case 1:
        _showSortOptions();
        break;
      case 2:
        _showFilters('Categories', categoryFilters);
        break;
      case 3:
        _showFilters('Material', materialFilters);
        break;
      case 4:
        _showFilters('Color', colorFilters);
        break;
    }
  }

  String _getChipLabel(int index) {
    switch (index) {
      case 0:
        return 'Filter';
      case 1:
        return 'Sort By';
      case 2:
        return 'Categories';
      case 3:
        return 'Material';
      case 4:
        return 'Color';
      default:
        return '';
    }
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
                        style: GoogleFonts.aBeeZee(
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
                        child: Text(
                          'Clear',
                          style: GoogleFonts.aBeeZee(color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          if (widget.onFilterApplied != null) {
                            widget.onFilterApplied!();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFAAAB1),
                        ),
                        child: Text(
                          'Apply',
                          style: GoogleFonts.aBeeZee(color: Colors.black),
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
}
