import 'package:dil_hack_e_commerce/api/order_api.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Orders/order_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Orders/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository; // Assuming you have a repository
  String userId = '';

  OrderBloc(this.orderRepository) : super(OrderInitial());

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is FetchOrders) {
      yield OrderLoading();
      try {
        final orders = await orderRepository.fetchOrders(userId);
        yield OrderLoaded(orders);
      } catch (e) {
        yield OrderError(e.toString());
      }
    }

    if (event is CreateOrder) {
      // Logic to create an order can go here
    }
  }
}
