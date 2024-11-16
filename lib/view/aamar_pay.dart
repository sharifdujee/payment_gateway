import 'package:aamarpay/aamarpay.dart';
import 'package:flutter/material.dart';

class AmarPay extends StatefulWidget {
  const AmarPay({super.key});

  @override
  State<AmarPay> createState() => _AmarPayState();
}

class _AmarPayState extends State<AmarPay> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Aamarpay(
            returnUrl: (String url){
              print('The url is $url');
            },
            isLoading: (bool loading){
              setState(() {
                isLoading = loading;
              });
            },
            status: (EventState event, String message){
              if(event == EventState.error){
                setState(() {
                  isLoading = false;
                });
              }
            },
            isSandBox: true,
            successUrl: 'https://sharifdeveloper.com/',
            failUrl: 'example.com/payment/fail',
            cancelUrl: 'https://example.com/payment/cancel',
            storeID: 'aamarpaytest',
            transactionID: DateTime.now().millisecondsSinceEpoch.toString(),
            signature: 'dbb74894e82415a2f7ff0ec3a97e4183',
            customerName: 'Md Robayet Bin Rahat',
            customerEmail: 'Rahad99@gmail.com',
            customerMobile: '+8801791010417',
            transactionAmount: '200',
            description: 'Test',
            //transactionAmountFromTextField: TextFormField(),
            child: isLoading? const Center(
              child: CircularProgressIndicator(),
            ):Container(
              color: Colors.orange,
              height: 50,
              child: Center(
                child: Text('Payment', style: Theme.of(context).textTheme.labelLarge,),
              ),
            )),
      ),
    );
  }
}