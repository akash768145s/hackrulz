import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// provider: ^6.1.1
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ECommercePage(),
      ),
    ),
  );
}

// 🛒 Provider for Cart Logic
class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  int get count => _items.length;

  void add(Map<String, dynamic> product) {
    _items.add(product);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

// 🏪 Main Page
class ECommercePage extends StatelessWidget {
  const ECommercePage({super.key});

  final List<Map<String, dynamic>> products = const [
    {"name": "Wireless Headphones", "price": 59.99},
    {"name": "Smart Watch", "price": 120.00},
    {"name": "Gaming Mouse", "price": 39.49},
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mini E-Commerce"),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  _showCartDialog(context, cart);
                },
              ),
              if (cart.count > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Text(
                      cart.count.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            elevation: 2,
            child: ListTile(
              title: Text(product["name"]),
              subtitle: Text("\$${product["price"]}"),
              trailing: ElevatedButton(
                onPressed: () {
                  cart.add(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Added to cart")),
                  );
                },
                child: const Text("Add to Cart"),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showCartDialog(BuildContext context, CartProvider cart) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(
              title: Text("Your Cart",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            if (cart.items.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Cart is empty"),
              )
            else
              ...cart.items.map((item) => ListTile(
                    title: Text(item["name"]),
                    subtitle: Text("\$${item["price"]}"),
                  )),
            const Divider(),
            TextButton.icon(
              onPressed: () {
                cart.clear();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete),
              label: const Text("Clear Cart"),
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}


// ChangeNotifierProvider (CartProvider)
// └── MaterialApp
//     └── ECommercePage (StatelessWidget)
//         └── Scaffold
//             ├── AppBar
//             │   ├── Text ("Mini E-Commerce")
//             │   └── Stack (Cart Icon with Counter)
//             │       ├── IconButton (Cart)
//             │       └── if cart.count > 0
//             │           └── Positioned
//             │               └── Container (Red Badge with Count)
//             └── ListView.builder
//                 └── Card (for each product)
//                     └── ListTile
//                         ├── Text (Product name)
//                         ├── Text (Price)
//                         └── ElevatedButton ("Add to Cart")
//                             └── onPressed → cart.add(product)

// Modal Bottom Sheet (Cart View - _showCartDialog)
// └── Column
//     ├── ListTile (Title: "Your Cart")
//     ├── if cart empty
//     │   └── Padding → Text ("Cart is empty")
//     ├── else
//     │   └── ListTile (for each item in cart)
//     │       ├── Text (Product name)
//     │       └── Text (Price)
//     ├── Divider
//     └── TextButton.icon ("Clear Cart")
