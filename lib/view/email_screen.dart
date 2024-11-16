import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  EmailAuth emailAuth = EmailAuth(sessionName: 'Test Session');

  @override
  void dispose() {
    emailController.dispose();
    otpController.dispose();
    super.dispose();
  }

  void sendOTP() async {

    var response = await emailAuth.sendOtp(recipientMail: emailController.text);
    if(response){
      print('OTP sent');
    }
    else{
      print('OTP is not Sent');
    }
    }



  void verifyOTP() async {
    var res = emailAuth.validateOtp(recipientMail: emailController.text, userOtp: otpController.text);
    if(res){
      print('OTP Verified');
    }
    else{
      print('Invalid OTP');
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     EmailAuth emailAuth = new EmailAuth(
      sessionName: "Sample session",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(
                  'https://cdn-icons-png.flaticon.com/512/8136/8136252.png',
                  height: 150,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: (){
                    print('Button is Pressed');
                    sendOTP();
                  },
                  child: const Text('Send OTP'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: otpController,
                  decoration: const InputDecoration(
                    labelText: 'OTP',
                    hintText: 'Enter the OTP',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the OTP';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: (){
                    verifyOTP();
                  },
                  child: const Text('Verify OTP'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
