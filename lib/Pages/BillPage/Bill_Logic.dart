import 'package:bill_invoice/Storage_Service/Firebase_Storage.dart';
import 'package:bill_invoice/Storage_Service/googleCalender.dart';
import 'package:flutter/material.dart';
import '../../Model/BillModel.dart';
import '../../Storage_Service/Firebase_Auth.dart';
import '../../main.dart';

class BillController {
  BillController();
  Storage storage = Storage();
  Auth auth = Auth();
  Calender calender = Calender();

  addEvents() async {
    await calender.createCalendarEvent();
  }

  Stream<List<Map<String, dynamic>>> getBillsStream() {
    return Stream.fromFuture(getBills());
  }

  Stream<List<Map<String, dynamic>>> paidBillsStream() {
    return Stream.fromFuture(paidBills());
  }

  Future<List<Map<String, dynamic>>> getBills() async {
    return await storage.getBills();
  }

  Future<List<Map<String, dynamic>>> paidBills() async {
    return await storage.paidBills();
  }

  addBills(Bill bill, BuildContext context) async {
    Map<String, dynamic> bills = {
      "name": bill.name,
      "amount": bill.amount,
      "isPaid": bill.isPaid,
      "payDate": bill.payDate,
      "details": bill.details,
      "billId": bill.billId,
    };
    await storage.addBill(bills);
    Navigator.pop(context);
  }

  deleteBill(String billID) async {
    await storage.deleteBill(billID);
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  updateBill(String billID, Map<String, dynamic> updatedData) async {
    await storage.updateBill(billID, updatedData);
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
