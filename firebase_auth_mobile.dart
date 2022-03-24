import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'otpscreen.dart';

class FirebaseAuthMobile extends StatefulWidget {
  const FirebaseAuthMobile({Key? key}) : super(key: key);

  @override
  _FirebaseAuthMobileState createState() => _FirebaseAuthMobileState();
}

class _FirebaseAuthMobileState extends State<FirebaseAuthMobile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  String? verificationId;

  int? forceResendingToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Auth'),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      controller: phoneNumberController,
                      decoration: const InputDecoration(
                        prefixText: '+91',
                        prefixStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () => sendOtp(),
                child: Center(
                  child: Container(
                    height: 50,
                    width: 200,
                    color: Colors.green,
                    child: const Center(
                      child: Text(
                        "Send",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  sendOtp() {
    // auth.verifyPhoneNumber(
    //     phoneNumber: "+91${phoneNumberController.text}",
    //     verificationCompleted: verificationCompleted,
    //     verificationFailed: verificationFailed,
    //     codeSent: codeSent,
    //     codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => OtpScreen(mobileNumber:phoneNumberController.text,)));
  }

  // void verificationCompleted(PhoneAuthCredential phoneAuthCredential) {}
  //
  // void codeAutoRetrievalTimeout(String verificationId) {
  //   this.verificationId = verificationId;
  // }
  //
  // void verificationFailed(FirebaseAuthException error) {
  //   print(error);
  // }
  //
  // void codeSent(String verificationId, int? forceResendingToken) {
  //   this.verificationId = verificationId;
  //   this.forceResendingToken = forceResendingToken;
  // }
}
