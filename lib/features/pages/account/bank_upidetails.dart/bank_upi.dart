import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BankUPIDetails extends StatefulWidget {
  const BankUPIDetails({super.key});

  @override
  State<BankUPIDetails> createState() => _BankUPIDetailsState();
}

class _BankUPIDetailsState extends State<BankUPIDetails> {
  void _onChangeBankDetails() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Change Bank Details',
          style: GoogleFonts.aBeeZee(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'This is where you can change your bank details',
          style: GoogleFonts.aBeeZee(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'OK',
              style: GoogleFonts.aBeeZee(color: Color(0xFFFAAAB1)),
            ),
          ),
        ],
      ),
    );
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
                GestureDetector(
                  onTap: _onChangeBankDetails,
                  child: Text(
                    "CHANGE",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
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
                    "Manjima C",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("IFSC: SBI789411999999"),
                  SizedBox(height: 4),
                  Text("68956621"),
                ],
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.payment, color: Color(0xFFFAAAB1)),
                    SizedBox(width: 8),
                    Text(
                      "UPI Details",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "ADD",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
