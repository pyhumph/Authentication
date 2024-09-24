import 'package:authentication/models/cart.dart';
import 'package:authentication/models/shoe.dart';
import 'package:authentication/pages/cart_page.dart';
import 'package:authentication/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoeDetailsPage extends StatefulWidget {
  final Shoe shoe;

  const ShoeDetailsPage({Key? key, required this.shoe}) : super(key: key);

  @override
  _ShoeDetailsPageState createState() => _ShoeDetailsPageState();
}

class _ShoeDetailsPageState extends State<ShoeDetailsPage> {
  String? selectedSize;
  final List<String> sizes = ['6', '7', '8', '9', '10', '11']; // Available sizes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/back1.jpeg', 
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
                Card(
                  color: const Color.fromARGB(239, 18, 19, 19),
                  elevation: 10,
                  shadowColor: const Color.fromARGB(239, 56, 229, 241),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Image.asset(
                          widget.shoe.imagePath,
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.shoe.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                 color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '\$${widget.shoe.price.toString()}',
                              style: const TextStyle(
                                fontSize: 20,
                                color:  Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Shoe size selection
                const Text(
                  'Select Size:',
                  style: TextStyle(fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButton<String>(
                  iconDisabledColor: Colors.amberAccent,
                  dropdownColor: Colors.black,
                  value: selectedSize,
                  hint: const Text('Choose a size',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  ),
                  items: sizes.map((size) {
                    return DropdownMenuItem<String>(
                      value: size,
                      child: Text(size,
                      style: const TextStyle(color: Colors.white,),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSize = value; // Update the selected size
                    });
                  },
                ),
                const SizedBox(height: 20),
                // Center the Add to Cart button
                Center(
                  child: ElevatedButton(
                    onPressed: selectedSize == null
                        ? null
                        : () {
                            Provider.of<Cart>(context, listen: false)
                                .addItemToCart(widget.shoe, selectedSize!);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      '${widget.shoe.name} (Size: $selectedSize) added to cart')),
                            );
                          },
                    child: const Text('Add to Cart'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // Adding bottom bar with cart icon
      bottomNavigationBar: BottomAppBar(
  color: const Color.fromARGB(255, 0, 0, 0),
  shape: const CircularNotchedRectangle(),
  notchMargin: 6.0,
  child: Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      IconButton(
        icon: const Icon(
          Icons.home,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) => HomePage())));
        },
      ),
      GestureDetector(
        onTap: selectedSize == null
            ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('select shoe size')),
                );
              }
            : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()),
                );
              },
        child: Icon(
          Icons.shopping_cart,
          color: selectedSize == null ? Colors.grey : Colors.white,
        ),
      ),
    ],
  ),
),
);
}
}
