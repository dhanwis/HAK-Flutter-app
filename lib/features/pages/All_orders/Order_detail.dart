import 'package:dil_hack_e_commerce/features/auth/model/order.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/product_detailpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailPage extends StatefulWidget {
  final Order order;

  const OrderDetailPage({required this.order, Key? key}) : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    Order order = widget.order; // Access the passed order here
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Order Details",
          style: GoogleFonts.aBeeZee(fontSize: 17),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    // Use the first product image from the order with the proper base URL
                    order.products[0].variant.images.isNotEmpty
                        ? 'http://192.168.1.12:8000/ProductImg/${order.products[0].productId}/${order.products[0].variant.images[0]}'
                        : 'assets/placeholder.png', // Placeholder image if no images available
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.products[0].productName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.aBeeZee(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '₹${order.products[0].price}  •  All issue easy returns',
                        style: GoogleFonts.aBeeZee(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Size: ${order.products[0].sku.size}',
                        style: GoogleFonts.aBeeZee(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'Order Tracking',
              style: GoogleFonts.aBeeZee(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 18),
            Expanded(
              child: ListView(
                children: [
                  _buildTrackingStep(
                    title: "Order Placed",
                    subtitle: "Your order has been placed.",
                    time: order.createdAt.toString(),
                    isCompleted: true,
                  ),
                  _buildTrackingStep(
                    title: "Shipped",
                    subtitle:
                        "Expected by ${order.shippingMethod.estimatedDelivery ?? 'N/A'}",
                    isCompleted: false,
                  ),
                  _buildTrackingStep(
                    title: "Delivered",
                    subtitle: "Expected by 21 September, 2024",
                    isCompleted: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildTrackingStep({
  required String title,
  required String subtitle,
  String? time,
  required bool isCompleted,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          Icon(
            Icons.circle,
            color: isCompleted ? Colors.green : Colors.grey,
            size: 12,
          ),
          if (!isCompleted)
            Container(
              width: 2,
              height: 40,
              color: Colors.grey,
            ),
        ],
      ),
      SizedBox(width: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.aBeeZee(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              subtitle,
              style: GoogleFonts.aBeeZee(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            if (time != null)
              Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            SizedBox(height: 16),
          ],
        ),
      ),
    ],
  );
}
