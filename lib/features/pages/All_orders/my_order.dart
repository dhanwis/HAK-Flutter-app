import 'package:dil_hack_e_commerce/api/order_api.dart';
import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/constants/decodeJwt.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Orders/order_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Orders/order_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Orders/order_state.dart';
import 'package:dil_hack_e_commerce/features/auth/model/order.dart';
import 'package:dil_hack_e_commerce/features/pages/All_orders/Order_detail.dart';
import 'package:dil_hack_e_commerce/features/pages/All_orders/Review_page.dart';
import 'package:dil_hack_e_commerce/features/pages/WishList/wish_list.dart';
import 'package:dil_hack_e_commerce/features/pages/cart/cart_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  double _currentRating = 3.0;
  String userId = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _initializeUser();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  List<Order> _filterOrders(List<Order> orders) {
    if (_searchQuery.isEmpty) {
      return orders;
    } else {
      return orders.where((order) {
        bool matchesOrderId =
            order.id.toLowerCase().contains(_searchQuery.toLowerCase());

        bool matchesProductName = order.products.any((product) => product
            .productName
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()));

        return matchesOrderId || matchesProductName;
      }).toList();
    }
  }

  Future<void> _initializeUser() async {
    try {
      Map<String, dynamic> decodedToken = await decodeJwt();
      setState(() {
        userId = decodedToken['userId'];
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (userId.isEmpty) {
      return Scaffold(
        body: Center(
          child: SpinKitFadingCircle(
            color: Color(0xFFFAAAB1),
            size: 50.0,
          ),
        ),
      );
    }

    return BlocProvider(
      create: (context) => OrderBloc(orderRepository: OrderRepository())
        ..add(FetchOrders(userId)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'My Orders',
            style:
                GoogleFonts.aBeeZee(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.favorite, color: Colors.black),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WishlistPage()));
              },
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.black),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartPage()));
              },
            ),
          ],
        ),
        body: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderLoading) {
              return Center(
                child: SpinKitFadingCircle(
                  color: Color(0xFFFAAAB1),
                  size: 50.0,
                ),
              );
            } else if (state is OrdersLoaded) {
              final filteredOrders = _filterOrders(state.orders);

              if (filteredOrders.isEmpty) {
                // Show a message if no search results found
                return Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildSearchBar(
                          screenWidth,
                        ),
                      ),
                      Center(
                        child: Text(
                          "Oops, your search not found!",
                          style: GoogleFonts.aBeeZee(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildSearchBar(
                        screenWidth,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: filteredOrders
                          .length, // Make sure this matches the actual length of the filtered list
                      itemBuilder: (context, index) {
                        final order = filteredOrders[index];
                        return Column(
                          children: [
                            Divider(),
                            OrderDetails(orderId: order.id),
                            Divider(),
                            _buildOrderCard(
                              MediaQuery.of(context).size.width,
                              order,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            } else if (state is OrderError) {
              return Center(child: Text(state.message));
            }
            return Center(
              child: SpinKitFadingCircle(
                color: Color(0xFFFAAAB1),
                size: 50.0,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchBar(double screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.01, vertical: screenWidth * 0.001),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.search, color: Colors.grey),
          ),
          SizedBox(width: 15),
          Expanded(
            child: TextField(
              controller: _searchController,
              cursorColor: Colors.black54,
              cursorHeight: 20,
              decoration: InputDecoration(
                hintText: 'Search orders...',
                hintStyle:
                    GoogleFonts.aBeeZee(fontSize: 14, color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildStatusButton('Ordered'),
        SizedBox(width: 10),
        _buildStatusButton('Shipped'),
        SizedBox(width: 10),
        _buildStatusButton('Delivered'),
        SizedBox(width: 10),
        _buildStatusButton('Canceled'),
      ],
    );
  }

  Widget _buildStatusButton(String title) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {},
        child: Text(
          title,
          style: TextStyle(
              fontSize: 5, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildOrderCard(double screenWidth, Order order) {
    final ProductData firstProduct = order.products[0];

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Container(
                width: screenWidth * 0.15,
                height: screenWidth * 0.19,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: firstProduct.variant.images.isNotEmpty
                        ? NetworkImage(
                            '${AppConstants.BASE_URL}/ProductImg/${firstProduct.productId}/${firstProduct.variant.images[0]}')
                        : const AssetImage('assets/placeholder.png')
                            as ImageProvider, // Placeholder image
                    fit: BoxFit.cover,
                    // Uri.parse('$baseUrl/customerApp/cart/delete/$userId/$productId'),
                  ),
                ),
              ),
              const SizedBox(width: 18),

              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    Text(
                      firstProduct.productName,
                      style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: firstProduct.quantity > 0
                              ? Colors.green
                              : Colors.red,
                          size: 10,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Quantity: ${firstProduct.quantity}',
                          style: GoogleFonts.aBeeZee(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),

                    // Product Price
                    const SizedBox(height: 8),
                    Text(
                      '₹${firstProduct.price.toStringAsFixed(2)}',
                      style: GoogleFonts.aBeeZee(
                        color: Colors.grey[800],
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),
                    // Write My Review Section
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WriteReviewPage(product: firstProduct),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.edit,
                              color: const Color.fromARGB(255, 114, 4, 4),
                              size: 16),
                          const SizedBox(width: 8),
                          Text(
                            'Write My Review',
                            style: GoogleFonts.aBeeZee(
                              color: const Color.fromARGB(255, 114, 4, 4),
                              fontSize: 13,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: screenWidth * 0.05,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailPage(order: order),
                    ),
                  );
                },
              ),
            ],
          ),
          // SizedBox(height: screenWidth * 0.02),
        ],
      ),
    );
  }

  // Widget _buildRatingDropdown() {
  //   return ExpansionTile(
  //     title: Text(
  //       'How was the product?',
  //       style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold, fontSize: 14),
  //     ),
  //     children: [
  //       // const SizedBox(height: 10),
  //       Column(
  //         children: [
  //           RatingBar.builder(
  //             initialRating: _currentRating,
  //             minRating: 1,
  //             direction: Axis.horizontal,
  //             allowHalfRating: true,
  //             itemCount: 4,
  //             itemPadding: const EdgeInsets.symmetric(horizontal: 19.0),
  //             itemBuilder: (context, _) => const Icon(
  //               Icons.star,
  //               color: Colors.amber,
  //             ),
  //             onRatingUpdate: (rating) {
  //               setState(() {
  //                 _currentRating = rating;
  //               });
  //             },
  //           ),
  //           // const SizedBox(height: 10),
  //           // _buildRatingLabels(),
  //         ],
  //       ),
  //       const SizedBox(height: 10),
  //     ],
  //   );
  // }

  // Widget _buildRatingLabels() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     children: [
  //       _buildRatingLabel('Very Bad', 1),
  //       _buildRatingLabel('Bad', 2),
  //       _buildRatingLabel('Good', 4),
  //       _buildRatingLabel('Very Good', 5),
  //     ],
  //   );
  // }

//   Widget _buildRatingLabel(String label, int rating) {
//     return Column(
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             color: _currentRating >= rating ? Colors.black : Colors.grey,
//           ),
//         ),
//       ],
//     );
//   }
// }
}

class OrderDetails extends StatelessWidget {
  final String orderId;

  OrderDetails({
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: RichText(
                text: TextSpan(
                  text: 'Order ID: ',
                  style: GoogleFonts.aBeeZee(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: orderId,
                        style: GoogleFonts.aBeeZee(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
