// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:redbus/sidescreens/verify.dart';
//
// class MyPhone extends StatefulWidget {
//   const MyPhone({Key? key}) : super(key: key);
//
//   @override
//   State<MyPhone> createState() => _MyPhoneState();
// }
//
// class _MyPhoneState extends State<MyPhone> {
//   TextEditingController countryController = TextEditingController();
//   TextEditingController phoneNumber = TextEditingController();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     countryController.text = "+91";
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
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
//               Container(
//                 height: 55,
//                 decoration: BoxDecoration(
//                     border: Border.all(width: 1, color: Colors.grey),
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       width: 10,
//                     ),
//                     SizedBox(
//                       width: 40,
//                       child: TextField(
//                         controller: countryController,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                     Text(
//                       "|",
//                       style: TextStyle(fontSize: 33, color: Colors.grey),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Expanded(
//                         child: TextField(
//                           controller: phoneNumber,
//                           keyboardType: TextInputType.phone,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: "Phone",
//                           ),
//                         ))
//                   ],
//                 ),
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
//                       await FirebaseAuth
//                           .instance
//                           .verifyPhoneNumber(
//                             verificationCompleted: (PhoneAuthCredential credential){
//                               /*try {
//                                 await FirebaseAuth.instance.signInWithCredential(credential);
//                                 // Navigate to the next screen or perform other actions upon successful verification
//                                 print('Verification completed automatically');
//                               } catch (e) {
//                                 print('Error signing in automatically: $e');
//                               }*/
//                             },
//                             verificationFailed: (FirebaseAuthException ex){},
//                             codeSent: (String verificationId, int? resendToken){
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=> MyVerify(verificationId: verificationId,)));
//                             },
//                             codeAutoRetrievalTimeout: (String verificationId){},
//                             phoneNumber: '+91${phoneNumber.text}'
//                       );
//                       },
//                     child: Text("Send the code")),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }