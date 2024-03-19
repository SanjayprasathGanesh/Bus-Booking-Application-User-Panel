import 'package:flutter/material.dart';
import 'package:redbus/settings/aboutUs.dart';
import 'package:redbus/settings/terms&conditions.dart';
import 'package:redbus/settings/wallet.dart';

import '../settings/faq.dart';
import '../sidescreens/userProfile.dart';

class MyAccount extends StatefulWidget {
  final String uEmail;
  const MyAccount({Key? key, required this.uEmail}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ListTile(
                  title: const Text('User Profile',style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),),
                  leading: const Icon(Icons.perm_identity,color: Colors.deepOrange,),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile(uEmail: widget.uEmail,)));
                  },
                ),
                const Divider(
                  indent: 60.0,
                  endIndent: 10.0,
                  thickness: 2.0,
                  color: Colors.black,
                ),
                ListTile(
                  title: const Text('Wallet',style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),),
                  leading: const Icon(Icons.account_balance_wallet_outlined,color: Colors.pinkAccent,),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Wallet(uEmail: widget.uEmail,)));
                  },
                ),
                const Divider(
                  indent: 60.0,
                  endIndent: 10.0,
                  thickness: 2.0,
                  color: Colors.black,
                ),
                ListTile(
                  title: const Text('Cards',style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),),
                  leading: const Icon(Icons.card_giftcard_outlined,color: Colors.pinkAccent,),
                  onTap: (){
                    noPage(context);
                  },
                ),
                const Divider(
                  indent: 60.0,
                  endIndent: 10.0,
                  thickness: 2.0,
                  color: Colors.black,
                ),
                ListTile(
                  title: const Text('FAQ',style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),),
                  leading: const Icon(Icons.help_outline,color: Colors.blue,),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const FAQPage()));
                  },
                ),
                const Divider(
                  indent: 60.0,
                  endIndent: 10.0,
                  thickness: 2.0,
                  color: Colors.black,
                ),
                ListTile(
                  title: const Text('About Us',style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),),
                  leading: const Icon(Icons.local_post_office_outlined,color: Colors.purple,),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs(uEmail: widget.uEmail)));
                  },
                ),
                const Divider(
                  indent: 60.0,
                  endIndent: 10.0,
                  thickness: 2.0,
                  color: Colors.black,
                ),
                ListTile(
                  title: const Text('Terms and Policies',style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),),
                  leading: const Icon(Icons.bolt_outlined,color: Colors.indigo,),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndPolicies()));
                  },
                ),
                const Divider(
                  indent: 60.0,
                  endIndent: 10.0,
                  thickness: 2.0,
                  color: Colors.black,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 30.0,right: 30.0,top: 10.0,bottom: 10.0),
                  height: 40.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )
                    ),
                    onPressed: (){
                      logout(context);
                    },
                    child: const Text('Log Out',style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  logout(BuildContext context){
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Do You want to Logout from this Account',
              style: TextStyle(color: Colors.black,
                fontFamily: 'Raleway',
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.red),
                  onPressed: (){
                    // Navigator.of(context).pushAndRemoveUntil(
                    //   MaterialPageRoute(builder: (context) => const UserLogin()),
                    //       (route) => false,
                    // );
                  },
                  child: const Text('Logout')),
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.green),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'))
            ],
          );
        }
    );
  }

  noPage(BuildContext context){
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'No Cards Available Currently',
              style: TextStyle(color: Colors.black,
                fontFamily: 'Raleway',
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.green),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'))
            ],
          );
        }
    );
  }
}
