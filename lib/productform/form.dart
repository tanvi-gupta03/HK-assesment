import 'package:assesment/model/productmodel.dart';
import 'package:assesment/productform/productprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProductFormPage extends StatefulWidget {
  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _addProduct() {
    if (_formKey.currentState!.validate()) {
      final productProvider = Provider.of<ProductProvider>(context, listen: false);
      final newProductName = _nameController.text;
      final isDuplicate = productProvider.products.any((product) => product.name.toLowerCase() == newProductName.toLowerCase());

      if (isDuplicate) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product already exists')),
        );
      } else {
        final product = Product(
          name: newProductName,
          price: double.parse(_priceController.text),
          imagePath: _imageUrlController.text,
        );
        Provider.of<ProductProvider>(context, listen: false).addProduct(product);
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40 ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Product Name',
                 border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              
            ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),SizedBox(height: 10),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Product Price',
                   border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              
            ),
                  ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),SizedBox(height: 10),
              TextFormField(
                controller: _imageUrlController,
                decoration: InputDecoration(labelText: 'Product Image URL',
                 border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              
            ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product image URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 200,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        elevation: 5,
                        shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    
                    ),
                      ),
                  onPressed: _addProduct,
                  child: Text('Add Product'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
