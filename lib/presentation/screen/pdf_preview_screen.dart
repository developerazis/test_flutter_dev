import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfPreviewScreen extends StatelessWidget {
  static const routeName = "/pdf-preview-screen";
  const PdfPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Uint8List>(
          future: makePdf(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return PdfPreview(build: (context) => snapshot.data!);
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }
      ),
    );
  }

  Future<Uint8List> makePdf() async {
    final pdf = pw.Document();
    pdf.addPage(
        pw.Page(
            build: (pw.Context pdfContext) {
              return pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  // crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children:[
                    pw.Center(
                      child: pw.Text("Ini Test Surat Jalan", style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 24))
                    )
                  ]
              );
            }
        )
    );

    return await pdf.save();
  }

}
