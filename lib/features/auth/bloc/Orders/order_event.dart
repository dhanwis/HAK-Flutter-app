import 'package:dil_hack_e_commerce/features/auth/model/order.dart';

abstract class OrderEvent {}

class FetchOrders extends OrderEvent {}

class CreateOrder extends OrderEvent {
  final Order order;

  CreateOrder(this.order);
}
