import 'package:ecom_app/class/provider_class.dart';
import 'package:ecom_app/class/them_class.dart';
import 'package:ecom_app/pages/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'class/product_model.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ProductProvider()),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ],
    builder: (context, _) => MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.black12,
        listTileTheme: ListTileThemeData(tileColor: Colors.grey.shade400),
      ),
      themeMode: (Provider.of<ThemeProvider>(context).isDark)
          ? ThemeMode.dark
          : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => HomePage(),
        "cart_page": (context) => CartPage(),
      },
    ),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> allProducts = [
    Product(id: 1, name: 'TV', price: 23000),
    Product(id: 2, name: 'Laptop', price: 23000),
    Product(id: 3, name: 'Shampoo', price: 400),
    Product(id: 4, name: 'Watch', price: 4000),
    Product(id: 5, name: 'AC', price: 29000),
    Product(id: 6, name: 'PC', price: 60000),
    Product(id: 7, name: 'Shoes', price: 999),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.sunny),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
          ),
          centerTitle: true,
          title: const Text("E-Commerce App"),
          actions: [
            Center(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('cart_page');
                      },
                      icon: Icon(Icons.shopping_cart)),
                  Consumer<ProductProvider>(
                    builder: (context, productProvider, _) =>
                        Text("${productProvider.totalProducts}"),
                  ),
                ],
              ),
            )
          ],
        ),
        body: ListView.builder(
            itemCount: allProducts.length,
            itemBuilder: (context, i) {
              return Card(
                elevation: 3,
                child: ListTile(
                  leading: Text("${allProducts[i].id}"),
                  title: Text("${allProducts[i].name}"),
                  subtitle: Text("Rs. ${allProducts[i].price}"),
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Provider.of<ProductProvider>(context, listen: false)
                          .addProduct(data: allProducts[i]);
                    },
                  ),
                ),
              );
            }));
  }
}
