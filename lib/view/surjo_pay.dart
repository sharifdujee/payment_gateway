import 'package:flutter/material.dart';
import 'package:shurjopay/models/config.dart';
import 'package:shurjopay/models/payment_verification_model.dart';
import 'package:shurjopay/models/shurjopay_request_model.dart';
import 'package:shurjopay/models/shurjopay_response_model.dart';
import 'package:shurjopay/shurjopay.dart';

class SurjoPayScreen extends StatefulWidget {
  const SurjoPayScreen({super.key});

  @override
  State<SurjoPayScreen> createState() => _SurjoPayScreenState();
}

class _SurjoPayScreenState extends State<SurjoPayScreen> {
  ShurjoPay shurjoPay = ShurjoPay();
  ShurjopayConfigs shurjopayConfigs = ShurjopayConfigs(
    prefix: 'NOK',
    userName: 'Sp_sandbox',
    password: '23146',
    clientIP: '127.1.4.7',
  );

  ShurjopayResponseModel shurjopayResponseModel = ShurjopayResponseModel();
  ShurjopayVerificationModel shurjopayVerificationModel = ShurjopayVerificationModel();
  final name = TextEditingController();
  final amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shurjo Pay'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(
                  hintText: 'Enter Name',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: amount,
                decoration: const InputDecoration(
                  hintText: 'Enter Amount',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    try {
                      ShurjopayRequestModel shurjopayRequestModel = ShurjopayRequestModel(
                        configs: shurjopayConfigs,
                        currency: "BDT",
                        amount: double.parse(amount.text),
                        orderID: "sp1ab2c3d4",
                        discountAmount: 150,
                        discountPercentage: 15,
                        customerName: name.text,
                        customerPhoneNumber: "01711486915",
                        customerAddress: "customer address",
                        customerCity: "customer city",
                        customerPostcode: "1212",
                        returnURL: "https://www.sandbox.shurjopayment.com/return_url",
                        cancelURL: "https://www.sandbox.shurjopayment.com/cancel_url",
                      );

                      shurjopayResponseModel = await shurjoPay.makePayment(
                        context: context,
                        shurjopayRequestModel: shurjopayRequestModel,
                      );

                      if (shurjopayResponseModel.status == true) {
                        shurjopayVerificationModel = await shurjoPay.verifyPayment(
                          orderID: shurjopayResponseModel.shurjopayOrderID!,
                        );

                        print(shurjopayVerificationModel.spCode);
                        print(shurjopayVerificationModel.spMessage);

                        if (shurjopayVerificationModel.spCode == "1000") {
                          print("Payment Verified");
                        }
                      }
                    } catch (error) {
                      print("Error occurred: ${error.toString()}");
                    }

                    name.clear();
                    amount.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    'Pay',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
