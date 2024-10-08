import 'package:dil_hack_e_commerce/api/category_api.dart';
import 'package:dil_hack_e_commerce/api/wishList_api.dart';
import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Categories/category_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Categories/category_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Categories/category_state.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Products/product_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Searchbar/search_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Searchbar/search_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/WishList/wish_list_event.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/newArrival_widget.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/productPage.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/productsByCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:dil_hack_e_commerce/api/new_arrivals_api.dart';
import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:dil_hack_e_commerce/features/auth/model/categories.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/BannerOffers/offer_carousel.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/search.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/widgets/top_row.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Product>> futureProducts;
  String searchTerm = '';

  @override
  void initState() {
    super.initState();
    futureProducts = GetAllNewArrivalsApi().fetchNewArrivals();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: CustomScrollView(
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

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: NewArrivalsWidget(),
            ),
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
    return Container(
        color: Colors.white,
        child: SizedBox.expand(child: child));
  }

  @override
  bool shouldRebuild(_SliverHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}