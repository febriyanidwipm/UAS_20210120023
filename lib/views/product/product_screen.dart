import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:uaskelompok_pam/views/product/detail_product_screen.dart';

import '../../constant/theme.dart';

class ProductScreen extends StatefulWidget {
  final String selectedCategoryName;
  const ProductScreen({super.key, required this.selectedCategoryName});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var searchProduct = '';
  TextEditingController searchProductController = TextEditingController();
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
              width: MediaQuery.of(context).size.width,
              height: 57,
              decoration: BoxDecoration(
                color: secondaryBackground,
              ),
              child: Text(
                widget.selectedCategoryName,
                style: GoogleFonts.readexPro(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 0,
                        offset: const Offset(0, 1),
                        color: secondaryText),
                  ],
                  borderRadius: BorderRadius.circular(8),
                  color: secondaryBackground,
                ),
                height: 40,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchProduct = value;
                    });
                  },
                  controller: searchProductController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w500),
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: IconButton(
                          onPressed: () {
                            searchProductController.clear();
                            setState(() {
                              searchProduct = '';
                            });
                          },
                          icon: const Icon(
                            Icons.clear_rounded,
                            size: 18,
                          ))),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .where('categoryName',
                          isEqualTo: widget.selectedCategoryName)
                      .orderBy('nameLowercase')
                      .startAt([searchProduct]).endAt(
                          ['$searchProduct\uf8ff']).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }

                    var documents = snapshot.data!.docs;
                    if (documents.isEmpty) {
                      return const Center(
                        child: Text('Tidak ada produk'),
                      );
                    }
                    return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (BuildContext context, index) {
                          // var product =
                          //     documents[index].data() as Map<String, dynamic>;

                          // get doc id to delete data
                          DocumentSnapshot product = documents[index];
                          // String docID = product.id;
                          return Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 30, 20, 0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return DetailProductScreen(
                                    product: product,
                                  );
                                }));
                              },
                              child: Container(
                                width: 414,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEE10B),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        product['imgUrl'],
                                        width: 124,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(10, 10, 0, 0),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${product['name']}',
                                                    style: bodyMedium,
                                                  ),
                                                  Text(
                                                    'Topping ${product['topping']}',
                                                    style: bodyMedium,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(10, 10, 0, 0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                    color: accentColor4,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: const Iconify(
                                                    Ic.round_minus),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              const Text('1'),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Container(
                                                height: 20,
                                                width: 20,
                                                decoration: BoxDecoration(
                                                    color: accentColor4,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: const Iconify(
                                                    Ic.round_plus),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
