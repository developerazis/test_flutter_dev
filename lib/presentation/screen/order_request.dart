import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:test_maha_dev/presentation/screen/pdf_preview_screen.dart';

class OrderRequestScreen extends StatelessWidget {
  static const routeName = "/order-request-screen";
  const OrderRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Permintaan Barang"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    // controller: materialProvider.nameController,
                    decoration: InputDecoration(
                        hintText: "Masukan Nomor Barang",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)))
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                SizedBox(
                  height: 54,
                  width: 80,
                  child: ElevatedButton(
                    onPressed: () async {
                    },
                    style: ButtonStyle(
                        textStyle: MaterialStateProperty.all<TextStyle>(
                            const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              // side:
                              // BorderSide(color: borderSideColor, style: borderStyle)
                            ))),
                    child: Center(child: Icon(Icons.search),),
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Card(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 32,
                            // backgroundImage: (user.avatar?.isNotEmpty ?? false)
                            //     ? Image.network(user.avatar!).image
                            //     : null,
                            backgroundColor: Colors.grey,
                          ),
                          const SizedBox(width: 14,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Test"),
                              const SizedBox(height: 5,),
                              Text("Stock : 10")
                            ],
                          ),
                        ]
                    ),
                    SizedBox(height: 8,),
                    SizedBox(
                      height: 54,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Navigator.pushNamed(context, PdfPreviewScreen.routeName);
                          await Printing.layoutPdf(
                              onLayout: (PdfPageFormat format) async => makePdf()
                          );
                        },
                        style: ButtonStyle(
                            textStyle: MaterialStateProperty.all<TextStyle>(
                                const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  // side:
                                  // BorderSide(color: borderSideColor, style: borderStyle)
                                ))),
                        child: Center(child: Text("Preview"),),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> makePdf() async {
    final pdf = pw.Document();
    pdf.addPage(
        pw.Page(
          build: (pw.Context pdfContext) {
            return pw.Column(
              children:[
                pw.Center(
                  child: pw.Text("Lorem Ipsum")
                )
              ]
            );
          }
        )
    );

    return pdf.save();
  }

}
