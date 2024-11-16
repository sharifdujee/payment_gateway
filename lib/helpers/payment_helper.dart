import 'package:bkash/bkash.dart';
import 'package:bkash_payment_gateway/view/email_screen.dart';
import 'package:bkash_payment_gateway/view/geocoding.dart';
import 'package:bkash_payment_gateway/view/geolocator.dart';
import 'package:bkash_payment_gateway/view/local_auth.dart';
import 'package:bkash_payment_gateway/view/pdf.dart';
import 'package:bkash_payment_gateway/view/surjo_pay.dart';
import 'package:bkash_payment_gateway/view/three_d.dart';
import 'package:get/get.dart';

import '../view/aamar_pay.dart';

void onButtonTap(String selected) async {
  switch (selected) {
    case 'bKash':
      await bkashPayment();
      break;
    case 'Amar Pay':
      Get.to(() => const AmarPay());
      break;
    case 'surjo':
      Get.to(()=> const SurjoPayScreen());
      break;
    case 'email':
      Get.to(()=> const EmailScreen());
      break;
    case  'coding':
      Get.to(()=> const GeocodingScreen());
      break;
    case 'location':
      Get.to(()=> const GeolocatorWidget());
    case 'local_auth':
      Get.to(()=> const LocalAuthScreen());
    case '3d':
      Get.to(()=> const ThreeDScreen());
    case 'pdf':
      Get.to(()=> const PDFGenerationScreen());
    default:
      print('No gateway selected');
  }
}


double totalPrice = 1.00;

/// bKash

final bkash = Bkash(
    bkashCredentials: const BkashCredentials(
        username: '',
        password: '',
        appKey: 'appKey',
        appSecret: 'appSecret',
        isSandbox: false));

bkashPayment() async {
  try {
    final response = await bkash.pay(
      context: Get.context!,
      amount: totalPrice,
      merchantInvoiceNumber: 'Test0123456',
    );

    print(response.trxId);
    print(response.paymentId);
  } on BkashFailure catch (e) {
    print(e.message);
  }
}



