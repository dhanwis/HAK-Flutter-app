import 'package:dil_hack_e_commerce/api/order_api.dart';
import 'package:dil_hack_e_commerce/constants/decodeJwt.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Orders/order_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Orders/order_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Orders/order_state.dart';
import 'package:dil_hack_e_commerce/features/auth/model/order.dart';
import 'package:dil_hack_e_commerce/features/pages/All_orders/Order_detail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

// class MyOrdersPage extends StatefulWidget {
//   @override
//   _OrderPageState createState() => _OrderPageState();
// }

// class _OrderPageState extends State<MyOrdersPage> {
//   String? userId; // Hold the user ID after decoding the token.

//   @override
//   void initState() {
//     super.initState();
//     _initializeUser();
//   }

//   // Decoding the JWT to get the user ID.
//   Future<void> _initializeUser() async {
//     try {
//       Map<String, dynamic> decodedToken = await decodeJwt();
//       setState(() {
//         userId = decodedToken['userId']; // Store the userId in state
//       });
//     } catch (e) {
//       print('Error decoding JWT: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Orders'),
//       ),
//       body: userId == null
//           ? Center(
//               child:
//                   CircularProgressIndicator()) // Show a loading indicator while decoding the JWT
//           : BlocProvider(
//               create: (context) => OrderBloc(orderRepository: OrderRepository())
//                 ..add(
//                     FetchOrders(userId!)), // Use the userId here once it's set.
//               child: OrderList(),
//             ),
//     );
//   }
// }

// class OrderList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<OrderBloc, OrderState>(
//       builder: (context, state) {
//         if (state is OrderLoading) {
//           return Center(child: CircularProgressIndicator());
//         } else if (state is OrdersLoaded) {
//           return ListView.builder(
//             itemCount: state.orders.length,
//             itemBuilder: (context, index) {
//               final order = state.orders[index];
//               return ListTile(
//                 title: Text('Order #${order.id}'),
//               );
//             },
//           );
//         } else if (state is OrderError) {
//           return Center(child: Text(state.message));
//         }
//         return Center(child: Text('No Orders Found'));
//       },
//     );
//   }
// }

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  double _currentRating = 3.0;
  String userId = '';

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    try {
      Map<String, dynamic> decodedToken = await decodeJwt();
      setState(() {
        userId = decodedToken['userId']; // Ensure userId is set properly
      });
    } catch (e) {
      print('Error decoding JWT: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (userId.isEmpty) {
      // Wait for the userId to be set before rendering the Bloc
      return Scaffold(
        appBar: AppBar(
          title: Text('My Orders'),
        ),
        body: Center(child: CircularProgressIndicator()), // Show loading
      );
    }

    return BlocProvider(
      create: (context) => OrderBloc(orderRepository: OrderRepository())
        ..add(FetchOrders(userId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Orders'),
        ),
        body: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is OrdersLoaded) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatusTabs(), // Status tabs
                    SizedBox(height: 18),
                    Divider(),
                    // OrderDetails(
                    //   customerName: 'Manjima C',
                    //   orderId: '54688978954',
                    //   supplier: 'Kidbea',
                    // ),
                    Divider(),
                    ListView.builder(
                      shrinkWrap:
                          true, // Ensures the list can scroll within the SingleChildScrollView
                      physics:
                          NeverScrollableScrollPhysics(), // Prevents ListView from scrolling
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        final order = state.orders[index];
                        return Column(
                          children: [
                            _buildSearchBar(screenWidth, order), // Search bar
                            SizedBox(height: 10),
                            _buildOrderCard(screenWidth,
                                order), // Order card for each order
                            Divider(),
                            _buildRatingDropdown(), // Rating dropdown for each order
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
            return Center(child: Text('No Orders Found'));
          },
        ),
      ),
    );
  }

  Widget _buildSearchBar(double screenWidth, Order order) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.01, vertical: screenWidth * 0.001),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 18),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText:
                    'Search order #${order.id}', // You can use the order details here
                hintStyle: TextStyle(fontSize: 10),
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
    final Product firstProduct = order.products[0];

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            order.id,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
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
                            'http://192.168.1.12:8000/ProductImg/${firstProduct.productId}/${firstProduct.variant.images[0]}')
                        : const AssetImage('assets/placeholder.png')
                            as ImageProvider, // Placeholder image
                    fit: BoxFit.cover,
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
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Delivery Status (using quantity here as a status example)
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: firstProduct.quantity > 0
                              ? Colors.green
                              : Colors.red,
                          size: 10,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Quantity: ${firstProduct.quantity}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),

                    // Product Price
                    const SizedBox(height: 8),
                    Text(
                      '\$${firstProduct.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Navigate to order details
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
          SizedBox(height: screenWidth * 0.05),
        ],
      ),
    );
  }

  Widget _buildRatingDropdown() {
    return ExpansionTile(
      title: Text(
        'How was the product?',
        style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      children: [
        const SizedBox(height: 10),
        Column(
          children: [
            RatingBar.builder(
              initialRating: _currentRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 4,
              itemPadding: const EdgeInsets.symmetric(horizontal: 19.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _currentRating = rating;
                });
              },
            ),
            const SizedBox(height: 10),
            _buildRatingLabels(),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildRatingLabels() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildRatingLabel('Very Bad', 1),
        _buildRatingLabel('Bad', 2),
        _buildRatingLabel('Good', 4),
        _buildRatingLabel('Very Good', 5),
      ],
    );
  }

  Widget _buildRatingLabel(String label, int rating) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: _currentRating >= rating ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }
}

class OrderDetails extends StatelessWidget {
  final String orderId;
  final String customerName;
  // final String supplier;

  OrderDetails({
    required this.orderId,
    required this.customerName,
    // required this.supplier,
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
                  style: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(
                        text: orderId,
                        style: GoogleFonts.aBeeZee(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )),
                  ],
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Sold to: ',
                style: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 14),
                children: [
                  TextSpan(
                      text: customerName,
                      style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
