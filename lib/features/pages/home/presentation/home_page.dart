import 'dart:developer';

import 'package:dil_hack_e_commerce/api/category_api.dart';
import 'package:dil_hack_e_commerce/api/wishList_api.dart';
import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/constants/userId.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Categories/category_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Categories/category_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Categories/category_state.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Products/product_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Searchbar/search_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Searchbar/search_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/UserProfile/user_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_event.dart';
import 'package:dil_hack_e_commerce/features/auth/presentation/widgets/viewall_button.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/newArrival_widget.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/productPage.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/product_detailpage.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/productsByCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:dil_hack_e_commerce/api/new_arrivals_api.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:dil_hack_e_commerce/features/auth/model/categories.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/BannerOffers/offer_carousel.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/search.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/top_row.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../api/products_api.dart';
import '../../../../constants/decodeJwt.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Product>> futureProducts;
  String searchTerm = '';
  List<Product> products = [];
  int currentPage = 1;
  bool isLoadingMore = false;
  bool hasMoreProducts = true;
  bool isLoading = true; // Initial loading state
  final ScrollController _scrollController = ScrollController();

  String userId = '';

  @override
  void initState() {
    super.initState();
    futureProducts = GetAllNewArrivalsApi().fetchNewArrivals();

    _fetchProducts();
    _initializeUser();
    //context.read<ProfileBloc>().add(FetchProfile(userId));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        log("end of the line");
        _fetchProducts();
      }
    });
  }

  Future<void> _initializeUser() async {
    try {
      // Decode the token and get userId
      Map<String, dynamic> decodedToken = await decodeJwt();
      setState(() {
        userId = decodedToken[
            'userId']; // Assuming 'userId' is the key in your token
      });

      if (userId.isNotEmpty) {
        context.read<ProfileBloc>().add(FetchProfile(userId));
      }
    } catch (e) {}
  }

  Future<void> _fetchProducts() async {
    if (isLoadingMore || !hasMoreProducts) return;

    // Ensure setState is only called if mounted
    if (mounted) {
      setState(() {
        isLoadingMore = true;
      });
    }

    try {
      final newProducts =
          await GetAllProductApi().fetchProducts(page: currentPage);

      if (mounted) {
        if (newProducts.isEmpty) {
          setState(() {
            hasMoreProducts = false;
          });
        } else {
          setState(() {
            products.addAll(newProducts);
            currentPage++;
          });
        }
      }
    } catch (e) {
      // Handle error (e.g., show an error message)
    } finally {
      if (mounted) {
        setState(() {
          isLoadingMore = false;
          isLoading = false; // Stop loading after fetching products
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Top Bar with Search and AppBar
          SliverAppBar(
            surfaceTintColor: Colors.white,
            pinned: true,
            title: TopRow(),
            backgroundColor: Colors.white,
          ),
          SliverPersistentHeader(
            pinned: true, // Pin the widget
            delegate: _SliverHeaderDelegate(
              minHeight: 69.0,
              maxHeight: 69.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppSearchBar(
                  width: width,
                  onSearchTermChanged: (String value) {
                    setState(() {
                      searchTerm = value;
                    });
                    context.read<SearchBloc>().add(SearchTermChanged(value));
                  },
                ),
              ),
            ),
          ),

          // Search Bar Widget

          // Display Search Results if the searchTerm is not empty
          if (searchTerm.isNotEmpty)
            SliverToBoxAdapter(
              child: SizedBox(
                height: 800,
                child: buildSearchResults(),
              ),
            ),
          // Category List
          SliverToBoxAdapter(
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoriesLoading) {
                  return Skeletonizer(
                    enabled: true,
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.grey.shade200,
                              ),
                              const SizedBox(height: 5),
                              Container(
                                width: 80,
                                height: 15,
                                color: Colors.grey.shade200,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (state is CategoriesError) {
                  return Center(child: Text('Error: ${state.error}'));
                } else if (state is CategoriesLoaded) {
                  List<Category> categories = state.categories;
                  return SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            width: 60,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductsByCategory(
                                                  categoryId:
                                                      categories[index].id,
                                                )));
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 37,
                                    backgroundImage: NetworkImage(
                                        "${AppConstants.CATEOGRYIMG}/${categories[index].imageUrl}"),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  categories[index].label,
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 12,
                                    letterSpacing: 1,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center();
                }
              },
            ),
          ),

          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 10),
          //     child: NewArrivalsWidget(),
          //   ),
          // ),

          FutureBuilder<List<Product>>(
            future: futureProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverToBoxAdapter(
                  child: Skeletonizer(
                    enabled: true,
                    child: SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 150,
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Center(child: Text('Error: ${snapshot.error}')),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(),
                );
              } else {
                List<Product> products = snapshot.data!;
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'New Arrivals',
                                style: GoogleFonts.aBeeZee(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ViewAllButton(products: products),
                                    ),
                                  );
                                },
                                child: Text(
                                  'View All',
                                  style: GoogleFonts.aBeeZee(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 240,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              String imageUrl =
                                  products[index].variations[0].images[0];
                              String formattedPrice = NumberFormat('#,##0')
                                  .format(products[index]
                                      .variations[0]
                                      .skus[0]
                                      .actualPrice);
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailPage(
                                          productId: products[index].id),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  // child: Container(
                                  //   margin: const EdgeInsets.symmetric(
                                  //       horizontal: 1),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: Image.network(
                                            imageUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          products[index].productBrand,
                                          style: GoogleFonts.aBeeZee(
                                            color: Colors.grey,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 1),
                                        child: Text(
                                          products[index]
                                              .productName
                                              .toUpperCase(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.aBeeZee(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '₹ $formattedPrice',
                                        style: GoogleFonts.aBeeZee(
                                          color: Colors.green,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),

          // Offer Carousel Widget
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: OfferCarousel(),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Text(
                'All Products',
                style: GoogleFonts.aBeeZee(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              print('context state us this $state');
              if (state is ProductsLoaded) {
                return ProductGrid();
              }

              return SliverToBoxAdapter(child: Text("data"));
            },
          )
          // Product Grid Display from ProductBloc
        ],
      ),
    );
  }
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: Colors.white, child: SizedBox.expand(child: child));
  }

  @override
  bool shouldRebuild(_SliverHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}
