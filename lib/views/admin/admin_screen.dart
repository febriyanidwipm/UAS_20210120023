import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uaskelompok_pam/views/product/create_product_screen.dart';

import '../../constant/theme.dart';
import '../../services/firestore_services.dart';
import '../product/detail_product_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final formKey = GlobalKey<FormState>();
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
            title: const Text('Admin Area'),
            backgroundColor: secondaryBackground,
            elevation: 0,
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const CreateProductScreen();
          }));
        },
        backgroundColor: const Color(0xFFA8CB26),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
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
                  DocumentSnapshot product = documents[index];
                  String docID = product.id;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailProductScreen(
                            product: product,
                          );
                        }));
                      },
                      leading: SizedBox(
                        width: 75,
                        height: 50,
                        child: Image.network(
                          product['imgUrl'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        product['name'],
                        style: GoogleFonts.outfit(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Topping ${product['topping']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                final TextEditingController nameController =
                                    TextEditingController(
                                        text: product['name']);
                                final TextEditingController descController =
                                    TextEditingController(
                                        text: product['desc']);
                                final TextEditingController priceController =
                                    TextEditingController(
                                        text: product['price']);
                                final TextEditingController imageController =
                                    TextEditingController(
                                        text: product['imgUrl']);
                                final TextEditingController categoryController =
                                    TextEditingController(
                                        text: product['categoryName']);
                                final TextEditingController toppingController =
                                    TextEditingController(
                                        text: product['topping']);
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return SingleChildScrollView(
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.9,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Form(
                                                key: formKey,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        'Edit Produk',
                                                        style:
                                                            GoogleFonts.outfit(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    Text(
                                                      'Nama Produk',
                                                      style: GoogleFonts.outfit(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          nameController,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  'Masukkan Nama Produk'),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      'Deskripsi Produk',
                                                      style: GoogleFonts.outfit(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          descController,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  'Masukkan Deskripsi Produk'),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      'Harga Produk',
                                                      style: GoogleFonts.outfit(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller:
                                                          priceController,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  'Masukkan Harga Produk'),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      'Link Gambar Produk',
                                                      style: GoogleFonts.outfit(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          imageController,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  'Masukkan Link Gambar Produk'),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      'Kategori Produk',
                                                      style: GoogleFonts.outfit(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          categoryController,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  'Masukkan Kategori Produk'),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      'Topping Produk',
                                                      style: GoogleFonts.outfit(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          toppingController,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  'Masukkan Topping Produk'),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      const Color(
                                                                          0xFFA8CB26)),
                                                          onPressed: () async {
                                                            if (formKey
                                                                .currentState!
                                                                .validate()) {
                                                              try {
                                                                await FirestoreServices().updateProduct(
                                                                    docID,
                                                                    descController
                                                                        .text,
                                                                    nameController
                                                                        .text,
                                                                    nameController
                                                                        .text
                                                                        .toLowerCase(),
                                                                    toppingController
                                                                        .text,
                                                                    priceController
                                                                        .text,
                                                                    imageController
                                                                        .text,
                                                                    categoryController
                                                                        .text);
                                                                if (context
                                                                    .mounted) {
                                                                  Navigator.pop(
                                                                      context);
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    const SnackBar(
                                                                      content: Text(
                                                                          'Success Edit Product'),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .green,
                                                                    ),
                                                                  );
                                                                }
                                                              } catch (e) {
                                                                if (context
                                                                    .mounted) {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    const SnackBar(
                                                                      content: Text(
                                                                          'Error occurred. Please try again.'),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                    ),
                                                                  );
                                                                }
                                                              }
                                                            }
                                                          },
                                                          child: Text(
                                                            'Edit',
                                                            style: GoogleFonts.outfit(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    secondaryBackground),
                                                          )),
                                                    )
                                                  ],
                                                )),
                                          ),
                                        ),
                                      );
                                    });
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () =>
                                  FirestoreServices().deleteProduct(docID),
                              icon: const Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
