import 'package:dil_hack_e_commerce/features/pages/home/Paymentpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String _selectedAddress =
      "Manjima C\nAkshya Nagar 1st Block 1st Cross,\nRamamurthy Nagar, Bangalore-560016\n75062487965";
  String? _tempAddress;

  @override
  Widget build(BuildContext context) {
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
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {},
        // ),
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
                    _buildPriceDetails(),
                  ],
                ),
              ),
            ),
          ),
          _buildBottomBar(),
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
                ),
              ],
            ),
            // SizedBox(height: 12),
            Text(
              _selectedAddress,
              style: GoogleFonts.aBeeZee(height: 1.9),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddressBottomSheet(BuildContext context) {
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
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Choose a delivery address",
                    style: GoogleFonts.aBeeZee(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  RadioListTile<String>(
                    title: Text(
                      "Home: Akshya Nagar, Bangalore",
                      style: GoogleFonts.aBeeZee(),
                    ),
                    value:
                        "Manjima C\nAkshya Nagar 1st Block 1st Cross,\nRamamurthy Nagar, Bangalore-560016\n75062487965",
                    groupValue: _tempAddress ?? _selectedAddress,
                    onChanged: (String? value) {
                      setModalState(() {
                        _tempAddress = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text(
                      "Work: MG Road, Bangalore",
                      style: GoogleFonts.aBeeZee(),
                    ),
                    value: "Manjima C\nMG Road,\nBangalore-560001\n75062487965",
                    groupValue: _tempAddress ?? _selectedAddress,
                    onChanged: (String? value) {
                      setModalState(() {
                        _tempAddress = value!;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedAddress = _tempAddress!;
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
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildProductDetails() {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/products/pr3.jpeg',
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
                    'Boys Printed Cotton Blend Regular T Shirt (Blue)',
                    style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '₹ 499',
                    style: GoogleFonts.aBeeZee(fontSize: 13),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        'Qty : 1',
                        style: GoogleFonts.aBeeZee(fontSize: 13),
                      ),
                      SizedBox(width: 16),
                      Text(
                        'Size : M',
                        style: GoogleFonts.aBeeZee(fontSize: 13),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Delivery by Sep 30, Fri ',
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

  Widget _buildPriceDetails() {
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
            _buildPriceRow('Price (1 item)', '₹ 899'),
            // SizedBox(height: 10),
            _buildPriceRow('Discount', '- ₹ 400', isDiscount: true),
            // SizedBox(height: 10),
            _buildPriceRow('Delivery Charges', 'Free delivery',
                isDiscount: true),
            Divider(),
            _buildPriceRow('Total Amount', '₹ 499', isTotal: true),
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

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '₹ 499',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PaymentPage()));
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
        ],
      ),
    );
  }
}
