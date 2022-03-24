import 'package:firebase_auth/firebase_auth.dart';
import 'package:firedemo/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'firebase_auth_mobile.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;

  const OtpScreen({Key? key, this.mobileNumber = ''}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? verificationId;
  int? forceResendingToken;
  TextEditingController otp = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sendOtp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 120,
          ),
          const Text(
            "Otp sms sent to your number",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: otp,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            autofocus: true,
            cursorHeight: 30,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              counterText: "",
              contentPadding:
                  EdgeInsets.only(left: 15, top: 8, right: 15, bottom: 0),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              final AuthCredential cred = PhoneAuthProvider.credential(
                  verificationId: verificationId ?? "", smsCode: otp.text);
              signInWithPhone(cred);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Container(
              height: 60,
              width: 200,
              child: const Center(
                child: Text(
                  "submit",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(10)),
            ),
          )
        ],
      ),
    );
  }

  sendOtp() {
    auth.verifyPhoneNumber(
        phoneNumber: "+91${widget.mobileNumber}",
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    // Navigator.of(context).push(
    //     MaterialPageRoute(builder: (context) => const OtpScreen()));
  }

  void verificationCompleted(PhoneAuthCredential phoneAuthCredential) {}

  void codeAutoRetrievalTimeout(String verificationId) {
    this.verificationId = verificationId;
  }

  void verificationFailed(FirebaseAuthException error) {
    print(error);
  }

  void codeSent(String verificationId, int? forceResendingToken) {
    this.verificationId = verificationId;
    this.forceResendingToken = forceResendingToken;
  }

  signInWithPhone(AuthCredential authCredential) async {
    UserCredential userCredential =
        await auth.signInWithCredential(authCredential);
    final User? currentUser = auth.currentUser;
    if (userCredential.user?.uid == currentUser?.uid) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OtpScreen(
                mobileNumber: otp.text,
              )));
    } else {
      print('not verified user');
    }
  }
}
