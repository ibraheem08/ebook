// import 'package:flutter/material.dart';
// import 'dart:convert';

// class showcart extends StatefulWidget {
//   @override
//   _CartViewState createState() => _CartViewState();
// }

// class _CartViewState extends State<showcart> {
//   List<productsInCart> cartList = [];
//   double TotalPrice = 0.0;
//   @override
//   void initState() {
//     super.initState();
//     _loadCart();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Cart"),
//       ),
//       body: Column(
//         children: [
//           Text("Cart Items Count: ${cartList.length}"),
//           Expanded(
//             child: ListView.builder(
//               itemCount: cartList.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(
//                     cartList[index].name,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Text(cartList[index].desc.toString()),
//                   leading: Image.network(
//                     cartList[index].imageUrl,
//                     errorBuilder: (context, error, stackTrace) {
//                       print("Error loading image: $error");
//                       return Placeholder();
//                     },
//                   ),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(cartList[index].qty.toString()),
//                       GestureDetector(
//                         onTap: () {
//                           _removeItem(index);
//                         },
//                         child: Icon(Icons.delete),
//                       ),
//                       SizedBox(width: 8),
//                       GestureDetector(
//                         onTap: () {
//                           _addQty(index);
//                         },
//                         child: Icon(Icons.add),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           _minusQty(index);
//                         },
//                         child: Icon(Icons.arrow_back),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           Text("Total Price $TotalPrice"),
//           ElevatedButton(
//               onPressed: () {
//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (context) => Fetching()));
//               },
//               child: Text("Continue Shopping")),
//           ElevatedButton(
//               onPressed: () {
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => checkout(TotalPrice)));
//               },
//               child: Text("Check Out"))
//         ],
//       ),
//     );
//   }

//   Future<void> _loadCart() async {
//     double tempTotalPrice = 0.0;

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? cartJson = prefs.getString("cart");

//     if (cartJson != null) {
//       List<dynamic> cartMapList = jsonDecode(cartJson);
//       List<productsInCart> cartItems =
//           cartMapList.map((item) => productsInCart.fromMap(item)).toList();

//       for (var item in cartItems) {
//         tempTotalPrice += item.desc * item.qty;
//         print("Product: ${item.name}, Total Price: $tempTotalPrice");
//       }

//       setState(() {
//         cartList = cartItems;
//         TotalPrice = tempTotalPrice;
//       });
//     }
//   }

//   // item remove--------------
//   void _removeItem(int index) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       cartList.removeAt(index);
//     });

//     List<Map<String, dynamic>> updatedCartMapList =
//         cartList.map((item) => item.toMap()).toList();
//     String updatedCartJson = jsonEncode(updatedCartMapList);
//     prefs.setString("cart", updatedCartJson);
//     _loadCart();
//   }

// // add quantity---------------
//   void _addQty(int index) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       cartList[index].qty += 1;
//     });

//     List<Map<String, dynamic>> updatedCartMapList =
//         cartList.map((item) => item.toMap()).toList();
//     String updatedCartJson = jsonEncode(updatedCartMapList);
//     prefs.setString("cart", updatedCartJson);
//     _loadCart();
//   }

// //qunity subtract---------------------
//   void _minusQty(int index) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (cartList[index].qty > 1) {
//       setState(() {
//         cartList[index].qty -= 1;
//       });
//     } else {
//       setState(() {
//         cartList.removeAt(index);
//       });
//     }
//     List<Map<String, dynamic>> updatedCartMapList =
//         cartList.map((item) => item.toMap()).toList();
//     String updatedCartJson = jsonEncode(updatedCartMapList);
//     prefs.setString("cart", updatedCartJson);
//     _loadCart();
//   }
// }
