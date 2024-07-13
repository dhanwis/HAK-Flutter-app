// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;

// class Sku {
//   final double actualPrice;
//   final double discount;
//   final int quantity;

//   Sku({
//     required this.actualPrice,
//     required this.discount,
//     required this.quantity,
//   });
// }

// class Variation {
//   final String color;
//   final List<String> images;
//   final List<Sku> skus;

//   Variation({
//     required this.color,
//     required this.images,
//     required this.skus,
//   });
// }

// class NewArrivalProduct {
//   final String id;
//   final String productId;
//   final String productName;
//   final String productDescription;
//   final String productCategory;
//   final double productWeight;
//   final String productFeatures;
//   final DateTime productPublishDatetime;
//   final String productPublishStatus;
//   final List<String> productTags;
//   final String productType;
//   final String productGender;
//   final String productBrand;
//   final List<Variation> variations;
//   final List<String> similarProducts;
//   final DateTime createdAt;
//   final int v;
//   final double descriptionSimilarity;
//   final double tagsSimilarity;
//   final double combinedSimilarity;

//   NewArrivalProduct({
//     required this.id,
//     required this.productId,
//     required this.productName,
//     required this.productDescription,
//     required this.productCategory,
//     required this.productWeight,
//     required this.productFeatures,
//     required this.productPublishDatetime,
//     required this.productPublishStatus,
//     required this.productTags,
//     required this.productType,
//     required this.productGender,
//     required this.productBrand,
//     required this.variations,
//     required this.similarProducts,
//     required this.createdAt,
//     required this.v,
//     required this.descriptionSimilarity,
//     required this.tagsSimilarity,
//     required this.combinedSimilarity,
//   });
// }

// class SimilarProductApi {
//   static Future<List<String>> fetchSimilarProductImages(
//       String productId, String firstImage) async {
//     final url = 'http://192.168.1.31:8000/ProductImg/$productId/$firstImage';

//     try {
//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         final List<dynamic> json = jsonDecode(response.body);
//         List<String> imageUrls = json.map((url) => url.toString()).toList();
//         return imageUrls;
//       } else {
//         throw Exception('Failed to load similar product images');
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }
// }

// class SimilarProductDetailPage extends StatefulWidget {
//   final NewArrivalProduct product;
//   final List<String> similarProductImages;

//   SimilarProductDetailPage({
//     Key? key,
//     required this.product,
//     required this.similarProductImages,
//   }) : super(key: key);

//   @override
//   _SimilarProductDetailPageState createState() =>
//       _SimilarProductDetailPageState();
// }

// class _SimilarProductDetailPageState extends State<SimilarProductDetailPage> {
//   late ScrollController _scrollController;
//   List<String> _similarProductImages = [];
//   int _page = 1;
//   bool _isLoading = false;
//   bool _hasMore = true;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     _scrollController.addListener(_onScroll);
//     _similarProductImages = widget.similarProductImages;
//   }

//   Future<void> _fetchSimilarProductImages() async {
//     if (_isLoading) return;

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final newImages = await SimilarProductApi.fetchSimilarProductImages(
//         widget.product.productId,
//         widget.product.variations.first.images.first,
//       );

//       setState(() {
//         _isLoading = false;
//         if (newImages.isEmpty) {
//           _hasMore = false;
//         } else {
//           _page++;
//           _similarProductImages.addAll(newImages);
//         }
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//         print('Error fetching similar product images: $e');
//       });
//     }
//   }

//   void _onScroll() {
//     if (_scrollController.position.extentAfter < 300 &&
//         !_isLoading &&
//         _hasMore) {
//       _fetchSimilarProductImages();
//     }
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final actualPrice = widget.product.variations.first.skus.first.actualPrice;
//     final discount = widget.product.variations.first.skus.first.discount;

//     final formattedPrice = NumberFormat('#,##0').format(actualPrice);

//     return Scaffold(
//       body: ListView(
//         controller: _scrollController,
//         children: [
//           Container(
//             height: height * 0.6,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: widget.product.variations.first.images.length,
//               itemBuilder: (context, index) {
//                 return SizedBox(
//                   height: height * 0.6,
//                   child: Image.network(
//                     'http://192.168.1.31:8000/ProductImg/${widget.product.productId}/${widget.product.variations.first.images[index]}',
//                     fit: BoxFit.cover,
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     capitalizeFirstLetter(widget.product.productName),
//                     style: GoogleFonts.aBeeZee(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 25,
//                     ),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.favorite, color: Colors.red),
//                       onPressed: () {},
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.share),
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               capitalizeFirstLetter(widget.product.productDescription),
//               style: GoogleFonts.aBeeZee(
//                 fontWeight: FontWeight.w300,
//                 fontSize: 15,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               '₹$formattedPrice',
//               style: GoogleFonts.aBeeZee(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//               ),
//             ),
//           ),
//           Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   'Similar Products',
//                   style: GoogleFonts.aBeeZee(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           FutureBuilder<List<String>>(
//             future: SimilarProductApi.fetchSimilarProductImages(
//               widget.product.productId,
//               widget.product.variations.first.images.first,
//             ),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return Center(child: Text('No similar products found.'));
//               } else {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: List.generate(
//                             _similarProductImages.length,
//                             (index) => Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               child: GestureDetector(
//                                 onTap: () {
//                                   // Navigate to the similar product detail page
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           SimilarProductDetailPage(
//                                         product: widget.product,
//                                         similarProductImages:
//                                             _similarProductImages,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 child: CircleAvatar(
//                                   backgroundImage: NetworkImage(
//                                       _similarProductImages[index]),
//                                   backgroundColor: Colors.grey.shade200,
//                                   radius: 40,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       if (_isLoading)
//                         Center(child: CircularProgressIndicator()),
//                     ],
//                   ),
//                 );
//               }
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 5, bottom: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 RatingBar.builder(
//                   initialRating: 4,
//                   minRating: 1,
//                   direction: Axis.horizontal,
//                   itemCount: 5,
//                   itemSize: 20,
//                   itemPadding: EdgeInsets.symmetric(horizontal: 4),
//                   itemBuilder: (context, _) => Icon(
//                     Icons.star,
//                     color: Colors.green,
//                   ),
//                   onRatingUpdate: (index) {},
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Select Size',
//                   style: GoogleFonts.aBeeZee(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 SizeSelector(),
//               ],
//             ),
//           ),
//           Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   'Product Details',
//                   style: GoogleFonts.aBeeZee(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               capitalizeFirstLetter(widget.product.productDescription),
//               style: GoogleFonts.aBeeZee(
//                 fontWeight: FontWeight.w300,
//                 fontSize: 15,
//               ),
//             ),
//           ),
//           SizedBox(height: 100),
//         ],
//       ),
//     );
//   }

//   String capitalizeFirstLetter(String text) {
//     return text.substring(0, 1).toUpperCase() + text.substring(1);
//   }
// }

// class SizeSelector extends StatefulWidget {
//   const SizeSelector({Key? key}) : super(key: key);

//   @override
//   _SizeSelectorState createState() => _SizeSelectorState();
// }

// class _SizeSelectorState extends State<SizeSelector> {
//   int _selectedIndex = 0;
//   List<String> _sizes = ['S', 'M', 'L', 'XL'];

//   @override
//   Widget build(BuildContext context) {
//     return ToggleButtons(
//       isSelected:
//           List.generate(_sizes.length, (index) => index == _selectedIndex),
//       onPressed: (int newIndex) {
//         setState(() {
//           _selectedIndex = newIndex;
//         });
//       },
//       children: List.generate(
//         _sizes.length,
//         (index) => Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12.0),
//           child: Text(_sizes[index]),
//         ),
//       ),
//     );
//   }
// }
