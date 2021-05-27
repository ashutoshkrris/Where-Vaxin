import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({Key? key, required this.file, required this.filename})
      : super(key: key);
  final File file;
  static String routeName = '/pdf';
  final String filename;

  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.filename}'),
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
        ),
        body: SfPdfViewer.file(widget.file));
  }
}
