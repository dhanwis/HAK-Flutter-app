import 'package:dil_hack_e_commerce/api/search_api.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/productBySearch.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

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
                    style: GoogleFonts.aBeeZee(color: Colors.black),
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
            onTap: () {},
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
        // Skeleton Loader when data is being fetched
        return ListView.builder(
          itemCount: 6, // Show 6 skeleton items
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
              child: SkeletonLoader(
                builder: Container(
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey[300],
                    ),
                    title: Container(
                      width: double.infinity,
                      height: 20,
                      color: Colors.grey[300],
                    ),
                    subtitle: Container(
                      width: double.infinity,
                      height: 15,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
                items: 1,
                period: Duration(seconds: 2),
                highlightColor: Colors.grey[200]!,
                baseColor: Colors.grey[300]!,
              ),
            );
          },
        );
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(child: Text('No results found'));
      } else {
        List<Product> products = snapshot.data!;

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];

            final firstVariation =
                product.variations.isNotEmpty ? product.variations.first : null;
            final imageUrl = firstVariation?.images.isNotEmpty == true
                ? firstVariation!.images.first
                : '';

            return ListTile(
              leading: imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.image, size: 50);
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    )
                  : Icon(Icons.search, size: 50),
              title: Text(
                product.productName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                product.productDescription,
                style: GoogleFonts.aBeeZee(color: Colors.grey),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.arrow_outward_sharp,
                  color: Colors.grey,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductGridPage(
                          products: products, productName: product.productName),
                    ),
                  );
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductGridPage(
                        products: products, productName: product.productName),
                  ),
                );
              },
            );
          },
        );
      }
    },
  );
}
