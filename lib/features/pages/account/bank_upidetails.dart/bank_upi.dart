import 'package:dil_hack_e_commerce/api/bankdetail_api.dart';
import 'package:dil_hack_e_commerce/features/auth/model/bankDetails.dart';
import 'package:dil_hack_e_commerce/features/pages/account/bank_upidetails.dart/add_upidetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class BankDetailsPage extends StatefulWidget {
  @override
  _BankDetailsPageState createState() => _BankDetailsPageState();
}

class _BankDetailsPageState extends State<BankDetailsPage> {
  late Future<BankDetail?> _bankDetailFuture;
  final BankDetailService _bankDetailService =
      BankDetailService(); // Instantiate service

  @override
  void initState() {
    super.initState();
    // Fetch bank details on init using the service
    _bankDetailFuture = _bankDetailService.fetchBankDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'My Bank & UPI Details',
          style: GoogleFonts.aBeeZee(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bank Details Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.account_balance_wallet,
                        color: Color(0xFFFAAAB1)),
                    SizedBox(width: 8),
                    Text(
                      "Bank Details",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),

            // Using FutureBuilder to fetch and display bank details
            FutureBuilder<BankDetail?>(
              future: _bankDetailFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitFadingCircle(
                      color: Color(0xFFFAAAB1),
                      size: 50.0,
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data != null) {
                  BankDetail bankDetail = snapshot.data!;
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bankDetail.accountHolderName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text("IFSC: ${bankDetail.ifscCode}"),
                            SizedBox(height: 4),
                            Text("Acc No: ${bankDetail.accountNumber}"),
                            SizedBox(height: 4),
                            Text("Bank Name: ${bankDetail.bankName}"),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),

                      // Update Bank Details Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.payment, color: Color(0xFFFAAAB1)),
                              SizedBox(width: 8),
                              Text(
                                "Update Bank Details",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BankDetailScreen(
                                    isUpdate: true, // Pass this if updating
                                    bankDetail:
                                        bankDetail, // Pass existing details
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              "UPDATE",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  // If no bank details exist, show Add Bank Details
                  return Column(
                    children: [
                      Center(
                        child: Text('No bank details available'),
                      ),
                      SizedBox(height: 24),

                      // Add Bank Details Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.payment, color: Color(0xFFFAAAB1)),
                              SizedBox(width: 8),
                              Text(
                                "Add Bank Details",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BankDetailScreen(
                                    isUpdate:
                                        false, // For adding a new bank detail
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              "ADD",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
