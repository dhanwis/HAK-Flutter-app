// new_arrivals_widget.dart
import 'package:dil_hack_e_commerce/features/auth/bloc/NewArrivals/new_arrivals_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/NewArrivals/new_arrivals_state.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/widgets/viewall_button.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/product_detailpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Import your New Arrivals BLoC
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NewArrivalsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewArrivalsBloc, NewArrivalsState>(
      builder: (context, state) {
        print(
            'state in new arrival $state'); // Ensure this prints when state changes
        if (state is NewArrivalsLoading) {
          // Show the skeleton loader while loading.
          return Skeletonizer(
            enabled: true,
            child: SizedBox(
              height: 330,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 150,
                    color: Colors.grey.shade200,
                  ),
                ),
              ),
            ),
          );
        } else if (state is NewArrivalsError) {
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is NewArrivalsLoaded) {
          List<Product> products = state.products;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'New Arrivals',
                      style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewAllButton(
                              products: products,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'View All',
                        style: GoogleFonts.aBeeZee(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 240,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      String imageUrl = products[index].variations[0].images[0];
                      String formattedPrice = NumberFormat('#,##0').format(
                          products[index].variations[0].skus[0].actualPrice);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(
                                  productId: products[index].id),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  products[index].productBrand,
                                  style: GoogleFonts.aBeeZee(
                                    color: Colors.grey,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 1),
                                child: Text(
                                  products[index].productName.toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                '₹ $formattedPrice',
                                style: GoogleFonts.aBeeZee(
                                  color: Colors.green,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          );
        }
        return Container(); // Return an empty container for any other state.
      },
    );
  }
}
