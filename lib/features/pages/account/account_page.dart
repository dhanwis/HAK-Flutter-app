import 'package:dil_hack_e_commerce/api/userProfile_api.dart';

import 'package:dil_hack_e_commerce/constants/decodeJwt.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/UserProfile/user_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/UserProfile/user_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
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
  List<String> _stateController = [
    // Ensure this is populated correctly
    'Kasargod',
    'Kannur',
    'Kozhikode',
    'Wayanad',
    'Malapuram',
    'Palakad',
    'Trissur',
    'Eranakulam',
    'idukki',
    'pathanamthitta',
    'Kottayam',
    'Alapuzha',
    'Kollam',
    'Thiruvananthapuram',
  ];

  Future<String?> getUserIdFromJwt() async {
    try {
      Map<String, dynamic> decodedToken = await decodeJwt();
      return decodedToken[
          'userId']; // Assuming 'userId' is a key in the token payload
    } catch (error) {
      print('Error decoding JWT: $error');
      return null; // Handle error appropriately
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch the userId when the widget is initialized
    getUserId();
  }

  Future<void> getUserId() async {
    final fetchedUserId = await getUserIdFromJwt();
    setState(() {
      userId = fetchedUserId;
    });
  }

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

  // Future<void> _saveProfile() async {
  //   if (_formKey.currentState!.validate()) {
  //     try {
  //       // Gather data from form fields
  //       String username = _nameController.text;
  //       String email = _emailController.text;
  //       String phoneNumber = _phoneController.text;
  //       String pincode = _pincodeController.text;
  //       String city = _cityController.text;
  //       String state = _selectedState ?? '';

  //       // Convert image to path or handle it if necessary
  //       String userImgPath = _image != null ? _image!.path : '';

  //       // Call createCustomerProfile function
  //       CustomerProfile profile = await ApiService().createCustomerProfile(
  //         username: username,
  //         email: email,
  //         phoneNumber: phoneNumber,
  //         pincode: pincode,
  //         city: city,
  //         state: state,
  //         userImgPath: userImgPath,
  //       );

  //       // Show success message
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           backgroundColor: Colors.green,
  //           // Color.fromARGB(255, 249, 231, 233),
  //           content: Text('Data saved successfully! Profile ID: ${profile.id}',
  //               style: GoogleFonts.aBeeZee(color: Colors.black)),
  //           duration: Duration(seconds: 2),
  //         ),
  //       );
  //     } catch (e) {
  //       // Show error message
  //       print('Error: $e'); // Log the error
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           backgroundColor: Colors.red,
  //           content: Text('Error saving data: $e',
  //               style: TextStyle(color: Colors.white)),
  //           duration: Duration(seconds: 2),
  //         ),
  //       );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(ApiService()),
      // Provide ProfileBloc here
      child: Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => DilHackBottomNavBar()),
          //     );
          //   },
          //   icon: const Icon(Icons.arrow_back),
          // ),
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
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const CircularProgressIndicator();
                  }

                  if (state is ProfileLoaded) {
                    // Use state.profile to access loaded profile data
                    return _buildProfileForm(context);
                  }

                  if (state is ProfileError) {
                    return Text('Error: ${state.error}');
                  }

                  // Default to showing the form
                  return _buildProfileForm(context);
                },
              ),
            ),
          ),
        ),
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
          items: _stateController.isNotEmpty
              ? _stateController
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
            if (_formKey.currentState!.validate()) {
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
