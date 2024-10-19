// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class UpiDetailsScreen extends StatefulWidget {
//   @override
//   _UpiDetailsScreenState createState() => _UpiDetailsScreenState();
// }

// class _UpiDetailsScreenState extends State<UpiDetailsScreen> {
//   bool agreeToTerms = true;
//   bool showUpiOptions = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         title: Text(
//           'MY Bank Account Details',
//           style: GoogleFonts.aBeeZee(fontSize: 15, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Bank Details',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 cursorColor: Colors.black,
//                 decoration: InputDecoration(
//                   hintText: 'Account Holder Name',
//                   hintStyle: GoogleFonts.lato(
//                     color: Colors.grey,
//                     fontSize: 14,
//                     fontStyle: FontStyle.italic,
//                   ),
//                   border: const OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.black),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               TextFormField(
//                 cursorColor: Colors.black,
//                 decoration: InputDecoration(
//                   hintText: 'Account Number',
//                   hintStyle: GoogleFonts.lato(
//                     color: Colors.grey,
//                     fontSize: 14,
//                     fontStyle: FontStyle.italic,
//                   ),
//                   border: const OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.black),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               TextFormField(
//                 cursorColor: Colors.black,
//                 decoration: InputDecoration(
//                   hintText: 'IFSC Code',
//                   hintStyle: GoogleFonts.lato(
//                     color: Colors.grey,
//                     fontSize: 14,
//                     fontStyle: FontStyle.italic,
//                   ),
//                   border: const OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.black),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               TextFormField(
//                 cursorColor: Colors.black,
//                 decoration: InputDecoration(
//                   hintText: 'Bank Name',
//                   hintStyle: GoogleFonts.lato(
//                     color: Colors.grey,
//                     fontSize: 14,
//                     fontStyle: FontStyle.italic,
//                   ),
//                   border: const OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.black),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               InkWell(
//                 onTap: () {
//                   setState(() {
//                     showUpiOptions = !showUpiOptions;
//                   });
//                 },
//                 child: SizedBox(
//                   height: 50,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFFFAAAB1),
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                     ),
//                     child: Text('Submit',
//                         style: GoogleFonts.aBeeZee(
//                             color: Colors.black, fontSize: 15)),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:dil_hack_e_commerce/api/bankdetail_api.dart';
import 'package:dil_hack_e_commerce/features/auth/model/bankDetails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BankDetailScreen extends StatefulWidget {
  final BankDetail? bankDetail;
  final bool isUpdate;

  BankDetailScreen({this.bankDetail, this.isUpdate = false});

  @override
  _BankDetailScreenState createState() => _BankDetailScreenState();
}

class _BankDetailScreenState extends State<BankDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late String accountNumber;
  late String bankName;
  late String ifscCode;
  late String accountHolderName;
  late BankDetailService bankDetailService;

  @override
  void initState() {
    super.initState();
    bankDetailService = BankDetailService();

    if (widget.isUpdate && widget.bankDetail != null) {
      accountNumber = widget.bankDetail!.accountNumber;
      bankName = widget.bankDetail!.bankName;
      ifscCode = widget.bankDetail!.ifscCode;
      accountHolderName = widget.bankDetail!.accountHolderName;
    } else {
      accountNumber = '';
      bankName = '';
      ifscCode = '';
      accountHolderName = '';
    }
  }

  void _addOrUpdateBankDetail() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        BankDetail? addedDetail = await bankDetailService.addBankDetail(
          accountNumber: accountNumber,
          bankName: bankName,
          ifscCode: ifscCode,
          accountHolderName: accountHolderName,
        );

        if (addedDetail != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Bank details added successfully',
                style: GoogleFonts.aBeeZee(),
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (error) {
        // Handle error (e.g., show an error message)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add bank details'),
            backgroundColor: Color(0xFFFAAAB1),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.isUpdate ? 'Update Bank Details' : 'Add Bank Details',
          style: GoogleFonts.aBeeZee(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: accountNumber,
                style: GoogleFonts.aBeeZee(),
                decoration: InputDecoration(
                  labelText: 'Account Number',
                  hintStyle: GoogleFonts.aBeeZee(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter account number';
                  }
                  return null;
                },
                onSaved: (value) {
                  accountNumber = value!;
                },
              ),
              TextFormField(
                initialValue: bankName,
                style: GoogleFonts.aBeeZee(),
                decoration: InputDecoration(
                  labelText: 'Bank Name',
                  hintStyle: GoogleFonts.aBeeZee(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter bank name';
                  }
                  return null;
                },
                onSaved: (value) {
                  bankName = value!;
                },
              ),
              TextFormField(
                initialValue: ifscCode,
                style: GoogleFonts.aBeeZee(),
                decoration: InputDecoration(
                  labelText: 'IFSC Code',
                  hintStyle: GoogleFonts.aBeeZee(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter IFSC code';
                  }
                  return null;
                },
                onSaved: (value) {
                  ifscCode = value!;
                },
              ),
              TextFormField(
                initialValue: accountHolderName,
                style: GoogleFonts.aBeeZee(),
                decoration: InputDecoration(
                  labelText: 'Account Holder Name',
                  hintStyle: GoogleFonts.aBeeZee(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter account holder name';
                  }
                  return null;
                },
                onSaved: (value) {
                  accountHolderName = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addOrUpdateBankDetail,
                child: Text(
                  widget.isUpdate ? 'Update ' : 'Add ',
                  style: GoogleFonts.aBeeZee(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFAAAB1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
