import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/theme.dart';
import '../product/product_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var searchCategory = '';
  TextEditingController searchCategoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackground,
      appBar: AppBar(
        backgroundColor: const Color(0xFFA8CB26),
        title: Text(
          'Banana Keraton',
          style: GoogleFonts.outfit(color: secondaryBackground),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 250, 0),
              width: MediaQuery.of(context).size.width,
              height: 57,
              decoration: BoxDecoration(
                color: secondaryBackground,
              ),
              child: Text(
                'Kategori',
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
                      searchCategory = value;
                    });
                  },
                  controller: searchCategoryController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w500),
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: IconButton(
                          onPressed: () {
                            searchCategoryController.clear();
                            setState(() {
                              searchCategory = '';
                            });
                          },
                          icon: const Icon(
                            Icons.clear_rounded,
                            size: 18,
                          ))),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('categories')
                    .orderBy('categoryLowerCase')
                    .startAt([searchCategory.toLowerCase()]).endAt(
                        ['$searchCategory\uf8ff']).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  final categories = snapshot.data!.docs;
                  if (categories.isEmpty) {
                    return const Center(
                      child: Text('Tidak ada kategori'),
                    );
                  }
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: secondaryBackground,
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, index) {
                          final category =
                              categories[index].data() as Map<String, dynamic>;
                          return InkWell(
                            onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProductScreen(
                                selectedCategoryName: category['name'],
                              );
                            })),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.4,
                              decoration: BoxDecoration(
                                color: const Color(0xFFA8CB26),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.network(
                                      category['imgUrl'],
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.135,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4, left: 8, right: 8),
                                    child: Text(
                                      category['name'],
                                      style: GoogleFonts.readexPro(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: secondaryBackground,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Text(
                                      'Stok Tersedia',
                                      style: GoogleFonts.readexPro(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: primaryText,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
