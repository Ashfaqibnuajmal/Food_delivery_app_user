import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mera_app/core/theme/app_color.dart';
import 'package:mera_app/features/auth/bloc/auth_bloc_bloc.dart';
import 'package:mera_app/features/profile/screens/chat/chat_and_support.dart';
import 'package:mera_app/features/profile/screens/order/order_history.dart';
import 'package:mera_app/features/profile/screens/settings/settings.dart';

class ProfileScreens extends StatefulWidget {
  const ProfileScreens({super.key});

  @override
  State<ProfileScreens> createState() => _ProfileScreensState();
}

class _ProfileScreensState extends State<ProfileScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // Profile Image Placeholder
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt,
                    size: 30,
                    color: Colors.grey[700],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Name
            const Text(
              'Ashfaq',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'ashfakv21-@gmail.com',
              style: TextStyle(color: Colors.grey),
            ),
            const Text(
              '9846100721',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),

            // Edit Profile Button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: const Text(
                "Edit Profile",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: 15),

            // Divider with shadow
            Container(
              height: 1,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            // Options directly as Cards
            Card(
              color: Colors.white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrderHistory()));
                },
                child: const ListTile(
                  leading: Icon(Icons.receipt_long, color: Colors.black),
                  title: Text(
                    "Order history",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                ),
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatAndSupport()));
                },
                child: const ListTile(
                  leading: Icon(Icons.call, color: Colors.black),
                  title: Text(
                    "Chat with us",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                ),
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Settings()));
                },
                child: const ListTile(
                  leading: Icon(Icons.settings, color: Colors.black),
                  title: Text(
                    "Settings",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                ),
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () {
                  showThemeBottomSheet(context);
                },
                child: const ListTile(
                  leading: Icon(Icons.brightness_6, color: Colors.black),
                  title: Text(
                    "Theme",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                ),
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Question mark icon in red circle
                              Container(
                                width: 56,
                                height: 56,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE53E3E),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.question_mark,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Title
                              const Text(
                                'Logout',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Message
                              const Text(
                                'Are you sure you want to Logout?',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),

                              // Buttons
                              Row(
                                children: [
                                  // NO button
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFFE5E5E5),
                                        foregroundColor: Colors.black87,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text(
                                        'NO',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),

                                  // YES button
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<AuthBlocBloc>()
                                            .add(LogoutEvent());
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFFE53E3E),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: const Text(
                                        'YES',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const ListTile(
                  leading: Icon(Icons.logout, color: Colors.black),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void showThemeBottomSheet(BuildContext context) {
  String selectedTheme = "dark";

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Appearance",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                Container(
                  height: 1,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Dark Mode
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Dark Mode",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Radio<String>(
                      value: "dark",
                      groupValue: selectedTheme,
                      activeColor: AppColors.primaryOrange,
                      onChanged: (value) {
                        setState(() => selectedTheme = value!);
                      },
                    ),
                  ],
                ),

                // Light Mode
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Light Mode",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Radio<String>(
                      value: "light",
                      groupValue: selectedTheme,
                      activeColor: AppColors.primaryOrange,
                      onChanged: (value) {
                        setState(() => selectedTheme = value!);
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryOrange,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Save",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
// import 'package:flutter/material.dart';
// import 'package:inde_app/core/theme/app_color.dart';
// import 'package:inde_app/features/profile/screens/chat/chat_and_support.dart';
// import 'package:inde_app/features/profile/screens/order/order_history.dart';
// import 'package:inde_app/features/profile/screens/settings/settings.dart';

// class ProfileScreens extends StatefulWidget {
//   const ProfileScreens({super.key});

//   @override
//   State<ProfileScreens> createState() => _ProfileScreensState();
// }

// class _ProfileScreensState extends State<ProfileScreens> {
//   // App-level selected theme (just stored locally here)
//   String _selectedTheme = "dark";

//   void _showThemeBottomSheet() {
//     String tempTheme = _selectedTheme;

//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (ctx) {
//         return StatefulBuilder(
//           builder: (context, setModalState) {
//             return Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Appearance",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Container(
//                     height: 1,
//                     decoration: BoxDecoration(
//                       color: Colors.grey.withOpacity(0.3),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.3),
//                           blurRadius: 5,
//                           offset: const Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 12),

//                   // Dark Mode
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Dark Mode",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       Radio<String>(
//                         value: "dark",
//                         groupValue: tempTheme,
//                         activeColor: AppColors.primaryOrange,
//                         onChanged: (value) {
//                           setModalState(() => tempTheme = value!);
//                         },
//                       ),
//                     ],
//                   ),

//                   // Light Mode
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Light Mode",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       Radio<String>(
//                         value: "light",
//                         groupValue: tempTheme,
//                         activeColor: AppColors.primaryOrange,
//                         onChanged: (value) {
//                           setModalState(() => tempTheme = value!);
//                         },
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 16),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.primaryOrange,
//                           foregroundColor: Colors.black,
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         onPressed: () {
//                           // Commit the selection and close
//                           setState(() => _selectedTheme = tempTheme);
//                           Navigator.pop(context);
//                         },
//                         child: const Text(
//                           "Save",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: const Text(
//           'Profile',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.notifications_none, color: Colors.black),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(15),
//           child: Column(
//             children: [
//               // Profile Image Placeholder
//               Container(
//                 width: 100,
//                 height: 100,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.grey[300],
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 6,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child:
//                     Icon(Icons.camera_alt, size: 30, color: Colors.grey[700]),
//               ),
//               const SizedBox(height: 10),

//               // Name / Email / Phone
//               const Text(
//                 'Ashfaq',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const Text('ashfakv21-@gmail.com',
//                   style: TextStyle(color: Colors.grey)),
//               const Text('9846100721', style: TextStyle(color: Colors.grey)),
//               const SizedBox(height: 10),

//               // Edit Profile Button
//               ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.orange,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//                 ),
//                 child: const Text(
//                   "Edit Profile",
//                   style: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.w800),
//                 ),
//               ),
//               const SizedBox(height: 15),

//               // Divider with shadow
//               Container(
//                 height: 1,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.withOpacity(0.3),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.3),
//                       blurRadius: 5,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 15),

//               // ---- Options as Cards ----
//               Card(
//                 color: Colors.white,
//                 elevation: 1,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 margin: const EdgeInsets.only(bottom: 12),
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const OrderHistory()),
//                     );
//                   },
//                   child: const ListTile(
//                     leading: Icon(Icons.receipt_long, color: Colors.black),
//                     title: Text(
//                       "Order history",
//                       style: TextStyle(
//                           color: Colors.black, fontWeight: FontWeight.w600),
//                     ),
//                     trailing: Icon(Icons.arrow_forward_ios, size: 16),
//                   ),
//                 ),
//               ),
//               Card(
//                 color: Colors.white,
//                 elevation: 1,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 margin: const EdgeInsets.only(bottom: 12),
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const ChatAndSupport()),
//                     );
//                   },
//                   child: const ListTile(
//                     leading: Icon(Icons.call, color: Colors.black),
//                     title: Text(
//                       "Chat with us",
//                       style: TextStyle(
//                           color: Colors.black, fontWeight: FontWeight.w600),
//                     ),
//                     trailing: Icon(Icons.arrow_forward_ios, size: 16),
//                   ),
//                 ),
//               ),
//               Card(
//                 color: Colors.white,
//                 elevation: 1,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 margin: const EdgeInsets.only(bottom: 12),
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const Settings()),
//                     );
//                   },
//                   child: const ListTile(
//                     leading: Icon(Icons.settings, color: Colors.black),
//                     title: Text(
//                       "Settings",
//                       style: TextStyle(
//                           color: Colors.black, fontWeight: FontWeight.w600),
//                     ),
//                     trailing: Icon(Icons.arrow_forward_ios, size: 16),
//                   ),
//                 ),
//               ),
//               Card(
//                 color: Colors.white,
//                 elevation: 1,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 margin: const EdgeInsets.only(bottom: 12),
//                 child: InkWell(
//                   onTap: _showThemeBottomSheet,
//                   child: const ListTile(
//                     leading: Icon(Icons.brightness_6, color: Colors.black),
//                     title: Text(
//                       "Theme",
//                       style: TextStyle(
//                           color: Colors.black, fontWeight: FontWeight.w600),
//                     ),
//                     trailing: Icon(Icons.arrow_forward_ios, size: 16),
//                   ),
//                 ),
//               ),
//               Card(
//                 color: Colors.white,
//                 elevation: 1,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 margin: const EdgeInsets.only(bottom: 12),
//                 child: InkWell(
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return Dialog(
//                           backgroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(10),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 // Question mark icon in red circle
//                                 Container(
//                                   width: 56,
//                                   height: 56,
//                                   decoration: const BoxDecoration(
//                                     color: Color(0xFFE53E3E),
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: const Icon(Icons.question_mark,
//                                       color: Colors.white, size: 28),
//                                 ),
//                                 const SizedBox(height: 16),

//                                 const Text(
//                                   'Logout',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 12),

//                                 const Text(
//                                   'Are you sure you want to Logout?',
//                                   style: TextStyle(
//                                       fontSize: 16, color: Colors.black87),
//                                   textAlign: TextAlign.center,
//                                 ),
//                                 const SizedBox(height: 24),

//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: TextButton(
//                                         onPressed: () => Navigator.pop(context),
//                                         style: TextButton.styleFrom(
//                                           backgroundColor:
//                                               const Color(0xFFE5E5E5),
//                                           foregroundColor: Colors.black87,
//                                           padding: const EdgeInsets.symmetric(
//                                               vertical: 12),
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                           ),
//                                         ),
//                                         child: const Text(
//                                           'NO',
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w500),
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(width: 12),
//                                     Expanded(
//                                       child: ElevatedButton(
//                                         onPressed: () {
//                                           // TODO: implement your logout logic
//                                           Navigator.pop(context);
//                                         },
//                                         style: ElevatedButton.styleFrom(
//                                           backgroundColor:
//                                               const Color(0xFFE53E3E),
//                                           foregroundColor: Colors.white,
//                                           padding: const EdgeInsets.symmetric(
//                                               vertical: 12),
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                           ),
//                                           elevation: 0,
//                                         ),
//                                         child: const Text(
//                                           'YES',
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w500),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                   child: const ListTile(
//                     leading: Icon(Icons.logout, color: Colors.black),
//                     title: Text(
//                       "Logout",
//                       style: TextStyle(
//                           color: Colors.black, fontWeight: FontWeight.w600),
//                     ),
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
