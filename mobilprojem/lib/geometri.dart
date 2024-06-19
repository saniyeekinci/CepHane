import 'package:pdfx/pdfx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeometriPdf extends StatefulWidget {
  const GeometriPdf({Key? key}) : super(key: key);

  @override
  State<GeometriPdf> createState() => _MatematikPdfState();
}

class _MatematikPdfState extends State<GeometriPdf> {

  late PdfControllerPinch pdfControllerPinch;

  int totalPageCount = 0, currentPage = 1;

  @override
  void initState() {
    super.initState();
    pdfControllerPinch = PdfControllerPinch(document: PdfDocument.openAsset('assets/geometri.pdf'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ÇEMBER VE DAİRE',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0), // Adjust padding as needed
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Topkam Sayfa: $totalPageCount'),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      pdfControllerPinch.previousPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
                    },
                    icon: Icon(Icons.arrow_back,color: Colors.black),
                  ),
                  Text('Güncel Sayfa: $currentPage'),
                  IconButton(
                    onPressed: () {
                      pdfControllerPinch.nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
                    },
                    icon: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ],
          ),
        ),
        _pdfView(),
      ],
    );
  }

  Widget _pdfView() {
    return Expanded(
      child: PdfViewPinch(
        scrollDirection: Axis.vertical,
        controller: pdfControllerPinch,
        onDocumentLoaded: (doc) {
          setState(() {
            totalPageCount = doc.pagesCount;
          });
        },
        onPageChanged: (page) {
          setState(() {
            currentPage = page;
          });
        },
      ),
    );
  }
}
