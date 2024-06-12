import 'package:dil_hack_e_commerce/features/pages/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    print('build called');

    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        if(state is ProductsLoadingState){
          return Center(child: CircularProgressIndicator(),);
        }
        if (state is ProductsFetchedState) {
          print(state.productList.length);
          return ListView.builder(
              itemCount: state.productList.length,

              itemBuilder: (context, index) {
                print(index.toString());
                final product = state.productList[index];
                return Container(
                  child: Center(
                    child: Image.asset(product.image.toString()),
                  ),
                );
              });
        }
        if(state is ProductsFetchingErrorState){
          Text('error');
        }

       return Text('no dataaaaa');
      },
    );
  }
}
