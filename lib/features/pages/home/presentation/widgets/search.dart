import 'package:dil_hack_e_commerce/const/colors_class.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Searchbar/search_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Searchbar/search_state.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/productBySearch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({
    super.key,
    required this.width,
    required this.onSearchTermChanged,
  });

  final double width;
  final ValueChanged<String> onSearchTermChanged;

  @override
  _AppSearchBarState createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(99, 202, 201, 202),
      ),
      child: TextFormField(
        cursorColor: ColorsClass.grey,
        onChanged: (value) {
          widget.onSearchTermChanged(value);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          hintText: 'Search Here ..',
          hintStyle: GoogleFonts.aBeeZee(
            textStyle: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

Widget buildSearchResults() {
  return BlocBuilder<SearchBloc, SearchState>(
    builder: (context, state) {
      if (state is SearchLoading) {
        return _buildLoading();
      } else if (state is SearchSuccess) {
        if (state.products.isEmpty) {
          return Center(child: Text('No results found'));
        } else {
          return _buildProductList(state.products);
        }
      } else if (state is SearchFailure) {
        return Center(child: Text('Error: ${state.error}'));
      } else {
        return Center();
      }
    },
  );
}

Widget _buildLoading() {
  return ListView.builder(
    itemCount: 6,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
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
          period: const Duration(seconds: 2),
          highlightColor: Colors.grey[200]!,
          baseColor: Colors.grey[300]!,
        ),
      );
    },
  );
}

Widget _buildProductList(List<Product> products) {
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
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image, size: 50);
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
            : const Icon(Icons.search, size: 50),
        title: Text(
          product.productName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        subtitle: Text(
          product.productDescription,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: GoogleFonts.aBeeZee(color: Colors.grey, fontSize: 12),
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.arrow_outward_sharp,
            color: Colors.grey,
            size: 20,
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
