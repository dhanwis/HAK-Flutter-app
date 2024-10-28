import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingAndReviews extends StatelessWidget {
  final double averageRating;
  final List<dynamic> reviews;

  RatingAndReviews({
    required this.averageRating,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate ratings count
    Map<String, int> ratingsCount = {
      'Very Good': 0,
      'Good': 0,
      'Ok-Ok': 0,
      'Bad': 0,
      'Very Bad': 0,
    };

    for (var review in reviews) {
      int rating = review['rating'];
      if (rating >= 4) {
        ratingsCount['Very Good'] = ratingsCount['Very Good']! + 1;
      } else if (rating == 3) {
        ratingsCount['Ok-Ok'] = ratingsCount['Ok-Ok']! + 1;
      } else if (rating == 2) {
        ratingsCount['Bad'] = ratingsCount['Bad']! + 1;
      } else {
        ratingsCount['Very Bad'] = ratingsCount['Very Bad']! + 1;
      }
    }

    int totalRatings = reviews.length;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customer Ratings & Reviews',
                style: GoogleFonts.aBeeZee(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$averageRating',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Icon(Icons.star, color: Colors.black, size: 40),
                  ],
                ),
              ],
            ),
          ),
          ...ratingsCount.keys.map((rating) {
            return RatingRow(
                ratingLabel: rating,
                ratingCount: ratingsCount[rating]!,
                totalRatings: totalRatings,
                color: rating == 'Very Good'
                    ? Colors.green
                    : rating == 'Very Bad'
                        ? Colors.red
                        : Colors.grey);
          }).toList(),
        ],
      ),
    );
  }
}

class RatingRow extends StatelessWidget {
  final String ratingLabel;
  final int ratingCount;
  final int totalRatings;
  final Color color;

  RatingRow({
    required this.ratingLabel,
    required this.ratingCount,
    required this.totalRatings,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              ratingLabel,
              style: GoogleFonts.aBeeZee(fontSize: 12, color: Colors.black),
            ),
          ),
          Expanded(
            flex: 2,
            child: LinearProgressIndicator(
              value: totalRatings == 0 ? 0 : ratingCount / totalRatings,
              backgroundColor: Colors.grey[200],
              color: color,
            ),
          ),
          SizedBox(width: 8),
          Text(
            ratingCount.toString(),
            style: GoogleFonts.aBeeZee(fontSize: 12, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
