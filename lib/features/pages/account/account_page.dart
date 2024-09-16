import 'package:dil_hack_e_commerce/features/auth/presentation/login_page/login_page.dart';
import 'package:dil_hack_e_commerce/features/pages/All_orders/my_order.dart';

import 'package:dil_hack_e_commerce/features/pages/account/bank_upidetails.dart/bank_upi.dart';
import 'package:dil_hack_e_commerce/features/pages/account/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // Color(0xFFFAAAB1),
        title: Text(
          'Account',
          style: GoogleFonts.aBeeZee(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  ProfileAvatar(),
                  SizedBox(width: 30),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFFFAAAB1),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16.0),
                    ),
                    child: Text(
                      'Sign up',
                      style: GoogleFonts.aBeeZee(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            // Column(
            //   children: [
            //     Text(
            //       'View and Update Your Profile Details',
            //       style: GoogleFonts.aBeeZee(),
            //     )
            //   ],
            // ),
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
                  MaterialPageRoute(builder: (context) => BankUPIDetails()),
                );
              },
            ),
            ListTileWidget(
              icon: Icons.payment,
              iconColor: Colors.black,
              label: 'Payment & Refund',
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => MyOrdersPage()
                // ),
              },
            ),
            Divider(),
            SectionHeader(title: 'My Activity'),
            ListTileWidget(
              icon: Icons.indeterminate_check_box_sharp,
              iconColor: Colors.black,
              label: 'My Orders',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyOrdersPage()));
              },
            ),
            ListTileWidget(
              icon: Icons.favorite,
              iconColor: Colors.black,
              label: 'Wishlisted Products',
              onTap: () {},
            ),
            ListTileWidget(
              icon: Icons.share,
              iconColor: Colors.black,
              label: 'Shared Products',
              onTap: () {},
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
                      });
                }),
          ],
        ),
      ),
    );
  }
}

class ListTileWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget? trailing;
  final VoidCallback onTap;
  final Color iconColor;

  const ListTileWidget(
      {required this.icon,
      required this.label,
      this.trailing,
      required this.onTap,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(
        label,
        style: GoogleFonts.aBeeZee(),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
