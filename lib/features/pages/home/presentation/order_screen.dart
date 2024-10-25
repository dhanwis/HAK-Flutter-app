import 'dart:convert';
import 'dart:ui';

import 'package:dil_hack_e_commerce/api/userProfile_api.dart';
import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/constants/defaultHttp.dart';
import 'package:dil_hack_e_commerce/features/auth/model/address.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:dil_hack_e_commerce/features/auth/model/userProfile.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/otp_page/tokenStorage.dart';
import 'package:dil_hack_e_commerce/features/pages/All_orders/my_order.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/PaymentFunction.dart';

import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/addressPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

class OrderScreen extends StatefulWidget {
  final CustomerProfile profile;
  final Address address;
  final Product product; // Add the product field;
  final String variantId;
  final String skuId;

  OrderScreen({
    required this.address,
    required this.product,
    required this.profile, // Pass product
    required this.variantId,
    required this.skuId,
  });

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isLoading = false; // Loading state

  String? _tempAddress;
  final client = AuthHttpClient(http.Client());

  late String _selectedAddress;

  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();

    _selectedAddress = '''
${widget.address.name}
${widget.address.street}
${widget.address.city}
${widget.address.pinCode}
${widget.address.phone}''';
  }

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

  @override
  Widget build(BuildContext context) {
    final double actualPrice = widget.product.variations.first.skus.isNotEmpty
        ? widget.product.variations.first.skus.first.actualPrice
        : 0;
    final double discountedPrice =
        widget.product.variations.first.skus.isNotEmpty
            ? widget.product.variations.first.skus.first.discountedPrice
            : 0;

    final double totalAmount = actualPrice - discountedPrice;
    final num discount = widget.product.variations.first.skus.isEmpty
        ? widget.product.variations.first.skus.first.discount
        : 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Order Summary',
          style: GoogleFonts.aBeeZee(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStepCircle(
                          1,
                          "Address",
                          false,
                        ),
                        _buildStepCircle(2, "Order summary", true),
                        _buildStepCircle(3, "Payment", false),
                      ],
                    ),
                    SizedBox(height: 16),
                    _buildAddressSection(context),
                    SizedBox(height: 16),
                    _buildProductDetails(),
                    SizedBox(height: 16),
                    _buildPriceDetails(
                      price: actualPrice,
                      discount: discount,
                      discountedPrice: discountedPrice,
                      totalAmount: totalAmount,
                    )
                  ],
                ),
              ),
            ),
          ),
          _buildBottomBar(
            totalAmount: totalAmount,
          ),
        ],
      ),
    );
  }

  Widget _buildStepCircle(int stepNumber, String label, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: isActive ? Color(0xFFFAAAB1) : Colors.grey[300],
          child: Text(
            stepNumber.toString(),
            style: TextStyle(
              color: isActive ? Color.fromARGB(255, 45, 59, 3) : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }

  Widget _buildAddressSection(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(color: Color.fromARGB(255, 199, 199, 199)),
              bottom: BorderSide(color: Color.fromARGB(255, 199, 199, 199)))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Deliver to :",
                  style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),
                ),
                OutlinedButton(
                  onPressed: () {
                    _showAddressBottomSheet(context);
                  },
                  child: Text(
                    "Change",
                    style: GoogleFonts.aBeeZee(color: Colors.black),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    side: BorderSide(color: Colors.grey),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                )
              ],
            ),
            Text(
              _selectedAddress,
              style: GoogleFonts.aBeeZee(height: 1.9),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddressBottomSheet(BuildContext context) async {
    try {
      String userId = await getUserId();

      CustomerProfile loggedInUser = await apiService.getProfileData(userId);

      List<Address> addresses = loggedInUser.addresses!
          .map<Address>((address) => Address.fromJson(address))
          .toList();

      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return Container(
                padding: EdgeInsets.all(16),
                height: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choose a delivery address",
                      style: GoogleFonts.aBeeZee(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: addresses.length,
                        itemBuilder: (context, index) {
                          final address = addresses[index];
                          return RadioListTile<String>(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  address.name,
                                  style: GoogleFonts.aBeeZee(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  address.phone,
                                  style: GoogleFonts.aBeeZee(fontSize: 14),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "${address.pinCode}, ${address.street}, ${address.city}",
                                  style: GoogleFonts.aBeeZee(fontSize: 14),
                                ),
                              ],
                            ),
                            value:
                                "${address.name}\n${address.phone}\n${address.pinCode}\n${address.street}\n${address.city}",
                            groupValue: _tempAddress ?? _selectedAddress,
                            onChanged: (String? value) {
                              setModalState(() {
                                _tempAddress = value!;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedAddress =
                                  _tempAddress ?? _selectedAddress;
                            });
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Confirm",
                            style: GoogleFonts.aBeeZee(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFAAAB1),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddressFormPage(
                                  product: widget.product,
                                  variantId: widget.variantId,
                                  skuId: widget.skuId,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Add New Address!?",
                            style: GoogleFonts.aBeeZee(color: Colors.green),
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
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to retrieve addresses: $e'),
          backgroundColor: Color(0xFFFAAAB1),
        ),
      );
    }
  }

  Widget _buildProductDetails() {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.product.variations.first.images
                  .first, // Use the product image
              width: 80,
              height: 118,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.productName, // Use the product name
                    style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '₹ ${widget.product.variations.first.skus.first.actualPrice}', // Use the price
                    style: GoogleFonts.aBeeZee(fontSize: 13),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'Qty : 1', // Adjust quantity based on your logic
                        style: GoogleFonts.aBeeZee(fontSize: 13),
                      ),
                      SizedBox(width: 16),
                      Text(
                        'Size : ${widget.product.variations.first.skus.first.size}', // Use the size
                        style: GoogleFonts.aBeeZee(fontSize: 13),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Delivery by Sep 30, Fri', // Add dynamic delivery date if needed
                    style: GoogleFonts.aBeeZee(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceDetails({
    required double price,
    required num discount,
    required double totalAmount,
    String deliveryCharges = 'Free delivery',
    required double discountedPrice,
  }) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(color: Color.fromARGB(255, 199, 199, 199)),
              bottom: BorderSide(color: Color.fromARGB(255, 199, 199, 199)))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPriceRow('Price ', '₹ ${price.toStringAsFixed(2)}'),
            _buildPriceRow('Discount', '₹ $discount', isDiscount: true),
            _buildPriceRow('Delivery Charges', deliveryCharges,
                isDiscount: true),
            Divider(),
            _buildPriceRow(
                'Total Amount', '₹ ${totalAmount.toStringAsFixed(2)}',
                isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value,
      {bool isDiscount = false, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.aBeeZee(
              color: isTotal ? Colors.black : Colors.grey[700],
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.aBeeZee(
              color: isDiscount
                  ? const Color.fromARGB(255, 20, 88, 234)
                  : (isTotal ? Colors.black : Colors.grey[700]),
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar({
    required double totalAmount,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '₹ ${totalAmount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              var response = await client.post(
                Uri.parse(
                    '${AppConstants.BASE_URL}/customerApp/payment/create'),
                body: jsonEncode({'amount': totalAmount}),
                headers: {'Content-Type': 'application/json'},
              );

              var orderData = jsonDecode(response.body);
              var options = {
                'key': 'rzp_test_RPif3FxApMvNtv',
                'amount': (totalAmount * 100).toInt(),
                'name': 'Dilhak',
                'description': 'Order Payment',
                'order_id': orderData['id'],
                'prefill': {
                  'contact': widget.profile.phoneNumber,
                  'email': widget.profile.email,
                },
                'theme': {'color': '#F37254'},
              };

              Razorpay razorpay = Razorpay();

              // Set up the event listeners
              razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                  (PaymentSuccessResponse response) async {
                setState(() => isLoading = true); // Show loading indicator

                String userId = await getUserId();
                Map<String, String> deliveryAddress = {
                  'username': widget.address.name,
                  'city': widget.address.city,
                  'pinCode': widget.address.pinCode,
                  'street': widget.address.street,
                  'state': "Chennai",
                  'phone': widget.address.phone,
                };

                Map<String, dynamic> verificationData = {
                  'username': widget.profile.username,
                  'email': widget.profile.email,
                  'products': [
                    {
                      'product': widget.product.id,
                      'variantId': widget.variantId,
                      'skuId': widget.skuId,
                      'quantity': 1,
                      'price': totalAmount,
                    }
                  ],
                  'totalAmount': totalAmount,
                  'paymentInfo': {
                    'razorpay_order_id': orderData['id'],
                    'razorpay_payment_id': response.paymentId,
                    'razorpay_signature': response.signature,
                    'method': '',
                    'transactionId': '123',
                    'status': 'pending',
                  },
                  'deliveryAddress': deliveryAddress,
                  'shippingMethod': 'Standard Delivery',
                  'shippingCost': 0,
                };

                // Call your server to verify the payment
                var verifyResponse = await client.post(
                  Uri.parse(
                      '${AppConstants.BASE_URL}/customerApp/order/place/$userId'),
                  body: jsonEncode(verificationData),
                  headers: {'Content-Type': 'application/json'},
                );

                if (verifyResponse.statusCode == 201) {
                  print('Order placed successfully');
                  // Navigate to Orders page after placing order
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyOrdersPage(),
                    ),
                  );
                } else {
                  print('Failed to place the order: ${verifyResponse.body}');
                }

                setState(() => isLoading = false); // Hide loading indicator
              });

              razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                  (PaymentFailureResponse response) {
                print("Payment Failed: ${response.code} - ${response.message}");
              });

              razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                  (ExternalWalletResponse response) {
                print("External Wallet: ${response.walletName}");
              });

              try {
                razorpay.open(options);
              } catch (e) {
                print("Error: $e");
              }
            },
            child: Text(
              'Continue',
              style: GoogleFonts.aBeeZee(fontSize: 15, color: Colors.black),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFAAAB1),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            ),
          ),
          // if (isLoading)
          //   const SpinKitFadingCircle(
          //     color: Color(0xFFFAAAB1),
          //     size: 50.0,
          //   ),

          if (isLoading)
            Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Colors.black
                      .withOpacity(0.3), // Semi-transparent background
                  alignment: Alignment.center,
                  child: const SpinKitFadingCircle(
                    color: Color(0xFFFAAAB1),
                    size: 50.0,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
