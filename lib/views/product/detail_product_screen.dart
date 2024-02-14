// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uaskelompok_pam/services/firestore_services.dart';
import 'package:uaskelompok_pam/views/cart/cart_screen.dart';

import '../../constant/theme.dart';

class DetailProductScreen extends StatefulWidget {
  final DocumentSnapshot product;
  const DetailProductScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
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
              width: 393,
              height: 282,
              decoration: BoxDecoration(
                color: secondaryBackground,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.network(
                  widget.product['imgUrl'],
                  width: 300,
                  height: 293,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.product['name']}\nTopping ${widget.product['topping']}',
                    style: GoogleFonts.readexPro(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Rp. ${widget.product['price']}',
                    style: GoogleFonts.readexPro(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                  child: Icon(
                    Icons.star,
                    color: Color(0xFFFEE10B),
                    size: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(5, 8, 0, 0),
                  child: Text(
                    '4.9/5',
                    style: bodyMedium,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: Container(
                width: 409,
                height: 190,
                decoration: BoxDecoration(
                  color: secondaryBackground,
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  child: Text(
                    widget.product['desc'],
                    style: GoogleFonts.readexPro(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16, 80, 16, 0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          FirebaseAuth auth = FirebaseAuth.instance;
                          User? userId = auth.currentUser;
                          if (userId != null) {
                            var productId = widget.product
                                .id; // Replace 'id' with the actual field name
                            var name = widget.product[
                                'name']; // Replace 'name' with the actual field name
                            var topping = widget.product[
                                'topping']; // Replace 'topping' with the actual field name
                            var price = widget.product[
                                'price']; // Replace 'price' with the actual field name
                            var quantity =
                                1; // You can set the initial quantity as needed
                            var image = widget.product[
                                'imgUrl']; // Replace 'image' with the actual field name

                            try {
                              FirestoreServices().addToCart(
                                userId: userId.uid,
                                productId: productId,
                                name: name,
                                topping: topping,
                                price: price,
                                quantity: quantity,
                                image: image,
                              );
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return const CartScreen();
                              }));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Success Add to Cart'),
                                backgroundColor: Colors.green,
                              ));
                            } catch (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Failed Add to Cart'),
                                backgroundColor: Colors.red,
                              ));
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFEE10B),
                            textStyle: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(50),
                            )),
                        child: const Text('Pilih'),
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
  }
}
