import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class ArrivalItems extends StatelessWidget {
  const ArrivalItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return ScrollItem(
            index: index,
            onTap: () {
              // Navigate to the next page when the item is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Newarrivels_detailpage()),
              );
            },
          );
        },
      ),
    );
  }
}

class ScrollItem extends StatelessWidget {
  final int index;
  final VoidCallback onTap;

  const ScrollItem({Key? key, required this.index, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> imageList = [
      'assets/images/sareee-removebg-preview.png',
      'assets/images/topss-removebg-preview.png',
      'assets/images/lehangaa-removebg-preview.png',
    ];

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 140,
          height: 170,
          child: Stack(
            children: [
              Image.asset(
                imageList[index],
                fit: BoxFit.contain,
              ),
              Positioned(
                left: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    color: Color.fromARGB(255, 227, 7, 7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Newarrivels_detailpage extends StatefulWidget {
  const Newarrivels_detailpage({super.key});

  @override
  State<Newarrivels_detailpage> createState() => _Newarrivels_detailpageState();
}

class _Newarrivels_detailpageState extends State<Newarrivels_detailpage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: height * 0.6,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: height * 0.6,
                    child: InstaImageViewer(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: AssetImage(
                              'asset/frockdetail/${index + 1}frock.jpg'),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Product Description",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RatingBar.builder(
                  initialRating: 4,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemSize: 20,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4),
                  itemBuilder: (context, _) => Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onRatingUpdate: (index) {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Fancy Banarasi Silk  Women's Saree",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "\$2000",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Free Delivery",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CartButton(
                label: 'Add To Cart',
              ),
              CartButton(label: 'Buy Now')
            ],
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class CartButton extends StatelessWidget {
  final String label;

  const CartButton({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 40,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.amber.shade400,
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 10),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.aBeeZee(
                color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
