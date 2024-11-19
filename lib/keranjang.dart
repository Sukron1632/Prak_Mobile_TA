import 'package:flutter/material.dart';
import 'package:online_shop/checkout_provider.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class KeranjangScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: cart.cartItems.isEmpty
          ? const Center(child: Text('Keranjang Anda kosong'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.cartItems.length,
                    itemBuilder: (context, index) {
                      final product = cart.cartItems[index];
                      return ListTile(
                        leading: Image.network(
                          product.images.isNotEmpty
                              ? product.images[0]
                              : 'https://via.placeholder.com/150',
                          width: 50,
                          height: 50,
                        ),
                        title: Text(product.title),
                        subtitle: Text('Price: \$${product.price.toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            cart.removeFromCart(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${product.title} removed from cart!')),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${cart.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
  onPressed: () {
    final productNames = cart.cartItems.map((item) => item.title).toList();
    final totalPrice = cart.totalPrice;

    // Simpan sesi checkout
    Provider.of<CheckoutProvider>(context, listen: false).addCheckoutSession(productNames, totalPrice);
    
    cart.clearCart();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Checkout successful!')),
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
  ),
  child: const Text(
    'Checkout',
    style: TextStyle(color: Colors.white),
  ),
),
              ],
            ),
    );
  }
}
