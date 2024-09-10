import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Payment',
          style: GoogleFonts.aBeeZee(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: PaymentOptions(),
    );
  }
}

class PaymentOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStepCircle(1, "Address", false),
            _buildLine(),
            _buildStepCircle(2, "Order summary", false),
            _buildLine(),
            _buildStepCircle(3, "Payment", true),
          ],
        ),
        SizedBox(height: 40),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 228, 228, 232),
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: GoogleFonts.aBeeZee(
                    fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                '₹ 499',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        ExpansionTile(
          leading: Icon(
            Icons.credit_card,
            size: 20,
            color: Colors.black,
          ),
          title: Text(
            'Credit / Debit / ATM Card',
            style: GoogleFonts.aBeeZee(fontSize: 15),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const TextField(
                    decoration: InputDecoration(
                        labelText: 'Card Number',
                        labelStyle: TextStyle(fontSize: 14)),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                        labelText: 'Expiry Date',
                        labelStyle: TextStyle(fontSize: 14)),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                        labelText: 'CVV', labelStyle: TextStyle(fontSize: 14)),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                        labelText: 'Name on Card',
                        labelStyle: TextStyle(fontSize: 14)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Pay now",
                        style: GoogleFonts.aBeeZee(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFAAAB1),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        const Divider(),
        const SizedBox(
          height: 10,
        ),
        ExpansionTile(
          leading: Icon(
            Icons.account_balance,
            color: Colors.black,
          ),
          title: Text(
            'Net Banking',
            style: GoogleFonts.aBeeZee(),
          ),
          children: [
            ListTile(
              title: Text(
                'Select your bank',
                style: GoogleFonts.aBeeZee(fontSize: 14),
              ),
              trailing: DropdownButton<String>(
                items:
                    <String>['Bank A', 'Bank B', 'Bank C'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Pay now",
                  style: GoogleFonts.aBeeZee(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFAAAB1),
                ),
              ),
            )
          ],
        ),
        Divider(),
        SizedBox(
          height: 10,
        ),
        ExpansionTile(
          leading: Icon(
            Icons.payment,
            color: Colors.black,
          ),
          title: Text(
            'UPI',
            style: GoogleFonts.aBeeZee(fontSize: 15),
          ),
          children: [
            ListTile(
              title: TextField(
                decoration: InputDecoration(
                    labelText: 'Enter UPI ID',
                    hintStyle: GoogleFonts.aBeeZee(fontSize: 12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Pay now",
                  style: GoogleFonts.aBeeZee(
                      color: Colors.black, fontWeight: FontWeight.normal),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFAAAB1),
                ),
              ),
            ),
          ],
        ),
        Divider(),
        SizedBox(
          height: 10,
        ),
        ExpansionTile(
          leading: Icon(
            Icons.local_shipping,
            color: Colors.black,
          ),
          title: Text(
            'Cash On Delivery',
            style: GoogleFonts.aBeeZee(fontSize: 15),
          ),
          children: [
            ListTile(
              title: Text(
                'You can pay via cash when the product is delivered to your address.',
                style: GoogleFonts.aBeeZee(fontSize: 14),
              ),
            ),
          ],
        ),
        Divider(),
        SizedBox(
          height: 18,
        ),
      ],
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
            style: GoogleFonts.aBeeZee(
              color: isActive ? Color.fromARGB(255, 3, 3, 3) : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.aBeeZee(),
        ),
      ],
    );
  }

  Widget _buildLine() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Container(
        width: 40,
        height: 1,
        color: Colors.grey,
      ),
    );
  }
}
