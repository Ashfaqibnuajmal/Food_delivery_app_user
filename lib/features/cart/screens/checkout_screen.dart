import 'package:flutter/material.dart';
import 'package:mera_app/core/theme/app_color.dart';
import 'package:mera_app/features/cart/screens/address_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final double subtotal;
  final double discount;
  final double deliveryFee;
  final double total;
  const CheckoutScreen(
      {super.key,
      required this.subtotal,
      required this.discount,
      required this.deliveryFee,
      required this.total});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedPayment = "cod";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Checkout',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Address Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Delivery Address",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddressScreen()));
                  },
                  child: Text(
                    "Change",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.grey,
                      decorationThickness: 1.5,
                      shadows: [
                        Shadow(
                          offset: const Offset(1, 1),
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.3),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            const Row(
              children: [
                Icon(Icons.location_on_outlined, color: Colors.grey),
                SizedBox(width: 6),
                Text(
                  "Home",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              "Kunnamkulam, Thrissur, Kerala",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),

            const Divider(height: 30),

            // Payment Method
            const Text(
              "Payment Method",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),

            RadioListTile<String>(
              value: "cod",
              groupValue: _selectedPayment,
              activeColor: AppColors.primaryOrange,
              onChanged: (value) {
                setState(() {
                  _selectedPayment = value!;
                });
              },
              title: const Text("Cash On Delivery"),
            ),
            RadioListTile<String>(
              value: "razorpay",
              activeColor: AppColors.primaryOrange,
              groupValue: _selectedPayment,
              onChanged: (value) {
                setState(() {
                  _selectedPayment = value!;
                });
              },
              title: const Text("Razorpay"),
            ),

            const Divider(height: 30),

            _priceRow("Subtotal", "₹${widget.subtotal.toStringAsFixed(2)}"),
            _priceRow("Discount", "₹${widget.discount.toStringAsFixed(2)}"),
            _priceRow("Delivery", "₹${widget.deliveryFee.toStringAsFixed(2)}"),
            const Divider(thickness: 1),
            _priceRow("Total", "₹${widget.total.toStringAsFixed(2)}",
                isBold: true, fontSize: 20),

            const Divider(height: 30),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  backgroundColor: AppColors.primaryOrange,
                ),
                onPressed: () {
                  // ✅ Now you can check which payment method user selected
                  debugPrint("Payment Selected: $_selectedPayment");
                },
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddressScreen()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Place Order",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.arrow_forward_rounded, color: Colors.black),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _priceRow(String title, String value,
    {bool isBold = false, double fontSize = 15}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
        Text(
          value,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
      ],
    ),
  );
}
