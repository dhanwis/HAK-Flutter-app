import 'package:dil_hack_e_commerce/Components/ListTileWidget.dart';
import 'package:dil_hack_e_commerce/Components/SectionHeader.dart';
import 'package:dil_hack_e_commerce/constants/decodeJwt.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/login_page/login_page.dart';
import 'package:dil_hack_e_commerce/features/pages/All_orders/my_order.dart';
import 'package:dil_hack_e_commerce/features/pages/WishList/wish_list.dart';

import 'package:dil_hack_e_commerce/features/pages/account/bank_upidetails.dart/bank_upi.dart';
import 'package:dil_hack_e_commerce/features/pages/account/userprofile.dart';
import 'package:dil_hack_e_commerce/features/pages/cart/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  // Assuming userId is fetched and stored in this state variable
  String? userId;

  @override
  void initState() {
    super.initState();
    // Initialize userId here by calling an API or checking local storage.
    // For demonstration, I'll set it as null.
    fetchUserData();
  }

  // Function to simulate fetching user data or check user session
  void fetchUserData() async {
    // Simulate fetching user data
    try {
      // Decode the token and get userId
      Map<String, dynamic> decodedToken = await decodeJwt();
      setState(() {
        userId = decodedToken[
            'userId']; // Assuming 'userId' is the key in your token
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Account',
          style: GoogleFonts.aBeeZee(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      body:
          // SingleChildScrollView(
          userId == null
              ? Center(
                  // Show loading spinner if userId is null (data is being fetched)
                  child: SpinKitFadingCircle(
                    color: Color(0xFFFAAAB1),
                    size: 50.0,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const SizedBox(width: 30),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (userId != null)
                                    Text(
                                      'Welcome back!',
                                      style: GoogleFonts.aBeeZee(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            userId != null
                                ? TextButton(
                                    onPressed: () {
                                      // Navigate to Profile Page if userId is available
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfilePage(userId: userId!)),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Color(0xFFFAAAB1),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 16.0),
                                    ),
                                    child: Text(
                                      'View Profile',
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.black),
                                    ),
                                  )
                                : TextButton(
                                    onPressed: () {
                                      // Navigate to Signup Page if userId is not available
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Color(0xFFFAAAB1),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 16.0),
                                    ),
                                    child: Text(
                                      'Sign Up',
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.black),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      Divider(),
                      SectionHeader(
                        title: 'My Payments',
                      ),
                      ListTileWidget(
                        icon: Icons.account_balance_wallet,
                        iconColor: Colors.black,
                        label: 'Bank & UPI Details',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BankDetailsPage()),
                          );
                        },
                      ),
                      ListTileWidget(
                        icon: Icons.payment,
                        iconColor: Colors.black,
                        label: 'Payment & Refund',
                        onTap: () {
                          // Your navigation code
                        },
                      ),
                      Divider(),
                      SectionHeader(title: 'My Activity'),
                      ListTileWidget(
                        icon: Icons.indeterminate_check_box_sharp,
                        iconColor: Colors.black,
                        label: 'My Orders',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyOrdersPage()),
                          );
                        },
                      ),
                      ListTileWidget(
                        icon: Icons.shopping_bag,
                        iconColor: Colors.black,
                        label: 'My Cart',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CartPage()),
                          );
                        },
                      ),
                      ListTileWidget(
                        icon: Icons.favorite,
                        iconColor: Colors.black,
                        label: 'Wishlisted Products',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WishlistPage()),
                          );
                        },
                      ),
                      ListTileWidget(
                        icon: Icons.logout_outlined,
                        iconColor: Colors.black,
                        label: 'Logout',
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                titlePadding: EdgeInsets.all(0),
                                contentPadding: EdgeInsets.all(16),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Are you sure you want to logout?',
                                      style: GoogleFonts.aBeeZee(),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: GoogleFonts.aBeeZee(),
                                          ),
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.black,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Logout',
                                            style: GoogleFonts.aBeeZee(
                                                color: Colors.black),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFFFAAAB1),
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
                      ),
                    ],
                  ),
                ),
    );
  }
}
