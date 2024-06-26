import 'package:flutter/material.dart';
import 'package:test_maha_dev/presentation/screen/material.dart';

import 'order_request.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.cyan
              ),
              child: const Center(
                child: Text("Selamat Datang", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600),),
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height /3.5,
                // bottom: 0,
                height: MediaQuery.of(context).size.height / 1.4,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                    color: Colors.white
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator
                              .pushNamed(context, MaterialScreen.routeName),
                          child: const Card(
                            color: Colors.white,
                            child: SizedBox(
                              height: 200,
                              width: 170,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Data Barang", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator
                              .pushNamed(context, OrderRequestScreen.routeName),
                          child: const Card(
                            color: Colors.white,
                            child: SizedBox(
                              height: 200,
                              width: 170,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Permintaan", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),)
                                ],
                              ),
                            ),
                          ),
                        ),
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
