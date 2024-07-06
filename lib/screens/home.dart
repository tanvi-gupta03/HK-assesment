
import 'package:assesment/productform/form.dart';
import 'package:assesment/screens/login.dart';
import 'package:assesment/productform/productlist.dart';
import 'package:assesment/productform/productprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _searchQuery = '';
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {

            _showLogoutDialog();
          },
          child: Icon(Icons.arrow_back_ios, size: 25),
        ),
        title: _isSearching
            ? TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  labelText: 'Search...',
                  suffixIconColor: Colors.black,
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.black, fontSize: 16.0),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                onSubmitted: (value) {
                  setState(() {
                    _isSearching = false;
                  });
                },
              )
            : Text(''),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search, color: Colors.black,size: 25),
            style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                _searchQuery = '';
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Text(
                "Hi-Fi Shop & Service",
                style: TextStyle(
                  color: const Color.fromRGBO(0, 0, 0, 1),
                  fontWeight: FontWeight.w700,
                  fontSize: 35,
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Audio shop on Rustaveli Ave 57.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "This shop offers both products and services.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Products",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                    "41",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 30,
                    ),
                  ),
                    ],
                    
                  ),
                  Text(
                    "Show all products",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ProductListPage(searchQuery: _searchQuery),
              if (_searchQuery.isNotEmpty)
                SearchSuggestions(searchQuery: _searchQuery),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductFormPage()),
          );
        },
        child: Icon(Icons.add, size: 25),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are You Sure, You want to LogOut?'),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Provider.of<ProductProvider>(context, listen: false).logout(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class SearchSuggestions extends StatelessWidget {
  final String searchQuery;

  SearchSuggestions({required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context).products;
    final filteredProducts = products.where((product) {
      return product.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Container(
      color: Colors.white,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          final product = filteredProducts[index];
          return ListTile(
            title: Text(product.name),
          );
        },
      ),
    );
  }
}
