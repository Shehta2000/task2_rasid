import 'package:flutter/material.dart';
import 'package:task2/services/pdf_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PdfGenerator());
}

class PdfGenerator extends StatelessWidget {
  const PdfGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title:const  Text('Portfolio PDF Generator')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              generatePortfolioPdf();
            },
            child: const  Text('Generate PDF'),
          ),
        ),
      ),
    );
  }
}