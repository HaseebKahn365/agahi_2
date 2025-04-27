import 'dart:developer';

import 'package:agahi/screens/ecom/ecom_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class RupeeNote {
  final int value;
  final String imagePath;
  RupeeNote({required this.value, required this.imagePath});

  @override
  String toString() {
    return 'RupeeNote{value: $value, imagePath: $imagePath}';
  }
}

class RS100 extends RupeeNote {
  RS100() : super(value: 100, imagePath: 'assets/images/RS100.png');
}

class RS500 extends RupeeNote {
  RS500() : super(value: 500, imagePath: 'assets/images/RS500.png');
}

List<RupeeNote> calculateNotes(int amount) {
  final List<RupeeNote> notes = [];
  final List<RupeeNote> rupeeNotes = [RS500(), RS100()];

  for (var note in rupeeNotes) {
    while (amount >= note.value) {
      notes.add(note);
      amount -= note.value;
    }
  }

  log('Calculated notes: $notes');
  return notes;
}

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoppingProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xFF2F2F4F),
      body: SafeArea(
        child: Column(
          children: [
            //a giant back button
            Padding(
              padding: const EdgeInsets.all(16),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 50,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ShoppingScreen()),
                        );
                      },
                    ),
                  ),
                  // clear the cart button
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.white, size: 30),
                      onPressed: () {
                        provider.clearCart();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DragTarget<ShoppingItem>(
                    onAcceptWithDetails: (item) {
                      provider.addToCart(item.data);
                    },
                    builder: (context, candidateData, rejectedData) {
                      return provider.cartItems.isEmpty
                          ? Center(
                            child: Text(
                              'کارٹ خالی ہے',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                          : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            child: Row(
                              children:
                                  provider.cartItems.map((item) {
                                    return Container(
                                      margin: EdgeInsets.all(8),
                                      child: Image.asset(
                                        item.location,
                                        width: 100,
                                        height: 100,
                                      ),
                                    );
                                  }).toList(),
                            ),
                          );
                    },
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.items.length,
                    itemBuilder: (context, index) {
                      final item = provider.items[index];
                      final notes = calculateNotes(item.price);
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        color: Colors.white24,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          width: 180,
                          padding: EdgeInsets.all(12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Draggable<ShoppingItem>(
                                data: item,
                                feedback: Material(
                                  child: Image.asset(
                                    item.location,
                                    width: 150,
                                    height: 150,
                                  ),
                                ),
                                childWhenDragging: Opacity(
                                  opacity: 0.5,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      item.location,
                                      fit: BoxFit.cover,
                                      height: 100,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    item.location,
                                    fit: BoxFit.cover,
                                    height: 100,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '${item.price} PKR',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              SizedBox(
                                height: 70,
                                child: Wrap(
                                  spacing: 2,
                                  children:
                                      notes.map((note) {
                                        return Image.asset(
                                          note.imagePath,
                                          width: 50,
                                          height: 50,
                                        );
                                      }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            NextButtonRaseed(),
          ],
        ),
      ),
    );
  }
}

class NextButtonRaseed extends StatelessWidget {
  const NextButtonRaseed({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CartScreen()),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Text(
                  'رسید مکمل کریں',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(width: 10),
                Icon(Icons.arrow_forward_ios, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoppingProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xFF2F2F4F),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  Text(
                    'کل ${provider.getTotal()} روپے',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            Expanded(
              child:
                  provider.cartItems.isEmpty
                      ? Center(
                        child: Text(
                          'کارٹ خالی ہے',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      )
                      : ListView.builder(
                        itemCount: provider.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = provider.cartItems[index];
                          final notes = calculateNotes(item.price);
                          return Card(
                            margin: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            color: Colors.white24,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      item.location,
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${item.price} PKR',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Wrap(
                                          spacing: 8,
                                          children:
                                              notes.map((note) {
                                                return Image.asset(
                                                  note.imagePath,
                                                  width: 80,
                                                  height: 80,
                                                );
                                              }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CheckoutScreen()),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'رسید جمع کروائیں',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward_ios, color: Colors.white),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoppingProvider>(context);
    final TextEditingController paymentController = TextEditingController();

    return Scaffold(
      backgroundColor: Color(0xFF2F2F4F),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'کل روپے',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${provider.getTotal()} PKR',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                controller: paymentController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'آپ کا پتہ',
                  hintStyle: TextStyle(color: Colors.white54),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                provider.clearCart();
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('خریداری مکمل ہوگئی!')));
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'رسید جمع کروائیں',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward_ios, color: Colors.white),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/speakoff.png',
                  width: 60,
                  height: 60,
                ),
                SizedBox(width: 40),
                Image.asset('assets/images/speakon.png', width: 60, height: 60),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
