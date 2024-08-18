import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingAndReviews extends StatelessWidget {
  final double averageRating = 4.3;
  final int totalRatings = 7;
  final int totalReviews = 3;
  final ratingsCount = {
    'Very Good': 4,
    'Good': 0,
    'Ok-Ok': 0,
    'Bad': 0,
    'Very Bad': 3,
  };

  @override
  Widget build(BuildContext context) {
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
                    fontSize: 18,
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
                          fontSize: 40,
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
              style: GoogleFonts.aBeeZee(fontSize: 16, color: Colors.black),
            ),
          ),
          SizedBox(width: 8),
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
            style: GoogleFonts.aBeeZee(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
