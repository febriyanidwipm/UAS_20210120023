import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:intl/intl.dart';
import 'package:uaskelompok_pam/constant/theme.dart';
import 'package:uaskelompok_pam/services/firestore_services.dart';
import 'package:uaskelompok_pam/views/navbar/navbar_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  double price = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF1F4F8),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF1F4F8),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF57636C),
              size: 24,
            ),
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const NavbarScreen();
              }));
            },
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0,
        ),
        body: Align(
            alignment: const AlignmentDirectional(0, -1),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 16),
                      child: Container(
                        constraints: const BoxConstraints(
                          maxWidth: 770,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x33000000),
                              offset: Offset(0, 2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pesananmu',
                                style: GoogleFonts.outfit(
                                  color: const Color(0xFF14181B),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 0, 0, 12),
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('carts')
                                        .doc(userId)
                                        .collection('cartItems')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      }

                                      if (!snapshot.hasData) {
                                        return const CircularProgressIndicator();
                                      }
                                      List<DocumentSnapshot> items =
                                          snapshot.data!.docs;

                                      return ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: items.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          var item = items[index];
                                          String docID = item.id;
                                          price += item['totalPrice'];
                                          return Container(
                                            width: MediaQuery.sizeOf(context)
                                                .width,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: const [
                                                BoxShadow(
                                                  blurRadius: 0,
                                                  color: Color(0xFFE0E3E7),
                                                  offset: Offset(0, 1),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 15, 0, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0, 4, 0, 12),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0, 1, 1, 1),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            child:
                                                                Image.network(
                                                              item['image'],
                                                              width: 70,
                                                              height: 70,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 3,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    8, 0, 4, 0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  item['name'],
                                                                  style:
                                                                      GoogleFonts
                                                                          .outfit(
                                                                    color: const Color(
                                                                        0xFF14181B),
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                          0,
                                                                          4,
                                                                          0,
                                                                          0),
                                                                  child:
                                                                      RichText(
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        const TextSpan(
                                                                          text:
                                                                              'Rasa : ',
                                                                          style:
                                                                              TextStyle(),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              'Topping ${item['topping']}',
                                                                          style:
                                                                              const TextStyle(),
                                                                        )
                                                                      ],
                                                                      style: GoogleFonts
                                                                          .plusJakartaSans(
                                                                        color: const Color(
                                                                            0xFF57636C),
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  8, 0, 0, 0),
                                                          child: Text(
                                                            NumberFormat
                                                                .currency(
                                                              symbol: 'Rp.',
                                                              decimalDigits: 0,
                                                            ).format(int.parse(
                                                                item['price'])),
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: GoogleFonts
                                                                .outfit(
                                                              color: const Color(
                                                                  0xFF14181B),
                                                              fontSize: 22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0, 0, 0, 12),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0, 0, 13, 0),
                                                          child: InkWell(
                                                            onTap: () async {
                                                              await FirestoreServices().decrementQuantity(
                                                                  userId:
                                                                      userId!,
                                                                  productId:
                                                                      docID,
                                                                  quantity: item[
                                                                      'quantity'],
                                                                  itemPrice: double
                                                                      .parse(item[
                                                                          'price']));
                                                            },
                                                            child: Container(
                                                              width: 20,
                                                              height: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: const Color(
                                                                    0xFFFEE10B),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        3,
                                                                        3,
                                                                        0,
                                                                        0),
                                                                child: Iconify(
                                                                  Ic.round_minus,
                                                                  color:
                                                                      secondaryText,
                                                                  size: 14,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0, 0, 10, 0),
                                                          child: Text(
                                                            item['quantity']
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .readexPro(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0, 0, 10, 0),
                                                          child: InkWell(
                                                            onTap: () async {
                                                              await FirestoreServices().incrementQuantity(
                                                                  userId:
                                                                      userId!,
                                                                  productId:
                                                                      docID,
                                                                  quantity: item[
                                                                      'quantity'],
                                                                  itemPrice: double
                                                                      .parse(item[
                                                                          'price']));
                                                            },
                                                            child: Container(
                                                              width: 19,
                                                              height: 22.22,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: const Color(
                                                                    0xFFFEE10B),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                              child: Icon(
                                                                Icons.add,
                                                                color:
                                                                    secondaryText,
                                                                size: 14,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            FirestoreServices()
                                                                .deleteItemCart(
                                                                    userId!,
                                                                    docID);
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .delete_outline,
                                                            color:
                                                                tertiaryColor,
                                                            size: 24,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 12, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'TOTAL',
                                      style: GoogleFonts.outfit(
                                        color: const Color(0xFF14181B),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Divider(
                                      height: 32,
                                      thickness: 2,
                                      color: Color(0xFFE0E3E7),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 8),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 0, 8),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Harga',
                                                  style: GoogleFonts.outfit(
                                                    color:
                                                        const Color(0xFF57636C),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                                Text(
                                                  NumberFormat.currency(
                                                          symbol: 'Rp',
                                                          decimalDigits: 0)
                                                      .format(price),
                                                  textAlign: TextAlign.end,
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    color:
                                                        const Color(0xFF14181B),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 0, 8),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Ongkos Kirim',
                                                  style: GoogleFonts.outfit(
                                                    color:
                                                        const Color(0xFF57636C),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                                Text(
                                                  NumberFormat.currency(
                                                          symbol: 'Rp',
                                                          decimalDigits: 0)
                                                      .format(10000),
                                                  textAlign: TextAlign.end,
                                                  style: GoogleFonts.outfit(
                                                    color:
                                                        const Color(0xFF14181B),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 8, 0, 8),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Text(
                                                      'Total',
                                                      style: GoogleFonts.outfit(
                                                        color: const Color(
                                                            0xFF57636C),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(
                                                        Icons.info_outlined,
                                                        color:
                                                            Color(0xFF57636C),
                                                        size: 18,
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  NumberFormat.currency(
                                                          symbol: 'Rp',
                                                          decimalDigits: 0)
                                                      .format(10000 + price),
                                                  style: GoogleFonts.outfit(
                                                    color:
                                                        const Color(0xFF14181B),
                                                    fontSize: 36,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 20, 0, 10),
                        child: Text(
                          'Pastikan sudah mengisi alamat dengan benar!',
                          style: bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  content: Container(
                                    decoration: BoxDecoration(
                                        color: secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 30,
                                        bottom: 40),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 134,
                                          width: 134,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(200),
                                              color: const Color(0xffDFEFFF)),
                                          child: Padding(
                                              padding: const EdgeInsets.all(25),
                                              child: Image.asset(
                                                  'assets/images/horaayy.png')),
                                        ),
                                        const SizedBox(height: 16.0),
                                        Text(
                                          'Your Payment Is Successful',
                                          style: GoogleFonts.raleway(
                                              fontSize: 21,
                                              fontWeight: FontWeight.w600,
                                              color: primaryText),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 16.0),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30, right: 30),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 50,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: primaryColor,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(13),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                    context, MaterialPageRoute(
                                                        builder: (context) {
                                                  return const NavbarScreen();
                                                }));
                                              },
                                              child: Text(
                                                'Back To Shopping',
                                                style: GoogleFonts.raleway(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                    color: secondaryBackground),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(0),
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
                        child: Text(
                          'Continue to Checkout',
                          style: GoogleFonts.readexPro(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: secondaryBackground),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
