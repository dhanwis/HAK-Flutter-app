import 'package:flutter/material.dart';

class OrderDetailPage extends StatefulWidget {
  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ORDER DETAILS"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
                    'assets/products/pr6.jpeg',
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
                        'Women white cotton blend trouser',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '₹271  •  All issue easy returns',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Size: XL',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
            SizedBox(height: 24),
            Text(
              'Order Tracking',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildTrackingStep(
                    title: "Order Placed",
                    subtitle: "Your order has been placed.",
                    time: "02:41 PM, 11 September, 2024",
                    isCompleted: true,
                  ),
                  _buildTrackingStep(
                    title: "Shipped",
                    subtitle: "Expected by 13 September, 2024",
                    isCompleted: false,
                  ),
                  _buildTrackingStep(
                    title: "Delivered",
                    subtitle: "Expected by 21 September, 2024",
                    isCompleted: false,
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "SHOW MORE",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFAAAB1),
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down,
                            color: Color(0xFFFAAAB1)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
        // Timeline Indicator
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
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
}
