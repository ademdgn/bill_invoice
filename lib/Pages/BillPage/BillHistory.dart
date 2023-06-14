import 'package:bill_invoice/Pages/BillPage/Bill_Logic.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BillCard.dart';

class BillHistory extends StatefulWidget {
  BillHistory({super.key});

  @override
  State<BillHistory> createState() => _BillHistoryState();
}

class _BillHistoryState extends State<BillHistory> {
  final BillController billController = BillController();

  @override
  Widget build(BuildContext context) {
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
          "Paid Bill History",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            StreamBuilder<List<Map<String, dynamic>>>(
                stream: billController.paidBillsStream(),
                builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                  if (asyncSnapshot.data != null) {
                    List<Map<String, dynamic>> billlist = asyncSnapshot.data;
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: billlist.length,
                        itemBuilder: (context, index) {
                          return BillCardWidget(billlist, index, Colors.grey);
                        });
                  } else if (asyncSnapshot.hasError) {
                    return Text(
                      "An error occurred: ${asyncSnapshot.error}",
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                })
          ],
        ),
      ),
    );
  }
}
