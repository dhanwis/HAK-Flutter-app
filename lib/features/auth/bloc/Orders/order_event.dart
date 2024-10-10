import 'package:dil_hack_e_commerce/features/auth/model/order.dart';
import 'package:equatable/equatable.dart';

// Define events for OrderBloc
abstract class OrderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchOrders extends OrderEvent {
  final String userId;

  FetchOrders(this.userId);

  @override
  List<Object?> get props => [userId];
}

class CreateOrder extends OrderEvent {
  final Order order;

  CreateOrder(this.order);

  @override
  List<Object?> get props => [order];
}

class DeleteOrder extends OrderEvent {
  final String orderId;

  DeleteOrder(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class FetchOrderById extends OrderEvent {
  final String orderId;

  FetchOrderById(this.orderId);

  @override
  List<Object?> get props => [orderId];
}
