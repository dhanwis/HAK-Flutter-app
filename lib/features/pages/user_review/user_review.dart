// import 'package:flutter/material.dart';

// class ReviewPage extends StatelessWidget {
//   const ReviewPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: const EdgeInsets.all(16.0),
//       children: const [
//         ReviewCard(
//           rating: 5,
//           title: "Very Good",
//           daysAgo: 14,
//           reviewText: "Very good super",
//           reviewerName: "Lavanya",
//         ),
//         SizedBox(height: 10),
//         ReviewCard(
//           rating: 5,
//           title: "Very Good",
//           daysAgo: 13,
//           reviewText: "Customer liked the dress",
//           reviewerName: "Gayatri M",
//         ),
//       ],
//     );
//   }
// }

// class ReviewCard extends StatelessWidget {
//   final int rating;
//   final String title;
//   final int daysAgo;
//   final String reviewText;
//   final String reviewerName;

//   const ReviewCard({
//     super.key,
//     required this.rating,
//     required this.title,
//     required this.daysAgo,
//     required this.reviewText,
//     required this.reviewerName,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(
//                 Icons.star,
//                 color: Colors.green,
//               ),
//               const SizedBox(width: 5),
//               Text(
//                 "$rating.0",
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.green,
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const Spacer(),
//               Text(
//                 "Posted $daysAgo days ago",
//                 style: const TextStyle(color: Colors.grey),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Text(
//             reviewText,
//             style: const TextStyle(fontSize: 16),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             "~$reviewerName",
//             style: const TextStyle(fontStyle: FontStyle.italic),
//           ),
//           const SizedBox(height: 10),
//           Row(
//             children: [
//               IconButton(
//                 onPressed: () {},
//                 icon: const Icon(Icons.thumb_up_alt_outlined),
//               ),
//               const Text("Helpful"),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class ReviewPage extends StatelessWidget {
//   const ReviewPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: const EdgeInsets.all(16.0),
//       children: const [
//         ReviewCard(
//           rating: 5,
//           title: "Very Good",
//           daysAgo: 14,
//           reviewText: "Very good super",
//           reviewerName: "Lavanya",
//         ),
//         SizedBox(height: 10),
//         ReviewCard(
//           rating: 5,
//           title: "Very Good",
//           daysAgo: 13,
//           reviewText: "Customer liked the dress",
//           reviewerName: "Gayatri M",
//         ),
//       ],
//     );
//   }
// }

// class ReviewCard extends StatelessWidget {
//   final int rating;
//   final String title;
//   final int daysAgo;
//   final String reviewText;
//   final String reviewerName;

//   const ReviewCard({
//     super.key,
//     required this.rating,
//     required this.title,
//     required this.daysAgo,
//     required this.reviewText,
//     required this.reviewerName,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: SingleChildScrollView(
//         child: Container(
//           height: 100,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Icon(
//                     Icons.star,
//                     color: Colors.green,
//                   ),
//                   const SizedBox(width: 5),
//                   Text(
//                     "$rating.0",
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green,
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const Spacer(),
//                   Text(
//                     "Posted $daysAgo days ago",
//                     style: const TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 reviewText,
//                 style: const TextStyle(fontSize: 16),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 "~$reviewerName",
//                 style: const TextStyle(fontStyle: FontStyle.italic),
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {},
//                     icon: const Icon(Icons.thumb_up_alt_outlined),
//                   ),
//                   const Text("Helpful"),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        ReviewCard(
          rating: 5,
          title: "Very Good",
          daysAgo: 14,
          reviewText: "Very good super",
          reviewerName: "Lavanya",
        ),
        SizedBox(height: 10),
        ReviewCard(
          rating: 5,
          title: "Very Good",
          daysAgo: 13,
          reviewText: "Customer liked the dress",
          reviewerName: "Gayatri M",
        ),
      ],
    );
  }
}

class ReviewCard extends StatelessWidget {
  final int rating;
  final String title;
  final int daysAgo;
  final String reviewText;
  final String reviewerName;

  const ReviewCard({
    super.key,
    required this.rating,
    required this.title,
    required this.daysAgo,
    required this.reviewText,
    required this.reviewerName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                for (int i = 0; i < rating; i++)
                  const Icon(Icons.star, color: Colors.green, size: 16),
                const SizedBox(width: 5),
                Text(
                  "$rating.0",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  "Posted $daysAgo days ago",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              reviewText,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              "~$reviewerName",
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.thumb_up_alt_outlined),
                ),
                const Text("Helpful"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
