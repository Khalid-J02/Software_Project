import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DocsPdfViewer extends StatefulWidget {
  String pdfFileURL ;
  DocsPdfViewer({super.key , required this.pdfFileURL});

  @override
  State<DocsPdfViewer> createState() => _DocsPdfViewerState();
}

class _DocsPdfViewerState extends State<DocsPdfViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("PDF Viewer"),
      ),
      body: SfPdfViewer.network(
        widget.pdfFileURL,
        enableTextSelection: true,

      ),
    );
  }
}
