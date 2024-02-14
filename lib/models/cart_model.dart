class CartItem {
  final String name;
  final String topping;
  final double price;
  final int quantity;
  final String image;

  CartItem({
    required this.name,
    required this.topping,
    required this.price,
    required this.quantity,
    required this.image,
  });

  // Metode untuk mengonversi objek ke Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'topping': topping,
      'price': price,
      'quantity': quantity,
      'image': image,
    };
  }

  // Metode untuk mengonversi Map menjadi objek CartItem
  static CartItem fromMap(Map<String, dynamic> map) {
    return CartItem(
      name: map['name'],
      topping: map['topping'],
      price: map['price'],
      quantity: map['quantity'],
      image: map['image'],
    );
  }
}
