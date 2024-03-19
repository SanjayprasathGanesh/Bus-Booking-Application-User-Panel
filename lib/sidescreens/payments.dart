import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redbus/database/busService.dart';
import 'package:redbus/payments/creditCard.dart';
import 'package:redbus/payments/debitCard.dart';
import 'package:toast/toast.dart';

import 'bookingSuccess.dart';

class Payments extends StatefulWidget {
  List<Map<String, dynamic>> bookingList;
  final String uEmail;
  Payments({Key? key, required this.bookingList, required this.uEmail}) : super(key: key);

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {

  String selectedNet = '', selectedUPI = '';
  bool selectNet = false, selectUPI = false, selectDebit = false, selectWallet = false;
  var ttlAmt = 0, balanceAmt = 0;
  BusService busService = BusService();

  String busName = '', date = '', busNo = '';

  Future<bool> moveBack(BuildContext context) async {
    bool confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning'),
          content: Container(
            height: 200,
            child: Column(
              children: [
                const Text('Are you sure you want to go back?',style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.w600),),
                const Text('Note : If you give Yes, then your booking will be lost and you will be redirected to the Home Page',style: TextStyle(fontFamily: 'Raleway'),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('No'),
                    ),
                    TextButton(
                      // onPressed: () => Navigator.of(context).pop(true),
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
                      child: Text('Yes'),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );

    // Return true if the user confirms, otherwise, return false
    return confirm ?? false;
  }

  @override
  initState(){
    super.initState();
    getWalletBalance();
  }

  getWalletBalance() async{
    balanceAmt = await busService.GetBalanceWallet(widget.uEmail);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {

    ttlAmt = widget.bookingList[0]['ttlPrice'];
    busName = widget.bookingList[0]['busName'];
    date = widget.bookingList[0]['startDate'];
    busNo = widget.bookingList[0]['busNo'];

    print('Balance : $balanceAmt');

    return WillPopScope(
      onWillPop: () => moveBack(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Payments",style:
          TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              fontFamily: 'Raleway'
          ),),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                ListTile(
                  title: const Text("Debit Card",style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Raleway'
                  ),),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DebitCard(bookingList: widget.bookingList, uEmail: widget.uEmail)));
                  },
                  trailing: const Icon(Icons.navigate_next_rounded,color: Colors.blue,size: 25.0,),
                ),
                const Divider(
                  height: 2.0,
                  thickness: 2.0,
                  color: Colors.red,
                ),
                ListTile(
                  title: const Text("Credit Card",style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Raleway'
                  ),),
                  trailing: const Icon(Icons.navigate_next_rounded,color: Colors.blue,size: 25.0,),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CreditCard(bookingList: widget.bookingList, uEmail: widget.uEmail)));
                  },
                ),
                const Divider(
                  height: 2.0,
                  thickness: 2.0,
                  color: Colors.red,
                ),
                ListTile(
                  title: const Text("Wallet Pay",style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Raleway'
                  ),),
                  trailing: selectWallet ? const Icon(Icons.keyboard_arrow_down_outlined,color: Colors.blue,size: 25.0,) : const Icon(Icons.navigate_next_rounded,color: Colors.blue,size: 25.0,),
                  onTap: (){
                    setState(() {
                      selectWallet = !selectWallet;
                    });
                  },
                  subtitle: selectWallet ?
                      ElevatedButton(
                          onPressed: (){
                            print("TOTAL AMT : $ttlAmt");
                            print("BALANCE : $balanceAmt");
                            if(ttlAmt <= balanceAmt){
                              busService.UpdateWallet(widget.uEmail, busNo, date, busName, DateTime.now().toString().split(' ')[0] );
                              showCircularProgressIndicator();
                              setBookings();
                            }
                            else{
                              ToastContext().init(context);
                              Toast.show(
                                  'Insufficient Balance in your Wallet',
                                  duration: 3,
                                  backgroundColor: Colors.red,
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold,
                                  ),
                                  gravity: Toast.bottom
                              );
                            }
                          },
                          child: Text("Pay ₹$ttlAmt from your Wallet",style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway'
                          ),),
                      ) : const SizedBox(),
                ),
                const Divider(
                  height: 2.0,
                  thickness: 2.0,
                  color: Colors.red,
                ),
                ListTile(
                  title: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Net Banking ",style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Raleway'
                      ),),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                  onTap: (){
                    noNetBanking();
                    /*setState(() {
                      selectNet = !selectNet;
                    });*/
                  },
                  trailing: selectNet ? const Icon(Icons.keyboard_arrow_down_sharp,color: Colors.blue,size: 25.0,) : const Icon(Icons.navigate_next_rounded,color: Colors.blue,size: 25.0,),
                  subtitle: selectNet ? Column(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: (){
                                setState(() {
                                  selectedNet = 'Axis Bank';
                                });
                              },
                              icon: selectedNet == 'Axis Bank' ? const Icon(Icons.circle, size: 25.0,color: Colors.blue,)
                                  : const Icon(Icons.circle_outlined, size: 25.0,),
                          ),
                          const Text("Axis Bank",style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Raleway'
                          ),),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: (){
                              setState(() {
                                selectedNet = 'SBI Bank UNO';
                              });
                            },
                            icon: selectedNet == 'SBI Bank UNO' ? const Icon(Icons.circle, size: 25.0,color: Colors.blue,)
                                : const Icon(Icons.circle_outlined, size: 25.0,),
                          ),
                          const Text("SBI Bank UNO",style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Raleway'
                          ),),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: (){
                              setState(() {
                                selectedNet = 'Others';
                              });
                            },
                            icon: selectedNet == 'Others' ? const Icon(Icons.circle, size: 25.0,color: Colors.blue,)
                                : const Icon(Icons.circle_outlined, size: 25.0,),
                          ),
                          const Text("Others",style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Raleway'
                          ),),
                        ],
                      ),
                    ],
                  ) : Container(),
                ),
                const Divider(
                  height: 2.0,
                  thickness: 2.0,
                  color: Colors.red,
                ),
                ListTile(
                  title: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("UPI",style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Raleway'
                      ),),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                  onTap: (){
                    noNetBanking();
                    /*setState(() {
                      selectUPI = !selectUPI;
                    });*/
                  },
                  trailing: selectUPI ? const Icon(Icons.keyboard_arrow_down_sharp,color: Colors.blue,size: 25.0,) : const Icon(Icons.navigate_next_rounded,color: Colors.blue,size: 25.0,),
                  subtitle: selectUPI ? Column(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: (){
                              setState(() {
                                selectedUPI = 'Google Pay';
                              });
                            },
                            icon: selectedUPI == 'Google Pay' ? const Icon(Icons.circle, size: 25.0,color: Colors.blue,)
                                : const Icon(Icons.circle_outlined, size: 25.0,),
                          ),
                          const Text("Google Pay",style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Raleway'
                          ),),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: (){
                              setState(() {
                                selectedUPI = 'Amazon Pay';
                              });
                            },
                            icon: selectedUPI == 'Amazon Pay' ? const Icon(Icons.circle, size: 25.0,color: Colors.blue,)
                                : const Icon(Icons.circle_outlined, size: 25.0,),
                          ),
                          const Text("Amazon Pay",style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Raleway'
                          ),),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: (){
                              setState(() {
                                selectedUPI = 'Paytm';
                              });
                            },
                            icon: selectedUPI == 'Paytm' ? const Icon(Icons.circle, size: 25.0,color: Colors.blue,)
                                : const Icon(Icons.circle_outlined, size: 25.0,),
                          ),
                          const Text("Paytm",style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Raleway'
                          ),),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: (){
                              setState(() {
                                selectedUPI = 'Others';
                              });
                            },
                            icon: selectedUPI == 'Others' ? const Icon(Icons.circle, size: 25.0,color: Colors.blue,)
                                : const Icon(Icons.circle_outlined, size: 25.0,),
                          ),
                          const Text("Others",style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Raleway'
                          ),),
                        ],
                      ),
                    ],
                  ) : Container(),
                ),
                const Divider(
                  height: 2.0,
                  thickness: 2.0,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  noNetBanking(){
    showDialog(
        context: context,
        builder: (param){
          return const AlertDialog(
            title: Text("Error : 404",style: TextStyle(
                fontSize: 18.0,
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway'
            ),),
            content: Text("Bad Server Gateway, Please Try with Debit/Credit Cards",style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w200,
                fontFamily: 'Raleway'
            ),),
          );
        }
    );
  }

  setBookings() async{
    var mapping = <String, dynamic>{};
    print(widget.bookingList[0]['busId']);

    mapping['uEmail'] = widget.bookingList[0]['uEmail'];
    mapping['busId'] = widget.bookingList[0]['busId'];
    mapping['busName'] = widget.bookingList[0]['busName'];
    mapping['busNo'] = widget.bookingList[0]['busNo'];
    mapping['from'] = widget.bookingList[0]['from'];
    mapping['to'] = widget.bookingList[0]['to'];
    mapping['startDate'] = widget.bookingList[0]['startDate'];
    mapping['endDate'] = widget.bookingList[0]['endDate'];
    mapping['startTime'] = widget.bookingList.toString().split(",")[9].replaceAll(RegExp(r'[^0-9:]'), '').replaceFirst(":", ""); //-
    mapping['endTime'] = widget.bookingList.toString().split(",")[10].replaceAll(RegExp(r'[^0-9:]'), '').replaceFirst(":", "");
    mapping['seats'] = widget.bookingList[0]['seats'];
    mapping['boarding'] = widget.bookingList[0]['boarding'];
    mapping['dropping'] = widget.bookingList[0]['dropping'];
    mapping['ttlPrice'] = widget.bookingList[0]['ttlPrice'];
    mapping['passengerDetails'] = widget.bookingList[0]['passengerDetails'];
    mapping['phoneNum'] = widget.bookingList[0]['phoneNum'];
    mapping['email'] = widget.bookingList[0]['email'];
    mapping['busType'] = widget.bookingList[0]['busType'];
    mapping['paymentMode'] = 'Wallet';
    mapping['bookedDate'] = DateTime.now().toString().split(" ")[0];
    mapping['paymentDetails'] = '-';
    mapping['status'] = widget.bookingList[0]['status'];

    busService.AddBookings(mapping);
    busService.UpdateBookedSeats(widget.bookingList[0]['busId'], widget.bookingList[0]['seats']);

    const duration = Duration(seconds: 5);
    await Future.delayed(duration);
    Navigator.push(context, MaterialPageRoute(builder: (context) => BookingSuccess(bookingsMap: mapping, uEmail: widget.uEmail)));
  }

  void showCircularProgressIndicator() async {
    const duration = Duration(seconds: 5);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Please wait, don't switch back to another page until your Booking gets Processed,"
              "Contacting with the Bus Operator and You will be redirected to another page once your booking is confirmed",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Raleway',
                fontSize: 17.0,
                fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.justify,
          ),
          content: Container(
            height: 100,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );

    await Future.delayed(duration);
    Navigator.of(context).pop();
  }
}
