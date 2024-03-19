import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redbus/database/busService.dart';
import 'package:redbus/sidescreens/bookingSuccess.dart';
import 'package:toast/toast.dart';

class DebitCard extends StatefulWidget {
  List<Map<String, dynamic>> bookingList;
  final String uEmail;
  DebitCard({Key? key, required this.bookingList, required this.uEmail}) : super(key: key);


  @override
  State<DebitCard> createState() => _DebitCardState();
}

class _DebitCardState extends State<DebitCard> {

  Future<bool> moveBack(BuildContext context) async {
    bool confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning'),
          content: Container(
            height: 100,
            child: Column(
              children: [
                const Text('Are you sure you want to go back?',style: TextStyle(fontFamily: 'Raleway',fontWeight: FontWeight.w600),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('No'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      // onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
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

  TextEditingController dName = TextEditingController();
  TextEditingController dNum = TextEditingController();
  TextEditingController dExp = TextEditingController();
  TextEditingController dCvv = TextEditingController();
  String errNum = 'Empty Card Number Field';

  BusService busService = BusService();

  bool validateName = false, validateNum = false, validateExp = false, validateCvv = false;

  selectExpDate() async{
    DateTime? selected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year+7),
    );

    if(selected != null){
      dExp.text = selected.toString().split("-").take(2).join("-");
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => moveBack(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Payments -> Debit Card",style:
          TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              fontFamily: 'Raleway'
          ),),
        ),
        body: SingleChildScrollView(
          child: Card(
              child: Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(10.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: Colors.red,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Visa Gold Debit Card",style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Raleway',
                      color: CupertinoColors.activeOrange,
                    ),),
                    const SizedBox(
                      height: 12.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        label: const Text('Enter Card Number',
                          style: TextStyle(
                            color: Colors.blue,
                            fontFamily: 'Raleway',
                          ),),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        errorText: validateNum ? errNum : null,
                      ),
                      keyboardType: TextInputType.number,
                      controller: dNum,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(16),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              label: const Text('Select Card Expiry Date',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12.0,
                                  fontFamily: 'Raleway',
                                ),),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              errorText: validateExp ? 'Empty Card Expiry Date Field' : null,
                            ),
                            keyboardType: TextInputType.datetime,
                            controller: dExp,
                            readOnly: true,
                            onTap: (){
                              selectExpDate();
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              label: const Text('Enter Card CVV',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12.0,
                                  fontFamily: 'Raleway',
                                ),),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              errorText: validateCvv ? 'Empty Card CVV Field' : null,
                            ),
                            keyboardType: TextInputType.number,
                            controller: dCvv,
                            autocorrect: true,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        label: const Text('Enter Card Holder Name',
                          style: TextStyle(
                            color: Colors.blue,
                            fontFamily: 'Raleway',
                          ),),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        errorText: validateName ? 'Empty Card Name Field' : null,
                      ),
                      keyboardType: TextInputType.text,
                      controller: dName,
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      height: 70.0,
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.only(left: 8.0,right: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: (){
                            ToastContext().init(context);
                            setState(() {
                              validateNum = dNum.text.isEmpty;
                              validateExp = dExp.text.isEmpty;
                              validateCvv = dCvv.text.isEmpty;
                              validateName = dName.text.isEmpty;
                            });
                            if(!validateName && !validateNum && !validateExp && !validateCvv){
                              if(validateCardNum(dNum.text)){
                                if(dCvv.text.length == 3){
                                  if(validateHolderName(dName.text)){
                                    showCircularProgressIndicator();
                                    setBookings(dName.text, dNum.text, dCvv.text, dExp.text);
                                    // showCircularProgressIndicator();
                                  }
                                  else{
                                    Toast.show(
                                        'Invalid Card Holder Name',
                                        duration: 3,
                                        gravity: Toast.bottom,
                                        backgroundColor: Colors.red,
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Raleway',
                                          fontSize: 13.0,
                                        )
                                    );
                                  }
                                }
                                else{
                                  Toast.show(
                                      'Invalid CVV Number',
                                      duration: 3,
                                      gravity: Toast.bottom,
                                      backgroundColor: Colors.red,
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Raleway',
                                        fontSize: 13.0,
                                      )
                                  );
                                }
                              }
                              else{
                                setState(() {
                                  validateNum = true;
                                  errNum = 'Invalid Card Number';
                                });
                                Toast.show(
                                    'Invalid Card Number',
                                    duration: 3,
                                    gravity: Toast.bottom,
                                    backgroundColor: Colors.red,
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Raleway',
                                      fontSize: 13.0,
                                    )
                                );
                              }
                            }
                            else{
                              Toast.show(
                                'Empty Fields',
                                duration: 3,
                                gravity: Toast.bottom,
                                backgroundColor: Colors.red,
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Raleway',
                                  fontSize: 13.0,
                                )
                              );
                            }
                          },
                          child: const Text('Book',style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontFamily: 'Raleway',
                          ),)
                      ),
                    )
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }

  validateCardNum(String cardNum){
    ToastContext().init(context);
    if(cardNum.length == 16){
      int count = 0;
      String num = '1234567890';
      for(int i = 0;i < cardNum.length;i++){
        if(num.contains(cardNum.characters.elementAt(i))){
          count++;
        }
      }
      if(count == 16){
        return true;
      }
      else{
        Toast.show(
            'Card Number must Contain only Numbers',
            duration: 3,
            gravity: Toast.bottom,
            backgroundColor: Colors.red,
            textStyle: const TextStyle(
              color: Colors.black,
              fontFamily: 'Raleway',
              fontSize: 13.0,
            )
        );
        return false;
      }
    }
    else{
      Toast.show(
          'Card Number must be of 16 digits',
          duration: 3,
          gravity: Toast.bottom,
          backgroundColor: Colors.red,
          textStyle: const TextStyle(
            color: Colors.black,
            fontFamily: 'Raleway',
            fontSize: 13.0,
          )
      );
      return false;
    }
  }

  validateHolderName(String name){
    String n = name.replaceAll(RegExp('[^a-zA-Z]'), '');
    if(name.length == n.length){
      return true;
    }
    else{
      return false;
    }
  }

  setBookings(String name, String num, String cvv, String exp) async{
    var mapping = Map<String, dynamic>();
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
    mapping['paymentMode'] = 'Debit Card';
    mapping['bookedDate'] = DateTime.now().toString().split(" ")[0];
    mapping['paymentDetails'] = '$name, $num, $cvv, $exp';
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
