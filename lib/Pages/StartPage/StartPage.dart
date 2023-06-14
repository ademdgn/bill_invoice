import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import '../Const/Fonts.dart';

class Start extends StatefulWidget {
  final VoidCallback onClickedGetStarted;

  const Start({Key? key, required this.onClickedGetStarted}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context as BuildContext).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Container(
          // frame3knq (0:3)
          width: double.infinity,
          margin: EdgeInsets.only(top: 25),
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(1 * fem),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // Nxd (94150530)
                width: 540 * fem,
                height: 540 * fem,
                child: Image.asset(
                  'assets/page-1/images/start.png',
                  width: 400 * fem,
                  height: 400 * fem,
                ),
              ),
              Container(
                // fgq (79974335)
                width: double.infinity,
                height: 350 * fem,
                child: Container(
                  // autogroupitu9d7s (Gy6XTcosiAxAXbGNrniTU9)
                  padding: EdgeInsets.fromLTRB(
                      30 * fem, 9 * fem, 30 * fem, 10 * fem),
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // logoL2H (0:14)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 142 * fem, 10 * fem),
                        width: 228 * fem,
                        height: 45 * fem,
                        child: Image.asset(
                          'assets/page-1/images/logo.png',
                          width: 228 * fem,
                          height: 45 * fem,
                        ),
                      ),
                      Container(
                        // infotxt4cV (0:11)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 3 * fem, 1 * fem),
                        width: 367 * fem,
                        height: 134 * fem,
                        child: Stack(
                          children: [
                            Positioned(
                              // ellipse9AvR (0:12)
                              left: 220 * fem,
                              top: 0 * fem,
                              child: Align(
                                child: SizedBox(
                                  width: 147 * fem,
                                  height: 76 * fem,
                                  child: Image.asset(
                                    'assets/page-1/ellipse-9.jpg',
                                    width: 147 * fem,
                                    height: 76 * fem,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // manageandremindyourbillsquickl (0:13)
                              left: 0 * fem,
                              top: 5.9999847412 * fem,
                              child: Align(
                                child: SizedBox(
                                  width: 364 * fem,
                                  height: 128 * fem,
                                  child: RichText(
                                    text: TextSpan(
                                      style: SafeGoogleFont(
                                        'Nunito',
                                        fontSize: 39 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.6289999546 * ffem / fem,
                                        color: Color(0xff000000),
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Manage',
                                          style: SafeGoogleFont(
                                            'Nunito',
                                            fontSize: 39 * ffem,
                                            fontWeight: FontWeight.w800,
                                            height: 1.6289999546 * ffem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' ',
                                          style: SafeGoogleFont(
                                            'Nunito',
                                            fontSize: 39 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.6289999546 * ffem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'and ',
                                          style: SafeGoogleFont(
                                            'Nunito',
                                            fontSize: 39 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.6289999546 * ffem / fem,
                                            color: Color(0xff242424),
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'remind',
                                          style: SafeGoogleFont(
                                            'Nunito',
                                            fontSize: 39 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.6289999546 * ffem / fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' your bills quickly',
                                          style: SafeGoogleFont(
                                            'Nunito',
                                            fontSize: 39 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.6289999546 * ffem / fem,
                                            color: Color(0xff242424),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 170),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey
                                  .withOpacity(0.1), // Gölge rengi ve opaklığı
                              spreadRadius: 2, // Gölgenin yayılma miktarı
                              blurRadius: 5, // Gölgenin bulanıklık miktarı
                              offset: const Offset(
                                  0, 3), // Gölgenin x ve y yönündeki ofseti
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = widget.onClickedGetStarted,
                                  text: "Skip",
                                  style: const TextStyle(
                                    color: Color(0xfff4C9040),
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
