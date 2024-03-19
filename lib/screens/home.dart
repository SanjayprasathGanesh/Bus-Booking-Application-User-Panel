import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:redbus/database/busService.dart';
import 'package:redbus/database/repository.dart';
import 'package:toast/toast.dart';
import '../sidescreens/buses.dart';

class Home extends StatefulWidget {
  final String uEmail;
  const Home({Key? key, required this.uEmail}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController from = TextEditingController();
  TextEditingController to = TextEditingController();
  TextEditingController date = TextEditingController();

  bool validateStart = false,validateEnd = false,validateDate = false;
  BusService busService = BusService();

  List<String> cities = [];

  List<String> filteredCitiesFrom = [];
  List<String> filteredCitiesTo = [];

  Future<void> getAllRoutes() async {
    QuerySnapshot querySnapshot = await busService.GetAllRoutes();
    Set<String> citiesSet = Set<String>();

    for (int i = 0; i < querySnapshot.size; i++) {
      Map<String, dynamic> map = querySnapshot.docs[i].data() as Map<String, dynamic>;
      String routes = map['routes'];
      List<String> routesList = routes.split(',');

      for (String city in routesList) {
        citiesSet.add(city.trim());
      }
    }

    setState(() {
      cities.addAll(citiesSet.toList());
    });
  }



  Future<void> selectDate() async{
    DateTime? selected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100)
    );

    if(selected != null){
      date.text = selected.toString().split(" ")[0];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllRoutes();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Book Tickets",style: TextStyle(
              fontSize: 25.0,
              fontFamily: 'Gabarito',
              fontWeight: FontWeight.w700,
            ),),
            const SizedBox(height: 15.0,),
            Container(
              // height: 350,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.directions_bus,size: 35.0,color: Colors.blue,),
                        title: TextField(
                          controller: from,
                          decoration: InputDecoration(
                            label: const Text("From",style: TextStyle(
                              fontFamily: 'Raleway',
                            ),),
                            errorText: validateStart ? 'Empty From Field' : null,
                          ),
                          onChanged: (value) {
                            setState(() {
                              filteredCitiesFrom = cities
                                  .where((city) =>
                                  city.toLowerCase().contains(value.toLowerCase()))
                                  .toList();
                            });
                          },
                        ),
                      ),
                      const Divider(
                        thickness: 1.0,
                        color: Colors.black,
                      ),
                      filteredCitiesFrom.isEmpty
                          ? Container()
                          : SizedBox(
                            height: 200,
                            child: ListView.builder(
                              itemCount: filteredCitiesFrom.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(filteredCitiesFrom[index]),
                                  onTap: () {
                                    setState(() {
                                      from.text = filteredCitiesFrom[index];
                                      filteredCitiesFrom = [];
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                      ListTile(
                        leading: const Icon(Icons.directions_bus,size: 35.0,color: Colors.blue,),
                        title: TextField(
                          controller: to,
                          decoration: InputDecoration(
                            label: const Text("to",style: TextStyle(
                              fontFamily: 'Raleway',
                            ),),
                            errorText: validateEnd ? 'Empty End Field' : null,
                          ),
                          onChanged: (value) {
                            setState(() {
                              filteredCitiesTo = cities
                                  .where((city) =>
                                  city.toLowerCase().contains(value.toLowerCase()))
                                  .toList();
                            });
                          },
                        ),
                      ),
                      const Divider(
                        thickness: 1.0,
                        color: Colors.black,
                      ),
                      filteredCitiesTo.isEmpty
                          ? Container()
                          : SizedBox(
                              height: 200,
                              child: ListView.builder(
                                itemCount: filteredCitiesTo.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(filteredCitiesTo[index]),
                                    onTap: () {
                                      setState(() {
                                        to.text = filteredCitiesTo[index];
                                        filteredCitiesTo = [];
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                      ListTile(
                        leading: const Icon(Icons.date_range_rounded,
                              size: 35.0,
                              color: Colors.blue,
                        ),
                        title: TextField(
                          controller: date,
                          decoration: InputDecoration(
                            label: const Text("Date of Journey",style: TextStyle(
                              fontFamily: 'Raleway',
                            ),),
                            errorText: validateDate ? 'Empty date Field' : null,
                          ),
                          onTap: (){
                            selectDate();
                          },
                        ),
                      ),
                      const Divider(
                        thickness: 1.0,
                        color: Colors.black,
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                onPressed: (){
                                  date.text = DateTime.now().toString().split(" ")[0];
                                },
                                child: const Text("Today",style: TextStyle(
                                  fontFamily: 'Raleway',
                                ),)
                            ),
                            ElevatedButton(
                                onPressed: (){
                                  DateTime tomorrow = DateTime.now();
                                  date.text = tomorrow.add(const Duration(days: 1)).toString().split(" ")[0];
                                },
                                child: const Text("Tomorrow",style: TextStyle(
                                  fontFamily: 'Raleway',
                                ),)
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0,),
            Container(
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                  ),
                  onPressed: () async{
                    setState(() {
                      validateStart = from.text.isEmpty;
                      validateEnd = to.text.isEmpty;
                      validateDate = date.text.isEmpty;
                    });

                    if (!validateStart && !validateEnd && !validateDate) {

                      print('From : ${from.text}');
                      print('To : ${to.text}');
                      print('date: ${date.text}');

                      // FirebaseFirestore.instance
                      //     .collection('bus')
                      //     .where('from', isEqualTo: from.text)
                      //     .where('to', isEqualTo: to.text)
                      //     .where('startDate', isEqualTo: date.text)
                      //     .get()
                      //     .then((QuerySnapshot querySnapshot) {
                      bool check = await busService.SearchBus(from.text, to.text, date.text);
                      if(check){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Buses(from: from.text, to: to.text, date: date.text, uEmail: widget.uEmail,),
                          ),
                        );
                        setState(() {
                        });
                      }
                        /*if (querySnapshot.docs.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Buses(from: from.text, to: to.text, date: date.text, uEmail: widget.uEmail,),
                            ),
                          );
                          setState(() {
                          });
                        }*/

                        else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('No Buses Found'),
                                content: const Text('Sorry, no buses found for the given criteria.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      // })
                      //     .catchError((error) {
                      //   Text("Error getting documents: $error");
                      // });
                    }
                    else {
                      Toast.show(
                        'Empty Fields',
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Raleway',
                        ),
                        duration: 3,
                        gravity: Toast.bottom,
                        backgroundColor: Colors.red,
                      );
                    }
                  },
                  child: const Text("Search Buses",style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),)
              ),
            ),
            const SizedBox(height: 20.0,),
            const Text("What's New",style: TextStyle(
              fontFamily: 'Gabarito',
              fontSize: 25.0,
              letterSpacing: 0.5,
              fontWeight: FontWeight.bold,
            ),),
            const SizedBox(height: 20.0,),
            Container(
              padding: const EdgeInsets.all(20.0),
              height: 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(color: Colors.yellow),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFFffe747), Colors.white],
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Introducing Bus Timetable",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway',
                        ),),
                        SizedBox(height: 10.0,),
                        Text("Get Local bus Timings between cities in your state",style: TextStyle(
                          fontFamily: 'Raleway',
                        ),)
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image(
                            image: AssetImage(
                              'images/track.png',
                            ),
                            width: 150,
                            height: 105,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0,),
            Container(
              padding: const EdgeInsets.all(20.0),
              height: 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(color: Colors.blue),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFFa2d2ff), Colors.white],
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Flexi Ticket",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway',
                        ),),
                        SizedBox(height: 10.0,),
                        Text("Get amazing benifits on Date Change & Cancellation",style: TextStyle(
                          fontFamily: 'Raleway',
                        ),)
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage(
                            'images/flexiTicket.png',
                          ),
                          width: 170,
                          height: 115,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0,),
            Container(
              padding: const EdgeInsets.all(20.0),
              height: 210,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(color: Colors.orangeAccent),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFFffc971), Colors.white],
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Assurance Program",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway',
                        ),),
                        SizedBox(height: 10.0,),
                        Text("Insure your trip against cancellations and accidents !",style: TextStyle(
                          fontFamily: 'Raleway',
                        ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage(
                            'images/insurance.png',
                          ),
                          width: 170,
                          height: 135,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0,),
            Container(
              padding: const EdgeInsets.all(20.0),
              height: 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(color: Colors.pink),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFFff8fab), Colors.white],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Refer & Earn",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway',
                        ),),
                        SizedBox(height: 10.0,),
                        Text("Exciting rewards are only a tap away!",style: TextStyle(
                          fontFamily: 'Raleway',
                        ),)
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          'https://static.vecteezy.com/system/resources/previews/012/443/048/original/girl-holding-mobile-phone-with-advertisement-isolated-on-a-white-background-concept-of-social-promotion-refer-a-friend-refer-and-earn-referal-marketing-png.png',
                          fit: BoxFit.fill,
                          width: 160,
                          height: 115,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0,),
            Container(
              padding: const EdgeInsets.all(20.0),
              height: 182,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(color: Colors.green),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFF7bf1a8), Colors.white],
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Lightning Fast Refund",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway',
                        ),),
                        SizedBox(height: 10.0,),
                        Text("Get instant refund for your payments",style: TextStyle(
                          fontFamily: 'Raleway',
                        ),)
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage(
                            'images/refund.png',
                          ),
                          width: 170,
                          height: 105,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
