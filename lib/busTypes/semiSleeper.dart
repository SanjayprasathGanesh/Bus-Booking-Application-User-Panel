import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:redbus/database/busService.dart';
import 'package:redbus/userDetails/userDetails.dart';
import 'package:toast/toast.dart';

class SemiSleeper extends StatefulWidget {
  final String? docId;
  final String uEmail;
  const SemiSleeper({Key? key, required this.docId, required this.uEmail}) : super(key: key);

  @override
  State<SemiSleeper> createState() => _SemiSleeperState();
}

class _SemiSleeperState extends State<SemiSleeper> {

  List<String> selectedSeats = <String>[];
  List<String> bookedList = <String>[];

  String busName = '', boarding = '', dropping = '', booked = '';
  int price = 0;

  BusService busService = BusService();

  getBusDetails() async{
    DocumentSnapshot documentSnapshot = await busService.GetBusDetails(widget.docId!);
    Map<String, dynamic>? bus = documentSnapshot.data() as Map<String, dynamic>?;

    setState(() {
      busName = bus?['busName'];
      boarding = bus?['boarding'];
      dropping = bus?['routes'];
      price = bus?['price'];
      booked = bus?['bookedSeats'];

      bookedList = booked.replaceAll(RegExp(r'[^0-9,]'), "").split(",");
      print(bookedList);
    });
  }

  Widget buildSeatListView() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 9,
      itemBuilder: (context, rowIndex) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int seatIndex = 1; seatIndex <= 5; seatIndex++)
              seatIndex == 3
                  ? const SizedBox(width: 25.0)
                  : buildSeatIconButton(rowIndex, seatIndex),
          ],
        );
      },
    );
  }

  IconButton buildSeatIconButton(int rowIndex, int seatIndex) {
    int seatNumber = rowIndex * 4 + (seatIndex >= 4 ? seatIndex - 1 : seatIndex);
    bool isBooked = false;
    for(int i = 0;i < bookedList.length;i++){
      if(bookedList.elementAt(i) == seatNumber.toString()){
        isBooked = true;
      }
    }

    bool isAlreadyBooked = selectedSeats.contains('$seatNumber');

    return IconButton(
      onPressed: isBooked
          ? null
          : () {
        ToastContext().init(context);
        setState(() {
          handleSeatSelection(isAlreadyBooked, seatNumber);
        });
      },
      icon: Icon(
        getSeatIcon(rowIndex, seatIndex),
      ),
      iconSize: 40.0,
      splashColor: Colors.blue,
      splashRadius: 30.0,
      tooltip: 'Seat Number : ${(rowIndex * 4 + seatIndex).toString()}',
    );
  }

  void handleSeatSelection(bool isAlreadyBooked, int seatNumber) {
    if (!selectedSeats.contains('$seatNumber') && selectedSeats.length < 4) {
      selectedSeats.add('$seatNumber');
    } else if (!selectedSeats.contains('$seatNumber') && selectedSeats.length >= 4) {
      showErrorMessage();
    } else {
      selectedSeats.remove('$seatNumber');
    }
  }

  IconData getSeatIcon(int rowIndex, int seatIndex) {
    int seatNumber = rowIndex * 4 + (seatIndex >= 4 ? seatIndex - 1 : seatIndex);

    if (bookedList.contains('$seatNumber')) {
      return Icons.chair; // Display Icons.chair for already booked seats
    }
    else {
      return selectedSeats.contains('$seatNumber') ? Icons.chair : Icons.chair_outlined;
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

  Widget lastSeatView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: 5,
      itemBuilder: (context, seatIndex) {
        return buildLastSeatIconButton(0, seatIndex + 1);
      },
    );
  }

  Widget buildLastSeatIconButton(int rowIndex, int seatIndex) {
    int seatNumber = 36 + seatIndex; // Start seat numbers from 37
    bool isBooked = bookedList.contains(seatNumber.toString());
    bool isAlreadyBooked = selectedSeats.contains('$seatNumber');

    return IconButton(
      onPressed: isBooked
          ? null
          : () {
        ToastContext().init(context);
        setState(() {
          handleLastSeatSelection(isAlreadyBooked, seatNumber);
        });
      },
      icon: Icon(
        getLastSeatIcon(isBooked, isAlreadyBooked),
      ),
      iconSize: 40.0,
      splashColor: Colors.blue,
      splashRadius: 30.0,
      tooltip: 'Seat Number : ${seatNumber.toString()}',
    );
  }

  void handleLastSeatSelection(bool isAlreadyBooked, int seatNumber) {
    if (!selectedSeats.contains('$seatNumber') && selectedSeats.length < 4) {
      selectedSeats.add('$seatNumber');
    } else if (!selectedSeats.contains('$seatNumber') && selectedSeats.length >= 4) {
      showErrorMessage();
    } else {
      selectedSeats.remove('$seatNumber');
    }
  }

  IconData getLastSeatIcon(bool isBooked, bool isAlreadyBooked) {
    if (isBooked) {
      return Icons.chair; // Display Icons.chair for already booked seats
    } else {
      return isAlreadyBooked ? Icons.chair : Icons.chair_outlined;
    }
  }


  /*Widget lastSeatView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5, // Number of icons in each row
        crossAxisSpacing: 2.0, // Reduce the horizontal spacing
        mainAxisSpacing: 2.0, // Reduce the vertical spacing
      ),
      itemCount: 5, // Total number of icons
      itemBuilder: (context, index) {
        index += 37;
        return IconButton(
          onPressed: () {
            ToastContext().init(context);
            setState(() {
              // Check if the seat is already booked
              if (bookedList.contains(index)) {
                // If already booked, return without updating the state
                showAlreadyBookedMessage();
                return;
              }

              // Continue with your logic for selecting/unselecting seats
              if (!selectedSeats.contains(index) && selectedSeats.length < 4) {
                selectedSeats.add(index);
              } else if (!selectedSeats.contains(index) && selectedSeats.length >= 4) {
                showErrorMessage();
              } else {
                selectedSeats.remove(index);
              }
            });
          },
          icon: Icon(
            selectedSeats.contains(index) ? Icons.chair : Icons.chair_outlined,
          ),
          iconSize: 40.0,
          splashColor: Colors.blue,
          splashRadius: 40.0,
          tooltip: 'Seat Number : ${index.toString()}',
        );
      },
    );
  }


  void showAlreadyBookedMessage() {
    Toast.show(
      'Sorry, This seat is already booked.',
      duration: 5,
      gravity: Toast.bottom,
      backgroundColor: Colors.red,
      textStyle: const TextStyle(
        color: Colors.black,
        fontFamily: 'Raleway',
        fontSize: 15.0,
      ),
    );
  }*/

  /*Widget lastSeatView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5, // Number of icons in each row
        crossAxisSpacing: 2.0, // Reduce the horizontal spacing
        mainAxisSpacing: 2.0, // Reduce the vertical spacing
      ),
      itemCount: 5, // Total number of icons
      itemBuilder: (context, index) {
        index += 37;
        return IconButton(
          onPressed: () {
            ToastContext().init(context);
            setState(() {
                if (!selectedSeats.contains(index) && selectedSeats.length < 4) {
                  selectedSeats.add(index);
                }
                else if(!selectedSeats.contains(index) && selectedSeats.length >= 4){
                  Toast.show(
                      'Sorry, You are Allowed only to Book 4 Seats At a Time in a Single Bus',
                      duration: 5,
                      gravity: Toast.bottom,
                      backgroundColor: Colors.red,
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Raleway',
                        fontSize: 15.0,
                      )
                  );
                }
                else{
                  selectedSeats.remove(index);
                }
            });
          },
          icon: Icon(
              selectedSeats.contains(index) ?
                Icons.chair :
                Icons.chair_outlined),
          iconSize: 40.0,
          splashColor: Colors.blue,
          splashRadius: 40.0,
          tooltip: 'Seat Number : ${index.toString()}',
        );
      },
    );
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBusDetails();
  }

  bool selectedBoarding = false, selectedDropping = false;

  Future selectBoarding(){
    List<String> boardingList = boarding.split(",");
    List<bool> selectedItems = List.generate(boardingList.length, (index) => false);

    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          width: double.infinity,
          child: ListView.builder(
            itemCount: boardingList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Checkbox(
                  value: selectedItems[index],
                  onChanged: (bool? value) {
                    setState(() {
                      // Unselect all items
                      for (int i = 0; i < selectedItems.length; i++) {
                        if (i != index) {
                          selectedItems[i] = false;
                        }
                      }
                      // Toggle the selected state for the current item
                      selectedItems[index] = !selectedItems[index];
                    });
                  },
                ),
                title: Text(
                  boardingList[index],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontFamily: 'Poppins',
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(busName,style:
        const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'Raleway'
        ),),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: 650,
            width: 280,
            margin: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.blue,
                width: 3.0,
              )
            ),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                    height: 500,
                    width: 250,
                    child: buildSeatListView(),
                  ),
                  Container(
                    height: 50,
                    width: 250,
                    child: lastSeatView(),
                  )
                ],
              ),
            )
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetails(docId: widget.docId!, seats: selectedSeats, uEmail: widget.uEmail, )));
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
