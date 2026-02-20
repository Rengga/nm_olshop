import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentPage extends StatefulWidget {
  final List<Map<String, dynamic>> items;

  const PaymentPage({super.key, required this.items});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool get isFormValid {
    return nameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        selectedMethod != null &&
        selectedMethod != "Transfer Bank";
  }

  String? selectedMethod;

  final List<String> paymentMethods = [
    "Transfer Bank",
    "COD",
    "E-Wallet",
    "QR Code",
  ];

  String formatRupiah(int number) {
    return NumberFormat.decimalPattern('id').format(number);
  }

  @override
  void initState() {
    super.initState();

    nameController.addListener(() => setState(() {}));
    phoneController.addListener(() => setState(() {}));
    addressController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    const int shippingCost = 50000;

    final int subtotal = widget.items.fold(
      0,
      (sum, item) => sum + (item["price"] * item["qty"]) as int,
    );

    final int totalPayment = subtotal + shippingCost;

    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// LIST BARANG
            Expanded(
              child: ListView.builder(
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  final item = widget.items[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: Image.asset(
                        item["image"] ?? "",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.image),
                      ),
                      title: Text(item["name"]),
                      subtitle: Text(
                        "Rp ${formatRupiah(item["price"])} x ${item["qty"]}",
                      ),
                      trailing: Text(
                        "Rp ${formatRupiah(item["price"] * item["qty"])}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Nama Penerima",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Nomor Telepon",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            /// INPUT ALAMAT
            TextField(
              controller: addressController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: "Address Shipping",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            /// DROPDOWN METODE
            DropdownButtonFormField<String>(
              value: selectedMethod,
              hint: const Text("Pilih Metode Pembayaran"),
              items: paymentMethods
                  .map(
                    (method) =>
                        DropdownMenuItem(value: method, child: Text(method)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedMethod = value;
                });
              },
              decoration: const InputDecoration(
                labelText: "Metode Payment",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            /// RINGKASAN
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Subtotal: Rp ${formatRupiah(subtotal)}"),
                    const Text("Shipping Price: Rp 50.000"),
                    const SizedBox(height: 6),
                    Text(
                      "Total Payment: Rp ${formatRupiah(totalPayment)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// BUTTON BAYAR
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFormValid
                      ? const Color(0xFF4ECBC4)
                      : const Color.fromARGB(255, 66, 66, 66),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: isFormValid
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Payment Successful!")),
                        );
                      }
                    : null,
                child: Text(
                  "Pay Now",
                  style: TextStyle(
                    color: isFormValid
                        ? Color.fromARGB(255, 255, 255, 255)
                        : Color.fromARGB(255, 146, 146, 146),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
