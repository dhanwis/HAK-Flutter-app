import 'package:dil_hack_e_commerce/api/order_api.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Orders/order_event.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/Orders/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc({required this.orderRepository}) : super(OrderInitial()) {
    on<FetchOrders>((event, emit) async {
      emit(OrderLoading());

      try {
        final orders = await orderRepository.fetchOrders(event.userId);

        emit(OrdersLoaded(orders)); // Remove the cast to List<Order>
      } catch (e) {
        emit(OrderError(e.toString()));
      }
    });

    on<CreateOrder>((event, emit) async {
      try {
        await orderRepository.createOrder(event.order);
        emit(OrderCreated());
      } catch (e) {
        emit(OrderError(e.toString()));
      }
    });

    on<DeleteOrder>((event, emit) async {
      try {
        await orderRepository.deleteOrder(event.orderId);
        emit(OrderDeleted());
      } catch (e) {
        emit(OrderError(e.toString()));
      }
    });

    on<FetchOrderById>((event, emit) async {
      emit(OrderLoading());
      try {
        final order = await orderRepository.fetchOrderById(event.orderId);
        emit(OrderLoaded(order));
      } catch (e) {
        emit(OrderError(e.toString()));
      }
    });
  }
}
