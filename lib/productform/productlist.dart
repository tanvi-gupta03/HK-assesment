import 'package:assesment/productform/productprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ProductListPage extends StatelessWidget {
  final String searchQuery;

  ProductListPage({required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context).products;
    final filteredProducts = products.where((product) {
      return product.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: filteredProducts.map((product) {
          return SizedBox(
            width: MediaQuery.of(context).size.width / 3 - 16,
      child: Card(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Stack(
          children: [
          Image.network(product.imagePath, fit: BoxFit.cover, width: double.infinity, height: 300),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
            icon: Icon(Icons.delete_outline_sharp, color: Colors.black),
              onPressed: () {
                Provider.of<ProductProvider>(context, listen: false).removeProduct(products.indexOf(product));
              },
            ),
                ),
              ],
            ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<ProductProvider>(context, listen: false).addToCart(product);
                      },
                      child: Text('Add to Cart'),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}



