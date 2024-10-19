import 'package:dil_hack_e_commerce/api/userProfile_api.dart';
import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/AddToCart/cart_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/AddToCart/cart_state.dart';
import 'package:dil_hack_e_commerce/features/auth/model/address.dart';
import 'package:dil_hack_e_commerce/features/auth/model/userProfile.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/otp_page/tokenStorage.dart';
import 'package:dil_hack_e_commerce/features/pages/WishList/wish_list.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/order_screen.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/addressPage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lottie/lottie.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int quantity = 1;
  void updateQuantity(int newQuantity) {
    setState(() {
      quantity = newQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          ' My Cart',
          style: GoogleFonts.aBeeZee(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.black),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WishlistPage()));
            },
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
                child: SpinKitFadingCircle(
              color: Color(0xFFFAAAB1),
              size: 50.0,
            ));
          } else if (state is CartLoaded) {
            // if (state.cartItems.isEmpty) {
            //   return Center(child: Text("No items in your wishlist"));
            // }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final product = state.cartItems[index];
                      return _cartUI(context, product);
                    },
                  ),
                ),
              ],
            );
          } else if (state is CartError) {
            return _emptyUI();
          }
          return const Center(child: Text("Something went wrong"));
        },
      ),
    );
  }
}

Widget _cartUI(BuildContext context, Map<String, dynamic> cartItem) {
  final ApiService apiService = ApiService();

  Future<String> getUserId() async {
    try {
      final TokenStorage tokenStorage = TokenStorage();
      final accessToken = await tokenStorage.getAccessToken();

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception("Access token not found");
      }

      Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
      String userId = decodedToken['userId'];
      return userId;
    } catch (e) {
      print('Failed to decode JWT: $e');
      return "";
    }
  }

  final product = cartItem['product'];
  final firstVariation =
      product['variations'].isNotEmpty ? product['variations'][0] : null;
  final firstImage =
      firstVariation != null && firstVariation['images'].isNotEmpty
          ? firstVariation['images'][0]
          : null;
  final sku = firstVariation != null && firstVariation['skus'].isNotEmpty
      ? firstVariation['skus'][0]
      : null;

  final productId = product['product_id'] ?? 'Unknown Product';
  final productName = product['product_name'] ?? 'Unknown Product';
  final productDesc = product['product_description'] ?? 'Unknown Product';
  final size = sku?['size'] ?? 'Unknown Size';
  final actualPrice = sku?['actualPrice']?.toString() ?? 'N/A';
  final discountedPrice = sku?['discountedPrice']?.toString() ?? 'N/A';
  final rating = product['rating'] ?? 0;

  int quantity = cartItem['quantity'] ?? 1;

  void updateQuantity(int newQuantity) {
    if (newQuantity >= 1) {
      cartItem['quantity'] = newQuantity;
    }
  }

  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: firstImage != null
                      ? Image.network(
                          '${AppConstants.BASE_URL}/ProductImg/$productId/$firstImage',
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.image,
                          color: Colors.grey.shade400,
                          size: 60,
                        ),
                ),
              ),

              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            productDesc,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.aBeeZee(
                                color: Colors.grey, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '₹$actualPrice',
                          style: GoogleFonts.aBeeZee(
                            color: Colors.grey,
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '₹$discountedPrice',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Size : $size',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Delivery by Sept 18',
                          style: GoogleFonts.aBeeZee(
                              color: Colors.grey, fontSize: 11),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Free Delivery',
                          style: GoogleFonts.aBeeZee(
                              color: Colors.green, fontSize: 11),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Qty:',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (quantity > 1) {
                              updateQuantity(quantity - 1);
                            }
                          },
                          icon:
                              Icon(Icons.remove, size: 17, color: Colors.black),
                        ),
                        Text(
                          '$quantity',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            updateQuantity(quantity + 1);
                          },
                          icon: Icon(Icons.add, size: 17, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.black,
                      size: 18,
                    ),
                    SizedBox(width: 3),
                    Text('Remove',
                        style: GoogleFonts.aBeeZee(
                          color: Colors.black,
                        )),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
              ),
              Expanded(
                  child: TextButton(
                onPressed: () async {
                  try {
                    String userId = await getUserId();

                    if (userId.isEmpty) {
                      throw Exception("User ID not found.");
                    }

                    CustomerProfile loggedInUser =
                        await apiService.getProfileData(userId);

                    List<Address> addresses = loggedInUser.addresses!
                        .map<Address>((address) => Address.fromJson(address))
                        .toList();

                    if (addresses.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderScreen(
                            address: addresses.first,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddressFormPage(),
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to retrieve user data: $e'),
                      ),
                    );
                  }
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.black,
                      size: 18,
                    ),
                    SizedBox(width: 3),
                    Text('Buy now',
                        style: GoogleFonts.aBeeZee(color: Colors.black)),
                  ],
                ),
              )),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _cartActionButton({
  required IconData icon,
  required String label,
  required Color color,
  required VoidCallback onPressed,
}) {
  return Expanded(
    child: TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: color, size: 20),
      label: Text(
        label,
        style: GoogleFonts.aBeeZee(
          color: color,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

Widget _emptyUI() {
  return Scaffold(
    body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 180),
          child: Lottie.asset(
            'assets/images/Animation - 1717999632927 (1).json',
            height: 200,
            width: 200,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            "Your Cart Is Empty !",
            style: GoogleFonts.aBeeZee(
                fontWeight: FontWeight.w200,
                color: Colors.grey.shade500,
                fontSize: 15),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}
