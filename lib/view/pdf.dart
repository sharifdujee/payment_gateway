import 'package:bkash_payment_gateway/helpers/pdf_helper.dart';
import 'package:bkash_payment_gateway/helpers/pdf_invoice_helper.dart';
import 'package:bkash_payment_gateway/model/customer.dart';
import 'package:bkash_payment_gateway/model/invoice.dart';
import 'package:bkash_payment_gateway/model/supplier.dart';
import 'package:bkash_payment_gateway/widget/button_widget.dart';
import 'package:bkash_payment_gateway/widget/title_widget.dart';
import 'package:flutter/material.dart';

class PDFGenerationScreen extends StatefulWidget {
  const PDFGenerationScreen({super.key});

  @override
  State<PDFGenerationScreen> createState() => _PDFGenerationScreenState();
}

class _PDFGenerationScreenState extends State<PDFGenerationScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromARGB(66, 196, 194, 194),
      appBar: AppBar(
        title: const Text('PDF Generate'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleWidget(icon: Icons.picture_as_pdf, title: 'Generate Invoice'),
              const SizedBox(height: 48,),
              ButtonWidget(text: 'Get PDF', onClicked: ()async{
                final date = DateTime.now();
                final dueDate = date.add(const Duration(days: 7));
                final invoice = Invoice(
                    info: InvoiceInfo(description: 'First order-invoice', number: '+01535689782', date: date, dueDate: dueDate),
                    supplier: Supplier(name: 'Amit Hasan', address: 'Polashi, Dhaka, BD', paymentInfo: 'https;//bkash.com'),
                    customer: Customer(name: 'Latifur Khabir', address: 'AzimPur, Dhaka, BD'),
                    items: [
                      InvoiceItem(description: 'Book', date: DateTime.now(), quantity: 3, vat: 0.19, unitPrice: 0.99),
                      InvoiceItem(description: 'Magazine', date: DateTime.now(), quantity: 8, vat: 0.25, unitPrice: 5.99),
                      InvoiceItem(description: 'Dry Fruits', date: DateTime.now(), quantity: 1, vat: 0.30, unitPrice: 10.99),
                      InvoiceItem(description: 'Book', date: DateTime.now(), quantity: 3, vat: 0.19, unitPrice: 0.99),
                      InvoiceItem(description: 'Book', date: DateTime.now(), quantity: 3, vat: 0.19, unitPrice: 0.99)
                    ]);
                final pdfFile = await PdfInvoicePdfHelper.generate(invoice);
                PdfHelper.openFile(pdfFile);
              })
            ],
          ),
        ),
      ),
      
    );
  }
}
