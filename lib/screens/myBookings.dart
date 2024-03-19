import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:redbus/database/busService.dart';
import 'package:redbus/models/bookingModel.dart';
import 'package:toast/toast.dart';

class MyBookings extends StatefulWidget {
  final String uEmail;
  const MyBookings({Key? key, required this.uEmail}) : super(key: key);

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {

  List<BookingModel> bookingsList = <BookingModel>[];
  BusService busService = BusService();
  List<String> docIdList = <String>[];
  bool completed = false, isCancelled = false, isLoaded = false;

  getBookingDetails() async{
    QuerySnapshot querySnapshot = await busService.GetBookings(widget.uEmail);
    List<BookingModel> tempList = <BookingModel>[];
    List<String> tempIds = <String>[];
    Map<String, dynamic> bookingsMap = Map<String, dynamic>();
    int length = querySnapshot.docs.length;
    for(int i = 0;i < length;i++){
        var b = querySnapshot.docs[i].data();
        
        bookingsMap = b as Map<String, dynamic>;
        var bookingModel = BookingModel();
        bookingModel.uEmail = bookingsMap?['uEmail'];
        bookingModel.busId = bookingsMap?['busId'];
        bookingModel.from = bookingsMap?['from'];
        bookingModel.to = bookingsMap?['to'];
        bookingModel.startDate = bookingsMap?['startDate'];
        bookingModel.boarding = bookingsMap?['boarding'];
        bookingModel.busName = bookingsMap?['busName'];
        bookingModel.busNo = bookingsMap?['busNo'];
        bookingModel.busType = bookingsMap?['busType'];
        bookingModel.ttlPrice = bookingsMap?['ttlPrice'];
        bookingModel.seats = bookingsMap?['seats'];
        bookingModel.status = bookingsMap?['status'];
        isCancelled = (bookingsMap?['status'] == 'Cancelled') ? true : false;
        tempList.add(bookingModel);
        tempIds.add(querySnapshot.docs[i].id);
    }

    setState(() {
      bookingsList = tempList;
      docIdList = tempIds;
      isLoaded = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBookingDetails();
  }

  bool isDateCompleted(String date) {
    DateTime parsedDate = DateTime.parse(date).add(Duration(days: 1));
    DateTime currentDate = DateTime.now();
    // If the parsed date is before the current date, it is considered completed
    return parsedDate.isBefore(currentDate);
  }


  @override
  Widget build(BuildContext context) {
    
    if(!isLoaded){
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    
    if(isLoaded && bookingsList.isEmpty){
      return Scaffold(
        body: Center(
          child: Container(
            height: 280,
            width: 400,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      'images/emptyBookings.png',
                  ),
                  fit: BoxFit.fitWidth
              )
            ),
            child: const Text('No Bookings Found',style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: ListView.builder(
          itemCount: bookingsList.length,
          itemBuilder: (context, index){
            completed = isDateCompleted(bookingsList[index].startDate!);
            print('$completed, $isCancelled');
            return Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 0.0,top: 5.0),
              child: Card(
                child: ListTile(
                  title: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 50.0,
                                child: Icon(Icons.directions_bus,size: 60.0,),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(bookingsList[index].startDate!,style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold,
                              ),),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Bus Ticket',style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w500,
                                  ),),
                                  const SizedBox(
                                    width: 20.0,
                                  ),
                                  Text('${bookingsList[index].status?.toUpperCase()}',style: const TextStyle(
                                    color: Colors.green,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w500,
                                  ),)
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text('${bookingsList[index].from} - ${bookingsList[index].to}',style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w500,
                              ),),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text('${bookingsList[index].busName}',style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13.0,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w500,
                              ),),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Seats: ${bookingsList[index].seats}',style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 13.0,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Text('Price: ${bookingsList[index].ttlPrice}',style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 13.0,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold,
                                  ),),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      const Divider(
                        height: 3.0,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${bookingsList[index].busType}',style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 11.0,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          ),),
                          Text('${bookingsList[index].boarding}',style: const TextStyle(
                            color: Colors.purple,
                            fontSize: 12.0,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          ),),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      !completed && !isCancelled && !(bookingsList[index].status == 'Cancelled')?
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  completed = !completed;
                                });
                                cancelTicket(docIdList[index], bookingsList[index].busId!, bookingsList[index].seats!, bookingsList[index].busName!, bookingsList[index].busNo!, bookingsList[index].startDate!, bookingsList[index].ttlPrice!);
                              },
                              child: const Text('Cancel Ticket',style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold,
                              ),)
                          )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }

  cancelTicket(String docId, String busId, String seats, String busName, String busNo, String date, int price){
    showDialog(
        context: context,
        builder: (param){
          return AlertDialog(
            title: const Text('Do You want to Cancel Ticket',style: TextStyle(
              color: Colors.black,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
            ),),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () async{
                      busService.UpdateCancel(docId);
                      busService.UpdateCancelledSeats(busId,seats);
                      busService.CreateWallet(widget.uEmail, busName, busNo, date, price);
                      setState(() {
                        completed = !completed;
                      });
                      ToastContext().init(context);
                      Toast.show('Ticket Cancelled Successfully', duration: 3);
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel My Ticket',style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                    ),),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () async{
                    Navigator.pop(context);
                  },
                  child: const Text('No',style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ],
            ),
          );
        }
    );
  }
}


