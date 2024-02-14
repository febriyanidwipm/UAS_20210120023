import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/cart_model.dart';

class FirestoreServices {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  Future<void> addProduct(String name, String nameLowercase, String desc,
      String topping, String price, String imgUrl, String categoryName) {
    return products.add({
      'name': name,
      'nameLowercase': nameLowercase,
      'desc': desc,
      'topping': topping,
      'price': price,
      'imgUrl': imgUrl,
      'categoryName': categoryName,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getProductStream(categoryName) {
    final productsStream =
        products.orderBy(categoryName, descending: true).snapshots();

    return productsStream;
  }

  Future<void> updateProduct(
      String docID,
      String newDesc,
      String newProduct,
      String newProductLowercase,
      String newTopping,
      String newPrice,
      String imgUrl,
      String newCategoryName) {
    return products.doc(docID).update({
      'name': newProduct,
      'nameLowercase': newProductLowercase,
      'desc': newDesc,
      'topping': newTopping,
      'price': newPrice,
      'imgUrl': imgUrl,
      'categoryName': newCategoryName,
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> deleteProduct(String docID) {
    return products.doc(docID).delete();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addToCart({
    required String userId,
    required String productId,
    required String name,
    required String topping,
    required String price,
    required int quantity,
    required String image,
  }) async {
    try {
      // Calculate totalPrice by multiplying price and quantity
      double totalPrice = double.parse(price) * quantity;

      // Check if the product already exists in the user's cart
      var cartItemDoc = await _firestore
          .collection('carts')
          .doc(userId)
          .collection('cartItems')
          .doc(productId)
          .get();

      if (cartItemDoc.exists) {
        // If the product already exists, update the quantity and totalPrice
        await _firestore
            .collection('carts')
            .doc(userId)
            .collection('cartItems')
            .doc(productId)
            .update({
          'quantity': FieldValue.increment(quantity),
          'totalPrice': FieldValue.increment(totalPrice),
        });
      } else {
        // If the product doesn't exist, add it to the cart with totalPrice and status
        await _firestore
            .collection('carts')
            .doc(userId)
            .collection('cartItems')
            .doc(productId)
            .set({
          'name': name,
          'topping': topping,
          'price': price,
          'quantity': quantity,
          'image': image,
          'totalPrice': totalPrice,
          'status': 'in-cart',
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CartItem>> getCartItems(String userId) async {
    try {
      var cartItemsQuery = await _firestore
          .collection('carts')
          .doc(userId)
          .collection('cartItems')
          .get();

      List<CartItem> cartItems = [];

      for (var cartItemDoc in cartItemsQuery.docs) {
        var data = cartItemDoc.data();
        cartItems.add(CartItem.fromMap(data));
      }

      return cartItems;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteItemCart(String userId, String itemId) async {
    try {
      await _firestore
          .collection('carts')
          .doc(userId)
          .collection('cartItems')
          .doc(itemId)
          .delete();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> incrementQuantity({
    required String userId,
    required String productId,
    required int quantity,
    required double itemPrice,
  }) async {
    try {
      double itemTotalPrice = itemPrice * quantity;

      await _firestore
          .collection('carts')
          .doc(userId)
          .collection('cartItems')
          .doc(productId)
          .update({
        'quantity': FieldValue.increment(1),
        'totalPrice': FieldValue.increment(itemTotalPrice),
      });

      await _firestore.collection('carts').doc(userId).update({
        'totalPrice': FieldValue.increment(itemPrice),
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> decrementQuantity({
    required String userId,
    required String productId,
    required int quantity,
    required double itemPrice,
  }) async {
    try {
      // Pastikan quantity tidak berkurang di bawah 1
      if (quantity > 1) {
        double itemTotalPrice = itemPrice * (quantity - 1);

        await _firestore
            .collection('carts')
            .doc(userId)
            .collection('cartItems')
            .doc(productId)
            .update({
          'quantity': FieldValue.increment(-1),
          'totalPrice': itemTotalPrice,
        });

        await _firestore.collection('carts').doc(userId).update({
          'totalPrice': FieldValue.increment(-itemPrice),
        });
      } else {
        // Jika quantity menjadi 0, hapus item dari keranjang
        await deleteItemCart(userId, productId);
      }
    } catch (e) {
      rethrow;
    }
  }
}
