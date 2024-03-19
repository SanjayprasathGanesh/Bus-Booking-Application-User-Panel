import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:redbus/busTypes/benzSleeper.dart';
import 'package:redbus/busTypes/volvoBus.dart';
import 'package:redbus/busTypes/semiSleeper.dart';
import 'package:redbus/database/busService.dart';
import 'package:toast/toast.dart';
import '../busTypes/seaterCumSleeper.dart';
import '../busTypes/sleeper.dart';
import '../models/busModel2.dart';

class Buses extends StatefulWidget {
  final String from;
  final String to;
  final String date;
  final String uEmail;
  const Buses({Key? key, required this.from, required this.to, required this.date, required this.uEmail}) : super(key: key);

  @override
  State<Buses> createState() => _BusesState();
}

class _BusesState extends State<Buses> {

  String? id;
  int ttlSeats = 0,bookedSeats = 0;

  List<BusModel2> busList = <BusModel2>[];
  List<String> busIds = <String>[];
  bool isLoaded = false;

  BusService busService = BusService();

  getBus() async{
    QuerySnapshot querySnapshot = await busService.GetSearchedBus(widget.from, widget.to, widget.date);
    List<BusModel2> tempList = <BusModel2>[];
    List<String> idsList = <String>[];
    for(int i = 0;i < querySnapshot.size;i++){
      Map<String, dynamic> map = querySnapshot.docs[i].data() as Map<String, dynamic>;
      var bus = BusModel2();
      bus.busNo = map['busNo'];
      bus.busName = map['busName'];
      bus.startDate = map['startDate'];
      bus.endDate = map['endDate'];
      bus.startTime = map['startTime'];
      bus.endTime = map['endTime'];
      bus.type = map['type'];
      bus.routes = map['routes'];
      bus.bookedSeats = map['bookedSeats'];
      bus.price = map['price'];
      bus.ttlSeats = map['ttlSeats'];

      tempList.add(bus);
      idsList.add(querySnapshot.docs[i].id);
    }

    setState(() {
      busList = tempList;
      busIds = idsList;
      isLoaded = true;
    });
  }

  @override
  initState() {
    super.initState();
    getBus();
  }

  showBus() {
    return isLoaded ?
      ListView.builder(
        itemCount: busList.length,
        itemBuilder: (context, index){
          id = busIds[index];

          DateTime startTime = parseTime(busList[index].startTime!);
          DateTime endTime = parseTime(busList[index].endTime!);
          if (endTime.isBefore(startTime)) {
            endTime = endTime.add(const Duration(days: 1));
          }
          Duration difference = endTime.difference(startTime);
          double differenceInHours = difference.inMinutes / 60;

          ttlSeats = busList[index].ttlSeats!;
          String bSeats = busList[index].bookedSeats!;
          print(bSeats);
          if(bSeats.isNotEmpty){
            List<String> bSeatsList = bSeats.split(',');
            bookedSeats = bSeatsList.length-2 ;
          }
          else{
            bookedSeats = 0;
          }

          return Container(
            margin: const EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${busList[index].startTime} - ${busList[index].endTime}',style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                        ),),
                        Text('From ₹${busList[index].price}',style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                        ),)
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${differenceInHours.roundToDouble()} hrs - ${ttlSeats - bookedSeats} Seats Available',style: const TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Raleway',
                            fontSize: 13.0
                        ),),
                        Text('₹${(busList[index].price! + 200)}',style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontFamily: 'Raleway',
                            fontSize: 13.0
                        ),)
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text('${busList[index].busName}',style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0
                    ),),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text('${busList[index].type}',style: const TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Raleway',
                        fontSize: 13.0
                    ),),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFddb892),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Text('Flexi Ticket',style: TextStyle(
                              color: Colors.brown,
                              fontFamily: 'Raleway',
                              fontSize: 13.0
                          ),),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFff7b00),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Text('100% on Time',style: TextStyle(
                              color: Colors.yellow,
                              fontFamily: 'Raleway',
                              fontSize: 13.0
                          ),),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6a994e),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Text('Cancellation Available',style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Raleway',
                              fontSize: 13.0
                          ),),
                        ),
                      ],
                    )
                  ],
                ),
                onTap: (){
                  if(busList[index].type == 'Non AC-Semi Sleeper' || busList[index].type == 'AC-Semi Sleeper') {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SemiSleeper(docId: id!, uEmail: widget.uEmail,)));
                  }
                  else if(busList[index].type == 'AC-Sleeper' || busList[index].type == 'Non AC-Sleeper') {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Sleeper(busId: id!, uEmail: widget.uEmail,)));
                  }
                  else if(busList[index].type == 'Non-AC Seater cum Sleeper' || busList[index].type == 'AC Seater cum Sleeper') {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SeaterCumSleeper(busId: id!, uEmail: widget.uEmail,)));
                  }
                  else if(busList[index].type == 'AC-Seater Volvo Multi Axle') {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => VolvoMultiAxleBus(busId: busIds[index], uEmail: widget.uEmail,)));
                  }
                  else if(busList[index].type == 'AC-Sleeper Benz') {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BenzSleeper(busId: busIds[index], uEmail: widget.uEmail,)));
                  }
                  else{
                    ToastContext().init(context);
                    Toast.show(
                        'Bus type not found'
                    );
                  }
                  },
              ),
            ),
          );
        }
      ) : const Center(child: CircularProgressIndicator(),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${widget.from} to ${widget.to} Buses",style:
            const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                fontFamily: 'Raleway'
            ),),
            Text('Dated on : ${widget.date}',style:
            const TextStyle(
                fontSize: 13.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontFamily: 'Raleway'
            ),),
          ],
        ),
        toolbarHeight: 60,
      ),
      body: Container(
        child: showBus(),
      ),
    );
  }

  DateTime parseTime(String timeStr) {
    List<String> parts = timeStr.split(':');
    return DateTime(DateTime.now().year, 1, 1, int.parse(parts[0]), int.parse(parts[1]));
  }
}
