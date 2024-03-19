import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:redbus/screens/home.dart';
import 'package:redbus/screens/myAccount.dart';
import 'package:redbus/screens/myBookings.dart';
import 'package:redbus/screens/offers.dart';
import 'package:redbus/sidescreens/contactUs.dart';
import 'package:redbus/sidescreens/helpCentre.dart';
import 'package:redbus/sidescreens/ourRoutes.dart';
import 'package:redbus/sidescreens/rentABus.dart';

import 'database/busService.dart';
import 'logins/userLogin.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyALqi9ygYrlHxF8_pyGHAU3G0cmuPYTins',
          appId: '1:1008560729657:android:a364e68bfdb10372ef27e8',
          messagingSenderId: '1008560729657',
          projectId: 'redbus-19c55'
      )
  );
  runApp(const MaterialApp(
    home: UserLogin(),
    debugShowCheckedModeBanner: false,
  ));
}

class RedbusApp extends StatefulWidget {
  final String uEmail;
  const RedbusApp({Key? key, required this.uEmail}) : super(key: key);

  @override
  State<RedbusApp> createState() => _RedbusAppState();
}

class _RedbusAppState extends State<RedbusApp> {
  int page = 0;

  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      Home(uEmail: widget.uEmail,),
      MyBookings(uEmail: widget.uEmail,),
      const Offers(),
      MyAccount(uEmail: widget.uEmail,),
    ];
  }

  BusService busService = BusService();
  String docId = '';

  getUserDocId() async{
    QuerySnapshot querySnapshot = await busService.GetUser(widget.uEmail);
    setState(() {
      docId = querySnapshot.docs[0].id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DreamLiner Travels",style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'Raleway'
        ),),
        backgroundColor: Colors.blue,
      ),
      body: pages[page],
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserAccountsDrawerHeader(
                  accountName: Text(widget.uEmail,style: const TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                  ),),
                  accountEmail: const Text('',style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                  ),),
                  currentAccountPicture: const CircleAvatar(
                    child: Icon(
                      Icons.person_outline,
                      color: Colors.black,
                      size: 25.0,
                    ),
                  ),
              ),
              ListTile(
                leading: const Icon(Icons.alt_route_sharp,size: 30.0,color: Colors.blue,),
                title: const Text("Our Routes",style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w700,
                ),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OurRoutes()));
                },
                selectedTileColor: Colors.grey,
                splashColor: Colors.lightBlue,
              ),
              const Divider(
                thickness: 1.0,
                color: Colors.black,
              ),
              ListTile(
                leading: const Icon(Icons.directions_bus,size: 30.0,color: Colors.blue,),
                title: const Text("Rent a Bus",style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w700,
                ),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RentABus(uEmail: widget.uEmail!)));
                },
                selectedTileColor: Colors.grey,
                splashColor: Colors.lightBlue,
              ),
              const Divider(
                thickness: 1.0,
                color: Colors.black,
              ),
              ListTile(
                leading: const Icon(Icons.image_outlined,size: 30.0,color: Colors.blue,),
                title: const Text("Bus Gallery",style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w700,
                ),),
                onTap: (){
                  noPage(context);
                },
                selectedTileColor: Colors.grey,
                splashColor: Colors.lightBlue,
              ),
              const Divider(
                thickness: 1.0,
                color: Colors.black,
              ),
              ListTile(
                leading: const Icon(Icons.help_center_outlined,size: 30.0,color: Colors.blue,),
                title: const Text("Help Center",style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w700,
                ),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HelpCentre(uEmail: widget.uEmail!)));
                },
                selectedTileColor: Colors.grey,
                splashColor: Colors.lightBlue,
              ),
              const Divider(
                thickness: 1.0,
                color: Colors.black,
              ),
              ListTile(
                leading: const Icon(Icons.contact_mail_outlined,size: 30.0,color: Colors.blue,),
                title: const Text("Contact us",style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w700,
                ),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUs(uEmail: widget.uEmail!)));
                },
                selectedTileColor: Colors.grey,
                splashColor: Colors.lightBlue,
              ),
              const Divider(
                thickness: 1.0,
                color: Colors.black,
              ),
              const SizedBox(height: 5.0,),
              const Row(
                children: [
                  SizedBox(width: 10.0,),
                  Text('Version: 0.0.1',style: TextStyle(
                    fontSize: 11.0,
                    fontFamily: 'Raleway',
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),)
                ],
              ),
              const SizedBox(height: 10.0,),
              Container(
                height: 175,
                color: Colors.grey,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.logout,size: 25.0,color: Colors.red,),
                      title: const Text("Log out",style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w700,
                      ),),
                      onTap: (){
                        logout(context);
                      },
                      selectedTileColor: Colors.grey,
                      splashColor: Colors.lightBlue,
                    ),
                    const Divider(
                      thickness: 1.0,
                      color: Colors.black,
                    ),
                    ListTile(
                      leading: const Icon(Icons.auto_delete_outlined,size: 25.0,color: Colors.red,),
                      title: const Text("Delete Account",style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w700,
                      ),),
                      onTap: (){
                        deleteAccount(context);
                      },
                      selectedTileColor: Colors.grey,
                      splashColor: Colors.lightBlue,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 15.0,right: 15.0),
        height: 75.0,
        decoration: const BoxDecoration(
          color: Color(0xFFadb5bd),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                IconButton(
                    onPressed: (){
                      setState(() {
                        page = 0;
                      });
                    },
                    icon: page == 0 ?
                        const Icon(Icons.home_outlined,size: 25.0,color: Colors.blue,) :
                    const Icon(Icons.home_outlined,size: 25.0,),
                ),
                Text("Home",style: TextStyle(
                  color: page == 0 ? Colors.blue : Colors.black,
                  fontSize: 12.0,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600,
                ),)
              ],
            ),
            Column(
              children: [
                IconButton(
                  onPressed: (){
                    setState(() {
                      page = 1;
                    });
                  },
                  icon: page == 1 ?
                  const Icon(Icons.checklist_outlined,size: 25.0,color: Colors.blue,) :
                  const Icon(Icons.checklist_outlined,size: 25.0,),
                ),
                Text("Bookings",style: TextStyle(
                  color: page == 1 ? Colors.blue : Colors.black,
                  fontSize: 12.0,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600,
                ),)
              ],
            ),
            Column(
              children: [
                IconButton(
                  onPressed: (){
                    setState(() {
                      page = 2;
                    });
                  },
                  icon: page == 2 ?
                  const Icon(Icons.local_offer_outlined,size: 25.0,color: Colors.blue,) :
                  const Icon(Icons.local_offer_outlined,size: 25.0,),
                ),
                Text("Offers",style: TextStyle(
                  color: page == 2 ? Colors.blue : Colors.black,
                  fontSize: 12.0,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600,
                ),)
              ],
            ),
            Column(
              children: [
                IconButton(
                  onPressed: (){
                    setState(() {
                      page = 3;
                    });
                  },
                  icon: page == 3 ?
                  const Icon(Icons.person_outline_outlined,size: 25.0,color: Colors.blue,) :
                  const Icon(Icons.person_outline_outlined,size: 25.0,),
                ),
                Text("My Account",style: TextStyle(
                  color: page == 3 ? Colors.blue : Colors.black,
                  fontSize: 12.0,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600,
                ),)
              ],
            ),
          ],
        ),
      ),
    );
  }

  //Add with user name in the input parameter
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
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const UserLogin()),
                          (route) => false,
                    );
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

  deleteAccount(BuildContext context){
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Do You want to Delete this Account',
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
                  onPressed: () async{
                    await busService.DeleteUser(docId);
                  },
                  child: const Text('Delete')),
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
              'No Bus Images Available Currently',
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
