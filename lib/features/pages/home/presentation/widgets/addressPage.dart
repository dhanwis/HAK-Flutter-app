import 'package:dil_hack_e_commerce/features/auth/model/address.dart';
import 'package:dil_hack_e_commerce/features/pages/home/presentation/order_screen.dart';
import 'package:flutter/material.dart';

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
  //late BankDetailService bankDetailService;

  // Step Circle Widget
  Widget _buildStepCircle(int stepNumber, String title, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: isActive ? Colors.green : Colors.grey,
          child: Text(
            stepNumber.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(height: 8),
        Text(title, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  // void _addOrUpdateBankDetail() async {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();

  //     try {
  //       Address? addedDetail = await bankDetailService.addBankDetail(
  //         accountNumber: accountNumber,
  //         bankName: bankName,
  //         ifscCode: ifscCode,
  //         accountHolderName: accountHolderName,
  //       );

  //       if (addedDetail != null) {
  //         // Handle success (e.g., show a success message or update the UI)
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Bank details added successfully')),
  //         );
  //       }
  //     } catch (error) {
  //       // Handle error (e.g., show an error message)
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to add bank details')),
  //       );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address'),
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
                      decoration: InputDecoration(labelText: 'Full Name'),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter name' : null,
                      onSaved: (value) => name = value!,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Phone Number'),
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter phone number' : null,
                      onSaved: (value) => phone = value!,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Street Address'),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter street address' : null,
                      onSaved: (value) => street = value!,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'City'),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter city' : null,
                      onSaved: (value) => city = value!,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'pinCode'),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter pinCode' : null,
                      onSaved: (value) => pinCode = value!,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Country'),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter country' : null,
                      onSaved: (value) => country = value!,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // _addOrUpdateBankDetail;
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          // Navigate to the Order Summary Page with the saved address
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderScreen(
                                address: Address(
                                  name: name,
                                  phone: phone,
                                  street: street,
                                  city: city,
                                  pinCode: pinCode,
                                  // country: country,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      child: Text('Save Address'),
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
