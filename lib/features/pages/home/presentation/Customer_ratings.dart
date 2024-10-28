import 'package:dil_hack_e_commerce/api/review_api.dart';
import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductReviewsPage extends StatelessWidget {
  final String productId;

  ProductReviewsPage({required this.productId});

  @override
  Widget build(BuildContext context) {
    final reviewApi = ReviewApi();

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: reviewApi.getReviews(productId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SpinKitFadingCircle(
              color: Color(0xFFFAAAB1),
              size: 50.0,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error fetching reviews"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center();
        } else {
          var reviews = snapshot.data!;

          // Extracting images from reviews
          List<String> images = reviews
              .where((review) => review['image'] != null)
              .map((review) =>
                  '${AppConstants.BASE_URL}/reviewImg/${review['image']}')
              .toList();

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Real images and videos from customers',
                  style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 10),
                // Displaying images section
                Row(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: images.length > 4
                            ? 4
                            : images.length, // Show only the first 4 images
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            color: Palette.appTheme,
                            child: Image.network(
                              images[index],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.broken_image,
                                    color: Colors.grey);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    if (images.length > 4)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '+${images.length - 4}',
                          style: GoogleFonts.aBeeZee(color: Colors.grey),
                        ),
                      ),
                  ],
                ),
                Divider(),
                // Displaying reviews
                for (var review in reviews)
                  ReviewCard(
                    rating: review['rating'],
                    title: '', // Optional field
                    date: review['createdAt']
                        .substring(0, 10), // Format as needed
                    comment: review['comment'],
                    user: review['userId'], // Adjust as needed
                    helpfulCount: 0, // Adjust if you have this data
                    hasImages: review['image'] != null,
                    images: [review['image']], // Pass image if available
                  ),
              ],
            ),
          );
        }
      },
    );
  }
}

class ReviewCard extends StatelessWidget {
  final int rating;
  final String title;
  final String date;
  final String comment;
  final String user;
  final int helpfulCount;
  final bool hasImages;
  final List<String> images;

  ReviewCard({
    required this.rating,
    required this.title,
    required this.date,
    required this.comment,
    required this.user,
    required this.helpfulCount,
    required this.hasImages,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Palette.appTheme,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '$rating Stars',
                      style: GoogleFonts.aBeeZee(
                          color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Text(date,
                  style: GoogleFonts.aBeeZee(color: Colors.grey, fontSize: 12)),
            ],
          ),
          SizedBox(height: 8),
          Text(
            comment,
            style: GoogleFonts.aBeeZee(),
          ),
          SizedBox(height: 8),
          Text('~$user',
              style: GoogleFonts.aBeeZee(color: Colors.grey, fontSize: 12)),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.thumb_up_alt_outlined, size: 20),
                onPressed: () {},
              ),
              if (helpfulCount > 0) Text('Helpful ($helpfulCount)'),
              Spacer(),
              if (hasImages)
                Container(
                  width: 40,
                  height: 40,
                  color: Colors.green[200],
                  child: Image.network(
                    '${AppConstants.BASE_URL}/reviewImg/${images.first}',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.broken_image,
                          color: Colors.grey); // Optional error icon
                    },
                  ),
                ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
