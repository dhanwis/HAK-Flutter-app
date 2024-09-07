import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAvatar extends StatefulWidget {
  @override
  _ProfileAvatarState createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  void _openCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  void _openGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  void _deleteImage() {
    setState(() {
      _imageFile = null;
    });
  }

  void _showOptionDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _openCamera();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _openGallery();
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
                onTap: () {
                  Navigator.of(context).pop();
                  _deleteImage();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showOptionDialog,
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey.shade200,
        backgroundImage:
            _imageFile != null ? FileImage(File(_imageFile!.path)) : null,
        child: _imageFile == null
            ? Icon(
                Icons.person,
                size: 30,
              )
            : null,
      ),
    );
  }
}
