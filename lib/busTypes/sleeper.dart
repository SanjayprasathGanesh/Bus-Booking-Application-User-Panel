import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import '../database/busService.dart';
import '../userDetails/userDetailsSleeper.dart';

class Sleeper extends StatefulWidget {
  final String busId;
  final String uEmail;
  const Sleeper({Key? key, required this.busId, required this.uEmail}) : super(key: key);

  @override
  State<Sleeper> createState() => _SleeperState();
}

class _SleeperState extends State<Sleeper> {

  List<String> selectedSeats = <String>[];

  String busName = '', boarding = '', dropping = '', booked = '';
  int price = 0;

  BusService busService = BusService();

  getBusDetails() async{
    DocumentSnapshot documentSnapshot = await busService.GetBusDetails(widget.busId!);
    Map<String, dynamic>? bus = documentSnapshot.data() as Map<String, dynamic>?;

    setState(() {
      busName = bus?['busName'];
      boarding = bus?['boarding'];
      dropping = bus?['routes'];
      price = bus?['price'];
      booked = bus?['bookedSeats'];

      bookedList = booked.replaceAll(RegExp(r'[^0-9,LU]'), "").split(",");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBusDetails();
  }

  int seatNumber = 0;
  generateLowerSeats() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: (context, rowIndex) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int seatIndex = 1; seatIndex <= 4; seatIndex++)
              seatIndex == 2
                  ? const SizedBox(width: 25.0)
                  : buildLowerSeat(rowIndex, seatIndex),
          ],
        );
      },
    );
  }

  List<String> bookedList = <String>[];
  GestureDetector buildLowerSeat(int rowIndex, int seatIndex) {
    int seatNumber = rowIndex * 3 + (seatIndex >= 2 ? seatIndex - 1 : seatIndex);
    bool isBooked = false;
    for(int i = 0;i < bookedList.length;i++){
      if(bookedList.elementAt(i) == 'L${seatNumber.toString()}'){
        isBooked = true;
      }
    }

    bool isAlreadyBooked = selectedSeats.contains('L$seatNumber');

    return GestureDetector(
      onTap: isBooked
          ? null : () {
        ToastContext().init(context);
        setState(() {
          handleLowerSeatSelection(isAlreadyBooked, seatNumber);
        });
      },
      child: getLowerSeatIcon(rowIndex, seatIndex),
    );
  }

  void handleLowerSeatSelection(bool isAlreadyBooked, int seatNumber) {
    if (!selectedSeats.contains('L$seatNumber') && selectedSeats.length < 4) {
      selectedSeats.add('L$seatNumber');
    } else if (!selectedSeats.contains('L$seatNumber') && selectedSeats.length >= 4) {
      showErrorMessage();
    } else {
      selectedSeats.remove('L$seatNumber');
    }
  }

  Container getLowerSeatIcon(int rowIndex, int seatIndex) {
    int seatNumber = rowIndex * 3 + (seatIndex >= 2 ? seatIndex - 1 : seatIndex);

    if (bookedList.contains('L$seatNumber')) {
      return Container(
        height: 70,
        width: 35,
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Colors.black,
            width: 3.0,
          ),
          color: Colors.grey,
        ),
      );// Display Icons.chair for already booked seats
    }
    else {
      return selectedSeats.contains('L$seatNumber') ?
      Container(
          height: 70,
          width: 35,
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
          color: Colors.black,
          width: 3.0,
          ),
          color: Colors.blue,
          )
      ) :
      Container(
          height: 70,
          width: 35,
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
              color: Colors.black,
              width: 3.0,
            ),
            color: Colors.white,
          )
      )
      ;
    }
  }

  //Upper
  generateUpperSeats() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: (context, rowIndex) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int seatIndex = 1; seatIndex <= 4; seatIndex++)
              seatIndex == 2
                  ? const SizedBox(width: 25.0)
                  : buildUpperSeat(rowIndex, seatIndex),
          ],
        );
      },
    );
  }

  GestureDetector buildUpperSeat(int rowIndex, int seatIndex) {
    int seatNumber = rowIndex * 3 + (seatIndex >= 2 ? seatIndex - 1 : seatIndex);
    bool isBooked = false;
    for(int i = 0;i < bookedList.length;i++){
      if(bookedList.elementAt(i) == 'U${seatNumber.toString()}'){
        isBooked = true;
      }
    }

    bool isAlreadyBooked = selectedSeats.contains('U$seatNumber');

    return GestureDetector(
      onTap: isBooked
          ? null : () {
        ToastContext().init(context);
        setState(() {
          handleUpperSeatSelection(isAlreadyBooked, seatNumber);
        });
      },
      child: getUpperSeatIcon(rowIndex, seatIndex),
    );
  }

  void handleUpperSeatSelection(bool isAlreadyBooked, int seatNumber) {
    if (!selectedSeats.contains('U$seatNumber') && selectedSeats.length < 4) {
      selectedSeats.add('U$seatNumber');
    } else if (!selectedSeats.contains('U$seatNumber') && selectedSeats.length >= 4) {
      showErrorMessage();
    } else {
      selectedSeats.remove('U$seatNumber');
    }
  }

  Container getUpperSeatIcon(int rowIndex, int seatIndex) {
    int seatNumber = rowIndex * 3 + (seatIndex >= 2 ? seatIndex - 1 : seatIndex);

    if (bookedList.contains('U$seatNumber')) {
      return Container(
        height: 70,
        width: 35,
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Colors.black,
            width: 3.0,
          ),
          color: Colors.grey,
        ),
      );// Display Icons.chair for already booked seats
    }
    else {
      return selectedSeats.contains('U$seatNumber') ?
      Container(
          height: 70,
          width: 35,
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
              color: Colors.black,
              width: 3.0,
            ),
            color: Colors.blue,
          )
      ) :
      Container(
          height: 70,
          width: 35,
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
              color: Colors.black,
              width: 3.0,
            ),
            color: Colors.white,
          )
      )
      ;
    }
  }

  void showErrorMessage() {
    Toast.show(
      'Sorry, You are Allowed only to Book 4 Seats At a Time in a Single Bus',
      duration: 5,
      gravity: Toast.bottom,
      backgroundColor: Colors.red,
      textStyle: const TextStyle(
        color: Colors.black,
        fontFamily: 'Raleway',
        fontSize: 15.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(busName,style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway'
        ),),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0,bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Container(
                      height: 580,
                      width: 180,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.blue,
                            width: 3.0,
                          )
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(left: 5.0,right: 5.0,bottom: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Lower Deck',style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Raleway'
                                ),),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 55,
                                  child: Image.asset(
                                      'images/steering.png',fit: BoxFit.fill
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Divider(
                              height: 2.0,
                              thickness: 2.0,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              height: 480,
                              width: 250,
                              child: generateLowerSeats(),
                            ),
                          ],
                        ),
                      )
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Container(
                      height: 580,
                      width: 180,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.blue,
                            width: 3.0,
                          )
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(left: 5.0,right: 5.0,bottom: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text('Upper Deck',style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Raleway'
                                ),),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 55,
                                  child: Image.asset(
                                      'images/steering.png',fit: BoxFit.fill
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            const Divider(
                              height: 2.0,
                              thickness: 2.0,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              height: 480,
                              width: 250,
                              child: generateUpperSeats(),
                            ),
                          ],
                        ),
                      )
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        Container(
          margin: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Seats : ${selectedSeats.toString()}',style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Raleway',
                    fontSize: 15.0,
                  ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text('Price : ₹${price * selectedSeats.length}',style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Raleway',
                    fontSize: 15.0,
                  ),),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: (){
                      if(selectedSeats.isNotEmpty){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailsSleeper(docId: widget.busId!, seats: selectedSeats, uEmail: widget.uEmail,)));
                      }
                      else{
                        ToastContext().init(context);
                        Toast.show(
                            'Seats Not Selected',
                            backgroundColor: Colors.red,
                            duration: 3,
                            gravity: Toast.bottom,
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Raleway',
                            )
                        );
                      }
                    },
                    child: const Text('Proceed',style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                      fontSize: 15.0,
                    ),),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: (){
                      setState(() {
                        selectedSeats.clear();
                      });
                    },
                    child: const Text('Clear Seats',style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                      fontSize: 15.0,
                    ),),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
