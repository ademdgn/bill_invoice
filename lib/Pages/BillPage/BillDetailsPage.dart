import 'package:bill_invoice/Pages/BillPage/Bill_Logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BillPopUp {
  void showBillDetails(BuildContext context, Map<String, dynamic> billlist) {
    final TextEditingController _payDateController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _amountController = TextEditingController();

    BillController controller = BillController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(billlist["name"]),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Are you sure"),
                        content: const Text(
                            "Are you sure you want to delete this invoice?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(); // İletişim kutusunu kapat
                            },
                            child: const Text("Off"),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.deleteBill(billlist[
                                  "billId"]); // Faturayı silme işlemini yap

                              // İletişim kutusunu kapat
                            },
                            child: const Text("Delete"),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              )
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: TextFormField(
                      // Bill Name
                      controller: _nameController,
                      cursorColor: Colors.white70,
                      textInputAction: TextInputAction.next,
                      decoration:
                          const InputDecoration(labelText: "Name Change"),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value == null
                          ? "This field cannot be left blank"
                          : null,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Map<String, dynamic> name = {
                        "name": _nameController.text
                      };
                      controller.updateBill(billlist["billId"], name);
                    },
                    icon: Icon(Icons.change_circle),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: TextFormField(
                      // Bill Name
                      controller: _amountController,
                      cursorColor: Colors.white70,
                      textInputAction: TextInputAction.next,
                      decoration:
                          const InputDecoration(labelText: "Amount Change"),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value == null
                          ? "This field cannot be left blank"
                          : null,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Map<String, dynamic> Amount = {
                        "amount": double.parse(_amountController.text)
                      };
                      controller.updateBill(billlist["billId"], Amount);
                    },
                    icon: Icon(Icons.change_circle),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: TextField(
                      // Select Bill Pay Date
                      controller: _payDateController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today_rounded),
                        labelText: "Change Pay Date",
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null) {
                          _payDateController.text =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                        }
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Map<String, dynamic> payDate = {
                        "payDate": DateTime.parse(_payDateController.text)
                      };
                      controller.updateBill(billlist["billId"], payDate);
                    },
                    icon: Icon(Icons.change_circle),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Bill Paid',
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Are you sure?"),
                      content: const Text("Do you want to pay this bill?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pop(); // İletişim kutusunu kapat
                          },
                          child: const Text("No"),
                        ),
                        TextButton(
                          onPressed: () {
                            Map<String, dynamic> isPaid = {"isPaid": true};
                            controller.updateBill(billlist["billId"], isPaid);
                            Navigator.of(context).pop();
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
