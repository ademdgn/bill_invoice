import 'package:bill_invoice/Pages/BillPage/BillDetailsPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BillCardWidget extends StatefulWidget {
  final List<Map<String, dynamic>> billlist;
  final int index;
  final Color color;

  const BillCardWidget(this.billlist, this.index, this.color, {super.key});

  @override
  State<BillCardWidget> createState() => _BillCardWidgetState();
}

class _BillCardWidgetState extends State<BillCardWidget> {
  BillPopUp popUp = BillPopUp();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    DateTime dt =
        (widget.billlist[widget.index]['payDate'] as Timestamp).toDate();
    var day = DateFormat('dd').format(dt);
    var month = DateFormat("MMMM").format(dt);
    return Card(
      elevation: 0,
      child: GestureDetector(
        onTap: () {
          popUp.showBillDetails(context, widget.billlist[widget.index]);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(15 * fem, 20 * fem, 0 * fem, 0.5 * fem),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 18.5 * fem),
                width: double.infinity,
                height: 35 * fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${widget.billlist[widget.index]["name"]}",
                            style: TextStyle(
                              fontSize: 25 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.3625 * ffem / fem,
                              color: widget.color,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 1 * fem),
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3625 * ffem / fem,
                                  color: Color(0xff000000),
                                ),
                                children: [
                                  TextSpan(
                                    text: day,
                                    style: TextStyle(
                                      fontSize: 16 * ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.3625 * ffem / fem,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' / $month',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 10 * fem, 1 * fem),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.3625 * ffem / fem,
                            color: Color(0xff000000),
                          ),
                          children: [
                            TextSpan(
                              text:
                                  "${widget.billlist[widget.index]["amount"]} ₺",
                              style: TextStyle(
                                fontSize: 20 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.3625 * ffem / fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
