import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:uaskelompok_pam/views/auth/login_screen.dart';
import 'package:uaskelompok_pam/views/navbar/navbar_screen.dart';

import '../../constant/theme.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection('users');

  void signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const LoginScreen();
    }));
  }

  Future<void> editField(String field) async {
    String newValue = '';
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Edit $field",
            style: GoogleFonts.readexPro(
                fontSize: 21, fontWeight: FontWeight.w600, color: primaryText),
          ),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Enter new $field',
            ),
            onChanged: (value) {
              newValue = value;
            },
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.readexPro(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryText),
                )),
            TextButton(
                onPressed: () => Navigator.of(context).pop(newValue),
                child: Text(
                  'Save',
                  style: GoogleFonts.readexPro(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor),
                )),
          ],
        );
      },
    );
    if (newValue.trim().isNotEmpty) {
      await userCollection.doc(currentUser.uid).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: AppBar(
            title: const Text('Profile'),
            backgroundColor: secondaryBackground,
            leading: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const NavbarScreen();
                  }));
                },
                icon: const Icon(Icons.arrow_back)),
            elevation: 0,
          ),
        ),
      ),
      backgroundColor: secondaryBackground,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 395,
                height: 186,
                decoration: BoxDecoration(
                  color: secondaryBackground,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(130, 0, 0, 0),
                      child: Container(
                        width: 140,
                        height: 140,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://picsum.photos/seed/682/600',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(currentUser.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final userData =
                          snapshot.data!.data() as Map<String, dynamic>;

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, right: 20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFEE10B)),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return EditProfileScreen(
                                    userData: snapshot.data!,
                                  );
                                }));
                              },
                              child: Text(
                                'Edit Profile',
                                style: GoogleFonts.readexPro(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryText),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 20, 20, 0),
                            child: Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEE10B),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Nama',
                                            style: GoogleFonts.readexPro(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: secondaryText),
                                          ),
                                          Text(
                                            userData['username'],
                                            style: GoogleFonts.readexPro(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: primaryText),
                                          )
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          editField('username');
                                        },
                                        icon: Icon(
                                          Icons.arrow_forward_ios_sharp,
                                          color: primaryText,
                                          size: 24,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 20, 20, 0),
                            child: Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEE10B),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Email',
                                            style: GoogleFonts.readexPro(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: secondaryText),
                                          ),
                                          Text(
                                            userData['email'],
                                            style: GoogleFonts.readexPro(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: primaryText),
                                          )
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          editField('email');
                                        },
                                        icon: Icon(
                                          Icons.arrow_forward_ios_sharp,
                                          color: primaryText,
                                          size: 24,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 20, 20, 0),
                            child: Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEE10B),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Alamat',
                                            style: GoogleFonts.readexPro(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: secondaryText),
                                          ),
                                          Text(
                                            userData['address'],
                                            style: GoogleFonts.readexPro(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: primaryText),
                                          )
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          editField('address');
                                        },
                                        icon: Icon(
                                          Icons.arrow_forward_ios_sharp,
                                          color: primaryText,
                                          size: 24,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error${snapshot.error}');
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFA8CB26),
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    onPressed: signOut,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Logout',
                          style: GoogleFonts.readexPro(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: secondaryBackground),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Iconify(
                          Ic.twotone_logout,
                          color: secondaryBackground,
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
