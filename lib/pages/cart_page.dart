import 'package:ecom_app/class/provider_class.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Page"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Consumer<ProductProvider>(
              builder: (context, productProvider, _) {
                return Text("Total Products: ${productProvider.totalProducts}");
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Consumer<ProductProvider>(
              builder: (context, productProvider, _) {
                return Text("Total Price: ${productProvider.totalPrice}");
              },
            ),
          ),
          Expanded(
              flex: 12,
              child: ListView.builder(
                  itemCount:
                      Provider.of<ProductProvider>(context).totalProducts,
                  itemBuilder: (context, i) {
                    return Card(
                      elevation: 3,
                      child: Consumer<ProductProvider>(
                        builder: (context, productProvider, _) {
                          return ListTile(
                            leading: Text("${productProvider.products[i].id}"),
                            title: Text("${productProvider.products[i].name}"),
                            subtitle: Text(
                                "Rs. ${productProvider.products[i].price}"),
                            trailing: IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .removeProduct(
                                        data: productProvider.products[i]);
                              },
                            ),
                          );
                        },
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
