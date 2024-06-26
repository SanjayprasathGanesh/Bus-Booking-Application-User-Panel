// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:pinput/pinput.dart';
// import 'package:redbus/screens/home.dart';
// import 'package:redbus/sidescreens/buses.dart';
//
// class MyVerify extends StatefulWidget {
//   String verificationId;
//   MyVerify({Key? key, required this.verificationId}) : super(key: key);
//
//   @override
//   State<MyVerify> createState() => _MyVerifyState();
// }
//
// class _MyVerifyState extends State<MyVerify> {
//   TextEditingController otp = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final defaultPinTheme = PinTheme(
//       width: 56,
//       height: 56,
//       textStyle: TextStyle(
//           fontSize: 20,
//           color: Color.fromRGBO(30, 60, 87, 1),
//           fontWeight: FontWeight.w600),
//       decoration: BoxDecoration(
//         border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
//         borderRadius: BorderRadius.circular(20),
//       ),
//     );
//
//     final focusedPinTheme = defaultPinTheme.copyDecorationWith(
//       border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
//       borderRadius: BorderRadius.circular(8),
//     );
//
//     final submittedPinTheme = defaultPinTheme.copyWith(
//       decoration: defaultPinTheme.decoration?.copyWith(
//         color: Color.fromRGBO(234, 239, 243, 1),
//       ),
//     );
//
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back_ios_rounded,
//             color: Colors.black,
//           ),
//         ),
//         elevation: 0,
//       ),
//       body: Container(
//         margin: EdgeInsets.only(left: 25, right: 25),
//         alignment: Alignment.center,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'images/logo.jpg',
//                 width: 150,
//                 height: 150,
//               ),
//               SizedBox(
//                 height: 25,
//               ),
//               Text(
//                 "Phone Verification",
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "We need to register your phone without getting started!",
//                 style: TextStyle(
//                   fontSize: 16,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Pinput(
//                 length: 6,
//                 // defaultPinTheme: defaultPinTheme,
//                 // focusedPinTheme: focusedPinTheme,
//                 // submittedPinTheme: submittedPinTheme,
//
//                 showCursor: true,
//                 onCompleted: (pin) => setState(() {
//                   otp.text = pin;
//                 }),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 height: 45,
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         primary: Colors.green.shade600,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10))),
//                     onPressed: () async{
//                       print(otp.text);
//                       try{
//                         PhoneAuthCredential credential = await PhoneAuthProvider
//                             .credential(verificationId: widget.verificationId, smsCode: otp.text);
//                         FirebaseAuth.instance.signInWithCredential(credential).then((value){
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
//                         });
//                       }
//                       catch(ex){
//                         print(ex.toString());
//                       }
//                     },
//                     child: Text("Verify Phone Number")),
//               ),
//               Row(
//                 children: [
//                   TextButton(
//                       onPressed: () async{
//                         // Navigator.push(context, MaterialPageRoute(builder: (context) => Buses(from: 'Coimbatore', to: 'Bangalore', date: '2024-01-29', uname: 'sanjay')));
//                         Navigator.pop(context);
//                       },
//                       child: Text(
//                         "Edit Phone Number ?",
//                         style: TextStyle(color: Colors.black),
//                       ))
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }