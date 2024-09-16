import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  double _currentRating = 3.0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'My Orders',
          style: GoogleFonts.aBeeZee(fontSize: 15),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.06), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(screenWidth),
            SizedBox(height: 10),
            _buildStatusTabs(),
            SizedBox(height: 18),
            Divider(),
            OrderDetails(
              customerName: 'Manjima C',
              orderId: '54688978954',
              supplier: 'Kidbea',
            ),
            Divider(),
            _buildOrderCard(screenWidth),
            Divider(),
            _buildRatingDropdown(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(double screenWidth) {
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
                hintText: 'Search....',
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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatusButton('Ordered'),
        _buildStatusButton('Shipped'),
        _buildStatusButton('Delivered'),
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
              fontSize: 8, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          side: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildOrderCard(double screenWidth) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screenWidth * 0.15,
                height: screenWidth * 0.19,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage('assets/products/pr9.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Boys Printed Cotton Blend Regular T Shirt (Blue)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 18),
                    Text(
                      'Delivery by Sept 18',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
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
        style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),
      ),
      children: [
        SizedBox(height: 10),
        Column(
          children: [
            RatingBar.builder(
              initialRating: _currentRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 19.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _currentRating = rating;
                });
              },
            ),
            SizedBox(height: 10),
            _buildRatingLabels(),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildRatingLabels() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildRatingLabel('Very Bad', 1),
        _buildRatingLabel('Bad', 2),
        _buildRatingLabel('Ok-Ok', 3),
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
  // final String orderDate;
  final String orderId;
  final String customerName;
  final String supplier;

  OrderDetails({
    // required this.orderDate,
    required this.orderId,
    required this.customerName,
    required this.supplier,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: EdgeInsets.all(15),
        //   child: Text(
        //       // orderDate,
        //       // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        //       // ),
        //       ),
        // ),
        // // Divider(),
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
        Divider(),
        Padding(
          padding: EdgeInsets.all(15),
          child: RichText(
            text: TextSpan(
              text: 'Supplier: ',
              style: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 14),
              children: [
                TextSpan(
                  text: supplier,
                  style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
