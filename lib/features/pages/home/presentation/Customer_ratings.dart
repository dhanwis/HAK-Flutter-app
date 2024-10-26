// import 'package:flutter/material.dart';

// class CustomerReviews extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: EdgeInsets.all(16.0),
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Real images and videos from customers',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Row(
//               children: List.generate(5, (index) {
//                 return Padding(
//                   padding: const EdgeInsets.only(right: 4.0),
//                   child: Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: Colors.grey.shade300,
//                       image: index == 4
//                           ? null
//                           : DecorationImage(
//                               image: AssetImage('assets/products/pr2.jpeg'),
//                               fit: BoxFit.cover,
//                             ),
//                     ),
//                     child: index == 4
//                         ? Center(
//                             child: Text(
//                               '+345',
//                               style: TextStyle(color: Colors.black54),
//                             ),
//                           )
//                         : null,
//                   ),
//                 );
//               }),
//             ),
//             SizedBox(height: 16),
//           ],
//         ),

//         // Individual customer reviews
//         ReviewCard(
//           rating: 4,
//           title: "Good",
//           date: "22 Oct, 2023",
//           comment: "Nice design nd nice fabric",
//           author: "Madhuri Saundade",
//           helpfulCount: 3,
//         ),
//         Divider(),
//         ReviewCard(
//           rating: 5,
//           title: "Very Good",
//           date: "11 Jul, 2024",
//           comment:
//               "Bohut acha dress hey or quality bhi bohut achi hey muz...Read More",
//           author: "nisha patil",
//           helpfulCount: 0,
//         ),
//       ],
//     );
//   }
// }

// class ReviewCard extends StatelessWidget {
//   final int rating;
//   final String title;
//   final String date;
//   final String comment;
//   final String author;
//   final int helpfulCount;

//   const ReviewCard({
//     Key? key,
//     required this.rating,
//     required this.title,
//     required this.date,
//     required this.comment,
//     required this.author,
//     this.helpfulCount = 0,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             // Rating badge
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: Colors.green,
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               child: Row(
//                 children: [
//                   Text(
//                     '$rating',
//                     style: TextStyle(
//                         color: Colors.white, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(width: 4),
//                   Text(
//                     title,
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(width: 8),
//             Text(
//               '• Posted on $date',
//               style: TextStyle(color: Colors.grey, fontSize: 12),
//             ),
//           ],
//         ),
//         SizedBox(height: 8),
//         Text(comment),
//         SizedBox(height: 4),
//         Text(
//           '~$author',
//           style: TextStyle(color: Colors.grey),
//         ),
//         SizedBox(height: 8),
//         Row(
//           children: [
//             Icon(Icons.thumb_up_alt_outlined, size: 16, color: Colors.grey),
//             SizedBox(width: 4),
//             Text(helpfulCount > 0 ? 'Helpful ($helpfulCount)' : 'Helpful'),
//           ],
//         ),
//         SizedBox(height: 16),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomerReviews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Customer images section
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Real images and videos from customers',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: List.generate(5, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade300,
                        image: index == 4
                            ? null
                            : DecorationImage(
                                image:
                                    AssetImage('assets/image_placeholder.png'),
                                fit: BoxFit.cover,
                              ),
                      ),
                      child: index == 4
                          ? Center(
                              child: Text(
                                '+345',
                                style: TextStyle(color: Colors.black54),
                              ),
                            )
                          : null,
                    ),
                  );
                }),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
        // Use Expanded to make ListView take available space
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              ReviewCard(
                rating: 4,
                title: "Good",
                date: "22 Oct, 2023",
                comment: "Nice design and nice fabric",
                author: "Madhuri Saundade",
                helpfulCount: 3,
              ),
              Divider(),
              ReviewCard(
                rating: 5,
                title: "Very Good",
                date: "11 Jul, 2024",
                comment:
                    "Bohut acha dress hey or quality bhi bohut achi hey muz...Read More",
                author: "nisha patil",
                helpfulCount: 0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ReviewCard extends StatelessWidget {
  final int rating;
  final String title;
  final String date;
  final String comment;
  final String author;
  final int helpfulCount;

  const ReviewCard({
    Key? key,
    required this.rating,
    required this.title,
    required this.date,
    required this.comment,
    required this.author,
    this.helpfulCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Rating badge
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Text(
                    '$rating',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 4),
                  Text(
                    title,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Text(
              '• Posted on $date',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(comment),
        SizedBox(height: 4),
        Text(
          '~$author',
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.thumb_up_alt_outlined, size: 16, color: Colors.grey),
            SizedBox(width: 4),
            Text(helpfulCount > 0 ? 'Helpful ($helpfulCount)' : 'Helpful'),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
