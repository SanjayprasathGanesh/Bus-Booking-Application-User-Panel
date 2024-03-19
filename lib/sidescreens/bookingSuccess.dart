import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'eTicket.dart';

class BookingSuccess extends StatefulWidget {
  Map<String, dynamic> bookingsMap;
  final String uEmail;
  BookingSuccess({Key? key, required this.bookingsMap, required this.uEmail}) : super(key: key);

  @override
  State<BookingSuccess> createState() => _BookingSuccessState();
}

class _BookingSuccessState extends State<BookingSuccess> {

  Duration duration = Duration(seconds: 6);

  moveToNext() async{
    await Future.delayed(duration);
    Navigator.push(context, MaterialPageRoute(builder: (context) => ETicket(bookingsMap: widget.bookingsMap, uEmail: widget.uEmail)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moveToNext();
  }

  Future<bool> moveBack(BuildContext context) async {
    bool confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning'),
          content: const Column(
            children: [
              Text('Are you sure you want to go back?'),
              Text('Note : If you give Yes, then your booking will be lost and you will be redirected to the Home Page'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
              child: Text('Yes'),
            ),
          ],
        );
      },
    );

    // Return true if the user confirms, otherwise, return false
    return confirm ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => moveBack(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Booking Success",style:
          TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              fontFamily: 'Raleway'
          ),),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              SizedBox(
                height: 300,
                child: RiveAnimation.asset(
                  'images/tick_animation.riv',
                ),
              ),
              SizedBox(height: 5),
              Text("Your Ticket Has been Booked Successfully",style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway'
              ),textAlign: TextAlign.center,),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
