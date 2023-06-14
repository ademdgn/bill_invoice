import 'package:bill_invoice/Pages/BillPage/Bill_Logic.dart';
import 'package:bill_invoice/Pages/UserPage/UserPage_Logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Model/BillModel.dart';
import '../../main.dart';

class BillAddPage extends StatefulWidget {
  const BillAddPage({Key? key}) : super(key: key);

  @override
  State<BillAddPage> createState() => _BillAddPageState();
}

class _BillAddPageState extends State<BillAddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _payDateController = TextEditingController();
  BillController billController = BillController();
  UserProfile userProfile = UserProfile();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        leading: Container(
          margin: EdgeInsets.all(10),
          width: 10,
          height: 10,
          child: Image.asset(
            'assets/page-1/images/logo-pw7.png',
            width: 5,
            height: 5,
          ),
        ),
        title: const Text(
          "Bill Invoice",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // Başlık
                margin: EdgeInsets.only(bottom: 55 * fem, top: 30 * fem),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // Logo
                      margin: EdgeInsets.only(right: 17 * fem, bottom: 6 * fem),
                      width: 150 * fem,
                      height: 150 * fem,
                      child: Image.asset(
                        'assets/invoice.png',
                        width: 63 * fem,
                        height: 63 * fem,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        // Bill Name
                        controller: _nameController,
                        cursorColor: Colors.white70,
                        textInputAction: TextInputAction.next,
                        decoration:
                            const InputDecoration(labelText: "Bill Name"),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      TextFormField(
                        // Bill Amount
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.white70,
                        textInputAction: TextInputAction.next,
                        decoration:
                            const InputDecoration(labelText: "Bill Amount"),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      TextFormField(
                        // Bill Details
                        controller: _detailsController,
                        cursorColor: Colors.white70,
                        textInputAction: TextInputAction.next,
                        decoration:
                            const InputDecoration(labelText: "Bill Details"),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      TextField(
                        // Select Bill Pay Date
                        controller: _payDateController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today_rounded),
                          labelText: "Select Bill Pay Date",
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );

                          if (pickedDate != null) {
                            setState(() {
                              _payDateController.text =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    // Bill Add Button
                    onPressed: () {
                      Bill bill = Bill(
                          name: _nameController.text,
                          payDate: DateTime.parse(_payDateController.text),
                          details: _detailsController.text,
                          isPaid: false,
                          amount: double.parse(_amountController.text),
                          billId: "");
                      billController.addBills(bill, context);
                      billController.addEvents();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Fatura başarıyla eklendi"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                    ),
                    icon: const Icon(
                      Icons.add,
                      size: 32,
                    ),
                    label: const Text(
                      "Bill Add",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
