import 'package:dil_hack_e_commerce/api/search_api.dart';
import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/productBySearch.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar(
      {super.key, required this.width, required this.onSearchTermChanged});

  final double width;
  final ValueChanged<String> onSearchTermChanged;

  @override
  _AppSearchBarState createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(99, 202, 201, 202),
                  ),
                  child: TextFormField(
                    style: const TextStyle(color: Palette.shadowPink),
                    cursorColor: Colors.grey,
                    onChanged: (value) {
                      widget.onSearchTermChanged(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search Products',
                      hintStyle: GoogleFonts.aBeeZee(
                          color: const Color.fromARGB(255, 182, 182, 182)),
                      prefixIcon: const Icon(
                        EvaIcons.search,
                        color: Color.fromARGB(255, 175, 174, 174),
                      ),
                      contentPadding: const EdgeInsets.only(top: 13),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Add any desired functionality here
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 235, 228, 228),
                  borderRadius: BorderRadius.circular(15)),
              width: 60,
              child: const Center(
                child: Icon(
                  EvaIcons.mic,
                  color: Color.fromARGB(255, 147, 144, 144),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget buildSearchResults(String searchTerm) {
  return FutureBuilder<List<Product>>(
    future: fetchSearchResults(searchTerm),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(child: Text('No products found'));
      } else {
        List<Product> products = snapshot.data!;
        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(products[index].productName),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductGridPage(products: products),
                  ),
                ).then((x) => {searchTerm = ''});
              },
            );
          },
        );
      }
    },
  );
}
