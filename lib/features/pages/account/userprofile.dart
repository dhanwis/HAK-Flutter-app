import 'package:dil_hack_e_commerce/constants/decodeJwt.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/UserProfile/user_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/UserProfile/user_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required String userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<String?> getUserIdFromJwt() async {
    try {
      Map<String, dynamic> decodedToken = await decodeJwt();
      return decodedToken[
          'userId']; // Assuming 'userId' is a key in the token payload
    } catch (error) {
      return null; // Handle error appropriately
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getUserId();
  // }

  late ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    getUserId();

    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.add(FetchProfile(userId!)); // Dispatch event here
  }

  Future<void> getUserId() async {
    final fetchedUserId = await getUserIdFromJwt();
    print('Fetched User ID: $fetchedUserId'); // Debugging

    setState(() {
      userId = fetchedUserId;
    });
  }

  String? userId;
  final _formKey = GlobalKey<FormState>();
  File? _image; // For image selection
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _cityController = TextEditingController();
  //final _stateController = TextEditingController();
  String? _selectedState;
  //XFile? _image;
  List<String> states = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    'Andaman and Nicobar Islands',
    'Chandigarh',
    'Lakshadweep',
    'Delhi',
    'Puducherry',
    'Ladakh',
    'Jammu and Kashmir',
  ];

  Future<void> _getImageFromGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
        });
      }
    } catch (e) {}
  }

  Future<void> _getImageFromCamera() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
        });
      }
    } catch (e) {}
  }

  Future<void> _updateImage() async {
    try {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Choose from Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    await _getImageFromGallery();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Take a Picture'),
                  onTap: () async {
                    Navigator.pop(context);
                    await _getImageFromCamera();
                  },
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {}
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _getImageFromGallery().then((_) {
                    Navigator.pop(context);
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _getImageFromCamera().then((_) {
                    Navigator.pop(context);
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Remove'),
                titleTextStyle: GoogleFonts.aBeeZee(color: Colors.black),
                onTap: () {
                  setState(() {
                    _image = null; // Clear the selected image
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter mobile number';
    }
    String pattern = r'(^[0-9]{10}$)';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid 10-digit mobile number';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    }
    String pattern = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Name';
    }
    return null;
  }

  String? _validatePincode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Pincode';
    }
    String pattern = r'^[1-9][0-9]{5}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid 6-digit PIN code';
    }
    return null;
  }

  String? _validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter City';
    }
    return null;
  }

  String? _validateState(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter State';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: GoogleFonts.aBeeZee(
            color: Color.fromARGB(255, 4, 4, 4),
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        backgroundColor: const Color(0xFFFAAAB1),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          print('Current state: $state');

          if (state is ProfileLoading) {
            return const Center(
              child: SpinKitFadingCircle(
                color: Color(0xFFFAAAB1),
                size: 50.0,
              ),
            );
          }

          if (state is ProfileLoaded) {
            print('Profile successfully loaded');
            _nameController.text = state.profile.username;
            _phoneController.text = state.profile.phoneNumber;
            _emailController.text = state.profile.email;
            _pincodeController.text = state.profile.pincode;
            _cityController.text = state.profile.city;

            // Check if the server-provided state exists in the dropdown list
            if (states.contains(state.profile.state)) {
              _selectedState = state.profile.state;
            } else {
              _selectedState = states.isNotEmpty
                  ? states.first
                  : null; // Set to first item or null if list is empty
            }

            return _buildProfileForm(context);
          }

          if (state is ProfileError) {
            return Text('Error: ${state.error}');
          }

          // Default to showing the form
          return _buildProfileForm(context);
        },
      ),
    );
  }

  Widget _buildProfileForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image display and picker logic
        GestureDetector(
          onTap: () {
            if (_image != null) {
              _showImageSourceActionSheet(context);
            }
          },
          child: _image != null
              ? ClipOval(
                  child: Image.file(
                    _image!, // Ensure that _image is a valid file path
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    _showImageSourceActionSheet(context);
                  },
                  icon: const Icon(
                    Icons.camera_alt,
                    size: 30,
                  ),
                ),
        ),
        // Text fields and form fields
        _buildTextFormField(
          controller: _nameController,
          label: 'Name',
          icon: Icons.person,
          validator: _validateName,
          keyboardType: TextInputType.name,
        ),
        _buildTextFormField(
          controller: _phoneController,
          label: 'Phone Number',
          icon: Icons.phone,
          validator: _validateMobile,
          keyboardType: TextInputType.phone,
        ),
        _buildTextFormField(
          controller: _emailController,
          label: 'Email id',
          icon: Icons.email,
          validator: _validateEmail,
          keyboardType: TextInputType.emailAddress,
        ),
        _buildTextFormField(
          controller: _pincodeController,
          label: 'Pincode',
          icon: Icons.pin,
          validator: _validatePincode,
          keyboardType: TextInputType.number,
        ),

        _buildDropdownField(
          context: context,
          selectedState: _selectedState,
          items: states.isNotEmpty
              ? states
              : ['Select a state'], // Safeguard for empty list
          onChanged: (newValue) {
            setState(() {
              _selectedState = newValue;
            });
          },
        ),

        _buildTextFormField(
          controller: _cityController,
          label: 'City',
          icon: Icons.location_on,
          validator: _validateCity,
          keyboardType: TextInputType.name,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          child: Text(
            'Save',
            style: GoogleFonts.aBeeZee(color: Colors.black),
          ),
          onPressed: () {
            if (_formKey.currentState != null &&
                _formKey.currentState!.validate()) {
              print('create function start');
              BlocProvider.of<ProfileBloc>(context).add(
                CreateUser(
                  username: _nameController.text,
                  email: _emailController.text,
                  phoneNumber: _phoneController.text,
                  pincode: _pincodeController.text,
                  city: _cityController.text,
                  state: _selectedState ?? '',
                  userImgPath: _image != null ? _image!.path : '',
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFAAAB1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      ],
    );
  }

  // Utility widget for text form fields
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
    required TextInputType keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, size: 18),
          labelText: label,
          labelStyle: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 15),
          enabledBorder: const UnderlineInputBorder(),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }

  // Utility widget for Dropdown form field
  Widget _buildDropdownField({
    required BuildContext context,
    required String? selectedState,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: DropdownButtonFormField<String>(
        value: selectedState,
        items: items.map((String state) {
          return DropdownMenuItem<String>(
            value: state,
            child: Text(state),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.location_city, size: 18),
          labelText: 'State',
          labelStyle: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 15),
          enabledBorder: const UnderlineInputBorder(),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a state';
          }
          return null;
        },
      ),
    );
  }
}
