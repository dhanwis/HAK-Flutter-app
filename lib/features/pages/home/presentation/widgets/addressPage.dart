import 'package:dil_hack_e_commerce/api/deliveryAddress_api.dart';
import 'package:dil_hack_e_commerce/features/auth/model/address.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/order_screen.dart';
import 'package:dil_hack_e_commerce/helpers/animated_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressFormPage extends StatefulWidget {
  @override
  _AddressFormPageState createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String phone = '';
  String street = '';
  String city = '';
  String pinCode = '';
  String country = '';

  late DeliveryAddressService deliveryAddressService;

  @override
  void initState() {
    super.initState();
    // Initialize the deliveryAddressService
    deliveryAddressService = DeliveryAddressService();
  }

  // Step Circle Widget
  Widget _buildStepCircle(int stepNumber, String title, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: isActive ? Color(0xFFFAAAB1) : Colors.grey,
          child: Text(
            stepNumber.toString(),
            style: GoogleFonts.aBeeZee(color: Colors.white),
          ),
        ),
        SizedBox(height: 8),
        Text(title, style: GoogleFonts.aBeeZee(fontSize: 12)),
      ],
    );
  }

  Future<Address?> _addDeliveryAddress() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        Address? addedDetail = await deliveryAddressService.addDeliveryAddress(
          name: name,
          phone: phone,
          street: street,
          city: city,
          pinCode: pinCode,
        );

        if (addedDetail != null) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Delivery Address Saved successfully'),
              backgroundColor: Color(0xFFFAAAB1),
            ),
          );
          return addedDetail; // Return the added address
        }
      } catch (error) {
        // Handle error (e.g., show an error message)
        print('Failed to add Delivery Address $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add Delivery Address $error'),
            backgroundColor: Color(0xFFFAAAB1),
          ),
        );
      }
    }

    return null; // Return null if adding address fails
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address', style: GoogleFonts.aBeeZee(fontSize: 16)),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stepper Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStepCircle(1, "Address", true), // Address step active
                _buildStepCircle(2, "Order summary", false), // Inactive
                _buildStepCircle(3, "Payment", false), // Inactive
              ],
            ),
            SizedBox(height: 40),

            // Address Form Container
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 228, 228, 232),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Full Name',
                          labelStyle: GoogleFonts.aBeeZee()),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter name' : null,
                      onSaved: (value) => name = value!,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: GoogleFonts.aBeeZee()),
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter phone number' : null,
                      onSaved: (value) => phone = value!,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Street Address',
                          labelStyle: GoogleFonts.aBeeZee()),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter street address' : null,
                      onSaved: (value) => street = value!,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'City', labelStyle: GoogleFonts.aBeeZee()),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter city' : null,
                      onSaved: (value) => city = value!,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'pinCode',
                          labelStyle: GoogleFonts.aBeeZee()),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter pinCode' : null,
                      onSaved: (value) => pinCode = value!,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        // Validate the form first
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          // Try adding the delivery address
                          Address? addedAddress = await _addDeliveryAddress();

                          // If address is added successfully, navigate to the OrderScreen
                          if (addedAddress != null) {
                            Future.delayed(const Duration(milliseconds: 300),
                                () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  createRoute(
                                      OrderScreen(address: addedAddress)),
                                  (route) => false);
                            });
                          }
                        }
                      },
                      child: Text(
                        'Save Address',
                        style: GoogleFonts.aBeeZee(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
