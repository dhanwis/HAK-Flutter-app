// import 'package:dil_hack_e_commerce/core/theme/palette.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class TopRow extends StatelessWidget {
//   const TopRow({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 5),
//           child: Image.asset(
//             'assets/images/logo-2.png',
//             height: 35,
//             color: Colors.black,
//           ),
//         ),
//         Row(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Welcome 👋',
//                   style: GoogleFonts.aBeeZee(fontSize: screenSize.width * 0.04),
//                 ),
//                 Text(
//                   'Manjima',
//                   style: GoogleFonts.aBeeZee(fontSize: screenSize.width * 0.04),
//                 ),
//               ],
//             ),
//             SizedBox(
//               width: 5,
//             ),
//             GestureDetector(
//               onTap: () {
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(builder: (context) => CreateProfilePage()),
//                 // );
//               },
//               child: CircleAvatar(
//                 radius: screenSize.width * 0.05,
//                 backgroundColor: Palette.appTheme,
//                 backgroundImage: AssetImage(
//                   'assets/images/manji.jpeg',
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:dil_hack_e_commerce/constants/baseUrl.dart';
import 'package:dil_hack_e_commerce/core/theme/palette.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/UserProfile/user_bloc.dart';
import 'package:dil_hack_e_commerce/features/auth/bloc/UserProfile/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TopRow extends StatelessWidget {
  const TopRow({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const userImage = AppConstants.USER_IMG;

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        String username = '';
        String? userImg;

        if (state is ProfileLoaded) {
          username = state.profile.username;
          userImg = state.profile.userImg;
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Image.asset(
                'assets/images/logo-2.png',
                height: 35,
                color: Colors.black,
              ),
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome 👋',
                      style: GoogleFonts.aBeeZee(
                        fontSize: screenSize.width * 0.04,
                      ),
                    ),
                    Text(
                      username,
                      style: GoogleFonts.aBeeZee(
                        fontSize: screenSize.width * 0.04,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    // Handle profile click here, if needed
                  },
                  child: CircleAvatar(
                    radius: screenSize.width * 0.05,
                    backgroundColor: Palette.appTheme,
                    backgroundImage: userImg != null
                        ? NetworkImage(
                            'http://192.168.1.32:8000/userImg/$userImg', // Use NetworkImage for URLs
                          )
                        : const AssetImage(
                            'assets/images/manji.jpeg', // Local asset fallback
                          ) as ImageProvider, // Cast to ImageProvider to avoid type error
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
