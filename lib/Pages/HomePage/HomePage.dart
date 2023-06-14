import 'package:bill_invoice/Pages/BillPage/Bill_Logic.dart';
import 'package:bill_invoice/Pages/HomePage/HomePage_Logic.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../BillPage/BillCard.dart';
import '../Const/Fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = HomeController();
  BillController billController = BillController();

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(42 * fem),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding:
                    EdgeInsets.fromLTRB(12 * fem, 30 * fem, 3 * fem, 111 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<Map<String, dynamic>>(
                      future: homeController.getPerson(),
                      builder: (BuildContext context,
                          AsyncSnapshot<Map<String, dynamic>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          if (snapshot.data != null) {
                            var username = snapshot.data!['name'];
                            var photoUrl = snapshot.data!['photoUrl'];

                            return HomePageTitleWidget(
                              fem: fem,
                              ffem: ffem,
                              name: username ?? '', // Add null check here
                              photoUrll: photoUrl ?? '', // Add null check here
                            );
                          } else {
                            return const Text('Name not found in the data');
                          }
                        }
                      },
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          1 * fem, 0 * fem, 0 * fem, 7 * fem),
                      child: Text(
                        'Your bills',
                        style: SafeGoogleFont(
                          'Nunito',
                          fontSize: 26 * ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.3625 * ffem / fem,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    StreamBuilder<List<Map<String, dynamic>>>(
                      stream: billController.getBillsStream(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Map<String, dynamic>>>
                              asyncSnapshot) {
                        if (asyncSnapshot.hasData) {
                          List<Map<String, dynamic>> billList =
                              asyncSnapshot.data!;
                          List<Map<String, dynamic>> filteredList =
                              List<Map<String, dynamic>>.from(billList);

                          return StatefulBuilder(
                            builder: (context, setState) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: TextField(
                                      onChanged: (query) {
                                        setState(() {
                                          filteredList = billList
                                              .where((bill) => bill['name']
                                                  .toLowerCase()
                                                  .contains(
                                                      query.toLowerCase()))
                                              .toList();
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        labelText: "Search by Name",
                                        prefixIcon: Icon(Icons.search),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: filteredList.length,
                                    itemBuilder: (context, index) {
                                      return BillCardWidget(filteredList, index,
                                          Colors.greenAccent);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else if (asyncSnapshot.hasError) {
                          return Text(
                            "An error occurred: ${asyncSnapshot.error}",
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    )
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

class HomePageTitleWidget extends StatefulWidget {
  const HomePageTitleWidget({
    super.key,
    required this.fem,
    required this.ffem,
    required this.name,
    required this.photoUrll,
  });

  final double fem;
  final double ffem;
  final String name;
  final String photoUrll;

  @override
  State<HomePageTitleWidget> createState() => _HomePageTitleWidgetState();
}

class _HomePageTitleWidgetState extends State<HomePageTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          1 * widget.fem, 0 * widget.fem, 0 * widget.fem, 27 * widget.fem),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 55 * widget.fem,
            height: 55 * widget.fem,
            child: Image.asset(
              'assets/page-1/images/icons8-hand-48-1-6E9.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: RichText(
              text: TextSpan(
                style: SafeGoogleFont(
                  'Ubuntu',
                  fontSize: 30 * widget.ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.1490000407 * widget.ffem / widget.fem,
                  color: const Color(0xff000000),
                ),
                children: [
                  TextSpan(
                    text: 'Hi, ',
                    style: SafeGoogleFont(
                      'Nunito',
                      fontSize: 30 * widget.ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.3625 * widget.ffem / widget.fem,
                      color: Color(0xff000000),
                    ),
                  ),
                  TextSpan(
                    text: widget.name.split(" ")[0],
                    style: SafeGoogleFont(
                      'Nunito',
                      fontSize: 30 * widget.ffem,
                      fontWeight: FontWeight.w700,
                      height: 1.3625 * widget.ffem / widget.fem,
                      color: const Color(0xff000000),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20, top: 20),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffffffff)),
              borderRadius: BorderRadius.circular(1 * widget.fem),
            ),
            child: Center(
              child: SizedBox(
                width: 70 * widget.fem,
                height: 70 * widget.fem,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50 * widget.fem),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (widget.photoUrll.isNotEmpty)
                        Image.network("${widget.photoUrll}"),
                      if (widget.photoUrll.isEmpty)
                        Image.asset(
                            "assets/profile-icon-design-free-vector.jpg"), // Varsayılan fotoğrafı burada belirtin
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
