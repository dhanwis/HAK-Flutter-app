import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/filtering_section.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Map<String, bool> brandFilters = {
    'Dilhak': false,
  };

  Map<String, bool> colorFilters = {
    'Red': false,
    'Blue': false,
    'Green': false,
    'Yellow': false,
  };

  Map<String, bool> sizeFilters = {
    'S': false,
    'M': false,
    'L': false,
    'XL': false,
  };

  late List<bool> _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = List<bool>.generate(
        3, (index) => false); // Adjusted to 3 for the new section
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _resetFilters();
              });
            },
            child: Text('Clear Filters',
                style: GoogleFonts.aBeeZee(color: Colors.black)),
          ),
        ],
      ),
      body: Row(children: [
        SizedBox(
          width: 240,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildFilterSection('Brand', brandFilters, 0),
                const SizedBox(height: 10),
                _buildFilterSection('Color', colorFilters, 1),
                const SizedBox(height: 10),
                _buildFilterSection(
                    'Size', sizeFilters, 2), // New Size filter section
              ],
            ),
          ),
        ),
      ]),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          _applyFilters();
        },
        child: Text(
          'Apply',
          style: GoogleFonts.aBeeZee(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildFilterSection(
      String title, Map<String, bool> filters, int index) {
    return ExpansionTile(
      title: Text(title),
      children: [
        Column(
          children: filters.keys.map((String key) {
            return CheckboxListTile(
              title: Text(key),
              value: filters[key]!,
              onChanged: (bool? value) {
                setState(() {
                  filters[key] = value!;
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  void _resetFilters() {
    setState(() {
      brandFilters.forEach((key, value) {
        brandFilters[key] = false;
      });
      colorFilters.forEach((key, value) {
        colorFilters[key] = false;
      });
      sizeFilters.forEach((key, value) {
        // Reset the size filters
        sizeFilters[key] = false;
      });
    });
  }

  void _applyFilters() {
    Navigator.pop(context);
  }
}
