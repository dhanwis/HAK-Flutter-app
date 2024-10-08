import 'package:dil_hack_e_commerce/features/auth/model/products.dart';
import 'package:equatable/equatable.dart';

abstract class NewArrivalsEvent extends Equatable {
  const NewArrivalsEvent();

  @override
  List<Object?> get props => [];
}

class FetchNewArrivalsEvent extends NewArrivalsEvent {
  const FetchNewArrivalsEvent();
}

// Define the UpdateNewArrivalsEvent
class UpdateNewArrivalsEvent extends NewArrivalsEvent {
  final List<Product> filteredProducts;

  UpdateNewArrivalsEvent(this.filteredProducts);
}
