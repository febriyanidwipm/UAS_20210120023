import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uaskelompok_pam/services/firestore_services.dart';

import '../../constant/theme.dart';
import 'widgets/dropdown_options.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  String? selectedCategory;
  DropdownOption? selectedTopping;

  final List<DropdownOption> options = [
    DropdownOption('Original', 'Original'),
    DropdownOption('Strawberry', 'Strawberry'),
    DropdownOption('Blueberry', 'Blueberry'),
    DropdownOption('Coklat', 'Coklat'),
    DropdownOption('Keju', 'Keju'),
    DropdownOption('Mangga', 'Mangga'),
    DropdownOption('Durian', 'Durian'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryBackground,
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
            backgroundColor: secondaryBackground,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            elevation: 0,
          ),
        ),
      ),
      body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 10, 8, 20),
                        child: TextFormField(
                          controller: nameController,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'cannot be empty!';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Masukkan varian produk',
                            labelStyle: labelMedium,
                            hintStyle: labelMedium,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: alternateColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryText,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: errorColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: errorColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          style: bodyMedium,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 20),
                        child: TextFormField(
                          controller: descController,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'cannot be empty!';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Masukkan deskripsi',
                            labelStyle: labelMedium,
                            hintStyle: labelMedium,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: alternateColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryText,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: errorColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: errorColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          style: bodyMedium,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 20),
                        child: TextFormField(
                          controller: priceController,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'cannot be empty!';
                            }

                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Masukkan harga',
                            labelStyle: labelMedium,
                            hintStyle: labelMedium,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: alternateColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryText,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: errorColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: errorColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          style: bodyMedium,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 20),
                        child: TextFormField(
                          controller: imageController,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'cannot be empty!';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Masukkan link gambar',
                            labelStyle: labelMedium,
                            hintStyle: labelMedium,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: alternateColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: primaryText,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: errorColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: errorColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          style: bodyMedium,
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('categories')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }
                          var categoryDocs = snapshot.data!.docs;
                          List<DropdownMenuItem<String>> dropdownItems =
                              categoryDocs.map((categoryDoc) {
                            String categoryName = categoryDoc['name'];
                            return DropdownMenuItem<String>(
                              value: categoryName,
                              child: Text(categoryName),
                            );
                          }).toList();
                          return DropdownButton<String>(
                            items: dropdownItems,
                            onChanged: (String? value) {
                              setState(() {
                                selectedCategory = value;
                              });
                              debugPrint(
                                  'Selected Category: $selectedCategory');
                            },
                            hint: const Text('Select a category'),
                            value: selectedCategory,
                          );
                        },
                      ),
                      DropdownButton<DropdownOption>(
                        items: options.map((DropdownOption option) {
                          return DropdownMenuItem<DropdownOption>(
                            value: option,
                            child: Text(option.label),
                          );
                        }).toList(),
                        onChanged: (DropdownOption? value) {
                          setState(() {
                            selectedTopping = value;
                          });
                          if (value != null) {
                            debugPrint('Selected Value: ${value.value}');
                          } else {
                            debugPrint('No option selected');
                          }
                        },
                        hint: const Text('Select an option'),
                        value: selectedTopping,
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                //   child: Container(
                //     width: 363,
                //     height: 50,
                //     decoration: BoxDecoration(
                //       color: secondaryBackground,
                //       borderRadius: const BorderRadius.only(
                //         bottomLeft: Radius.circular(0),
                //         bottomRight: Radius.circular(0),
                //         topLeft: Radius.circular(0),
                //         topRight: Radius.circular(0),
                //       ),
                //     ),
                //     child: Column(
                //       mainAxisSize: MainAxisSize.max,
                //       children: [
                //         Row(
                //           mainAxisSize: MainAxisSize.max,
                //           children: [
                //             Text(
                //               'Upload gambar',
                //               style: bodyMedium,
                //             ),
                //             Row(
                //               mainAxisSize: MainAxisSize.max,
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsetsDirectional.fromSTEB(
                //                       50, 0, 0, 0),
                //                   child: IconButton(
                //                     icon: Icon(
                //                       Icons.cloud_upload_sharp,
                //                       color: primaryText,
                //                       size: 24,
                //                     ),
                //                     onPressed: () {},
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                  child: Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color: secondaryBackground,
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        final selectedToppingValue =
                            selectedTopping?.value ?? '';
                        if (formKey.currentState!.validate()) {
                          try {
                            await FirestoreServices().addProduct(
                                nameController.text,
                                nameController.text.toLowerCase(),
                                descController.text,
                                selectedToppingValue.toString(),
                                priceController.text,
                                imageController.text,
                                selectedCategory.toString());
                            if (context.mounted) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Success Add Product'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Error occurred. Please try again.'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFEE10B),
                          textStyle: GoogleFonts.readexPro(
                            color: primaryText,
                          ),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          )),
                      child: const Text('Submit'),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
