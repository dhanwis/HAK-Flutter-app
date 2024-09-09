import 'package:dil_hack_e_commerce/features/pages/account/bank_upidetails.dart/upi_option.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpiDetailsScreen extends StatefulWidget {
  @override
  _UpiDetailsScreenState createState() => _UpiDetailsScreenState();
}

class _UpiDetailsScreenState extends State<UpiDetailsScreen> {
  bool agreeToTerms = true;
  bool showUpiOptions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'MY UPI DETAILS',
          style: GoogleFonts.aBeeZee(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'UPI ID',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Example: abcdef@okaxis',
                hintStyle: GoogleFonts.lato(
                  color: Colors.grey,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () {
                setState(() {
                  showUpiOptions = !showUpiOptions;
                });
              },
              child: Row(
                children: [
                  Text(
                    'How to find UPI ID?',
                    style: GoogleFonts.aBeeZee(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    showUpiOptions ? Icons.expand_less : Icons.expand_more,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            if (showUpiOptions) ...[
              Text(
                'To know how to find UPI ID please select your UPI App',
                style: GoogleFonts.aBeeZee(
                  fontSize: 13,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  UpiOptionButton(
                    imagePath: 'assets/upiitems/gpay.jpg',
                    label: 'GPay',
                    onTap: () {},
                  ),
                  UpiOptionButton(
                    imagePath: 'assets/upiitems/paytm.jpg',
                    label: 'PhonePe',
                    onTap: () {},
                  ),
                  UpiOptionButton(
                    imagePath: 'assets/upiitems/phonepay.png',
                    label: 'Paytm',
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
            Row(
              children: [
                Checkbox(
                  checkColor: Colors.black,
                  activeColor: Color(0xFFFAAAB1),
                  value: agreeToTerms,
                  onChanged: (bool? value) {
                    setState(() {
                      agreeToTerms = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text:
                          'By continuing, you agree with the handling of your data as per our ',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 13,
                        color: Colors.grey[700],
                      ),
                      children: [
                        TextSpan(
                          text: 'Privacy Policy',
                          style: GoogleFonts.aBeeZee(color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 280),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFAAAB1),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Submit',
                    style:
                        GoogleFonts.aBeeZee(color: Colors.black, fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
