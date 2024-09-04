// import 'package:flutter/material.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/filter_screen.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
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
      ),
    );
  }

  Widget _buildFilterChip(
      int index, BuildContext context, VoidCallback onSelected) {
    final bool isSelected;

    switch (index) {
      case 2:
        isSelected = _hasSelectedAnyFilters(categoryFilters);
        break;
      case 3:
        isSelected = _hasSelectedAnyFilters(materialFilters);
        break;
      case 4:
        isSelected = _hasSelectedAnyFilters(colorFilters);
        break;
      default:
        isSelected = _selectedIndices.contains(index);
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(
          _getChipLabel(index),
          style: GoogleFonts.aBeeZee(fontWeight: FontWeight.w100),
        ),
        selected: isSelected,
        selectedColor: Color(0xFFFAAAB1),
        backgroundColor: Colors.white,
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
          builder: (BuildContext context, StateSetter setModalState) {
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
                        onPressed: () {
                          setState(
                              () {}); // Ensure the filter section UI updates
                          Navigator.pop(context);
                        },
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
                            setModalState(() {
                              filters[key] = value!;
                            });
                            setState(() {}); // Update the UI immediately
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
                          setModalState(() {
                            filters.updateAll((key, value) => false);
                          });
                          setState(
                              () {}); // Reflect the cleared filters in the UI
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
                          setState(
                              () {}); // Update the UI after applying filters
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
