import 'package:dil_hack_e_commerce/features/auth/bloc/FilteredProduct/filter_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/FilteredProduct/filter_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    'Newest',
    'lowToHigh',
    'highToLow',
  ];

  Map<String, dynamic> a = {
    'priceSort': null,
    'newest': null,
    'category': null,
    'color': null,
    'size': null,
  };

  String selectedSortOption = '';

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

  final Map<String, bool> sizeFilters = {
    'S': false,
    'L': false,
    'XL': false,
    'XXL': false,
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
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
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
      case 1:
        isSelected = _hasSelectedAnyFilters(categoryFilters);
        break;
      case 2:
        isSelected = _hasSelectedAnyFilters(sizeFilters);
        break;
      case 3:
        isSelected = _hasSelectedAnyFilters(colorFilters);
        break;
      default:
        isSelected = _selectedIndices.contains(index);
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: _getChipLabel(index),
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

  Widget _getChipLabel(int index) {
    IconData iconData;
    String labelText;

    switch (index) {
      // case 0:
      //   iconData = Icons.filter_list;
      //   labelText = 'Filter';
      //   break;
      case 0:
        iconData = Icons.sort;
        labelText = 'Sort By';
        break;
      case 1:
        iconData = Icons.category;
        labelText = 'Categories';
        break;
      case 2:
        iconData = Icons.texture;
        labelText = 'Size';
        break;
      case 3:
        iconData = Icons.color_lens;
        labelText = 'Color';
        break;
      default:
        iconData = Icons.help;
        labelText = '';
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData, size: 16.0),
        SizedBox(width: 4.0),
        Text(
          labelText,
          style: GoogleFonts.aBeeZee(fontWeight: FontWeight.w100, fontSize: 10),
        ),
      ],
    );
  }

  bool _hasSelectedAnyFilters(Map<String, bool> filters) {
    return filters.values.contains(true);
  }

  void _handleChipSelection(int index) {
    switch (index) {
      case 0:
        _showSortOptions();
        break;
      case 1:
        _showFilters('Categories', categoryFilters);
        break;
      case 2:
        _showFilters('Size', sizeFilters);
        break;
      case 3:
        _showFilters('Color', colorFilters);
        break;
    }
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
                  ? const Icon(Icons.check, color: Colors.black)
                  : null,
              onTap: () {
                setState(() {
                  selectedSortOption = option;

                  Navigator.pop(context); // Pop the dialog first

                  // Ensure that the context is available here for BlocProvider
                  switch (option) {
                    case 'highToLow':
                    case 'lowToHigh':
                      a['priceSort'] = option;
                      // Access the context that has the BlocProvider
                      BlocProvider.of<FilterBloc>(context, listen: false)
                          .add(UpdatePriceSort(option));
                      break;

                    case 'newest':
                      a['newest'] = true;
                      BlocProvider.of<FilterBloc>(context, listen: false)
                          .add(const UpdateNewest(true));
                      break;

                    default:
                      break;
                  }
                });
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
                          setState(() {});
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
                            setState(() {});
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     ElevatedButton(
                  //       onPressed: () {
                  //         setModalState(() {
                  //           filters.updateAll((key, value) => false);
                  //         });
                  //         setState(() {});
                  //       },
                  //       style: ElevatedButton.styleFrom(
                  //         backgroundColor: Color.fromARGB(255, 240, 195, 199),
                  //       ),
                  //       child: Text(
                  //         'Clear',
                  //         style: GoogleFonts.aBeeZee(color: Colors.black),
                  //       ),
                  //     ),
                  //     ElevatedButton(
                  //       onPressed: () {
                  //         Navigator.pop(context);
                  //         setState(() {});
                  //         if (widget.onFilterApplied != null) {
                  //           widget.onFilterApplied!();
                  //         }
                  //       },
                  //       style: ElevatedButton.styleFrom(
                  //         backgroundColor: Color(0xFFFAAAB1),
                  //       ),
                  //       child: Text(
                  //         'Apply',
                  //         style: GoogleFonts.aBeeZee(color: Colors.black),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Clear Button
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            // Reset all filters
                            filters.updateAll((key, value) => false);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 240, 195, 199),
                        ),
                        child: Text(
                          'Clear',
                          style: GoogleFonts.aBeeZee(color: Colors.black),
                        ),
                      ),

                      // Apply Button
                      ElevatedButton(
                        onPressed: () {
                          // When Apply is clicked, close the modal and trigger the filter action
                          Navigator.pop(context);

                          // Dispatch an event to the BLoC to apply filters and make the API call
                          BlocProvider.of<FilterBloc>(context)
                              .add(ApplyFiltersEvent(filters));

                          // If there's a callback provided, call it after applying the filters
                          if (widget.onFilterApplied != null) {
                            widget.onFilterApplied!();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFAAAB1),
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
