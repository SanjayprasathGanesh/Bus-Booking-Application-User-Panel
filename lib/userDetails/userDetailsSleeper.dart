import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:redbus/models/bookingModel.dart';
import 'package:redbus/models/busModel.dart';
import 'package:redbus/sidescreens/payments.dart';
import 'package:toast/toast.dart';
import '../database/busService.dart';

class UserDetailsSleeper extends StatefulWidget {
  final String docId;
  final List<String> seats;
  final String uEmail;
  const UserDetailsSleeper({Key? key, required this.docId, required this.seats, required this.uEmail}) : super(key: key);

  @override
  State<UserDetailsSleeper> createState() => _UserDetailsSleeperState();
}

class _UserDetailsSleeperState extends State<UserDetailsSleeper> {

  String busName = '',busNo = '', boarding = '', dropping = '', booked = '', from = '', to = '',
      startTime = '',endTime = '', startDate = '', endDate = '', type = '';
  int price = 0;

  BusService busService = BusService();
  List<String> seatsList = <String>[];
  List<String> boardingList = <String>[];
  List<String> droppingList = <String>[];
  List<String> user = <String>[];
  String selectedBoarding = '', selectedDropping = '';

  List<String> bookingList = <String>[];
  List<Map<String, dynamic>> allList = [];


  TextEditingController phoneNo = TextEditingController();
  TextEditingController email = TextEditingController();

  bool validatePhone = false, validateEmail = false, validateContact = true, validateIns = false;
  String ins = 'no';

  //For Semi Sleeper bus Alone
  getBusDetails() async{
    DocumentSnapshot documentSnapshot = await busService.GetBusDetails(widget.docId!);
    Map<String, dynamic>? bus = documentSnapshot.data() as Map<String, dynamic>?;
    setState(() {
      busNo = bus?['busNo'];
      busName = bus?['busName'];
      boarding = bus?['boarding'];
      dropping = bus?['dropping'];
      price = bus?['price'];
      from = bus?['from'];
      to = bus?['to'];
      type = bus?['type'];
      startTime = bus?['startTime'];
      endTime = bus?['endTime'];
      startDate = bus?['startDate'];
      endDate = bus?['endDate'];

      seatsList = widget.seats;
    });

    setState(() {
      boardingList = boarding.split(",");
      droppingList = dropping.split(",");
    });
  }

  @override
  void initState() {
    super.initState();
    getBusDetails();
    passengersList.clear();
  }

  String? busId;
  getBusId(String busName, String busNo, String start, String end, String type) async{
    BusModel busModel = BusModel();
    setState(() {
      busModel.busName = busName;
      busModel.busNo = busNo;
      busModel.startDate = start;
      busModel.endDate = end;
      busModel.busType = type;
    });

    QuerySnapshot querySnapshot = await busService.GetBusId(busModel);
    setState(() {
      busId = querySnapshot.docs[0].id;
    });
  }

  @override
  Widget build(BuildContext context) {
    getBusId(busName, busNo, startDate, endDate, type);
    setState(() {
      email.text = widget.uEmail;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Passenger Details",style:
        TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'Raleway'
        ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 350,
              width: double.infinity,
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                      color: const Color(0xFF03045e)
                  ),
                  color: const Color(0xFFabc4ff)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Center(
                    child: Text('Bus Details',style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text('Seats : $seatsList',style: const TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text('W -> Window Seat',style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 14.0,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text('Travels Name : $busName',style: const TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text('Bus Number : $busNo',style: const TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$from - $to',style: const TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text('Price : $price',style: const TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text('Timing : $startTime - $endTime',style: const TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text('Date : $startDate - $endDate',style: const TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
            const Text('Select Your Boarding Point',style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),),
            const SizedBox(
              height: 5.0,
            ),
            Container(
              height: (30 * boardingList.length).toDouble(),
              width: double.infinity,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: (boardingList.length / 2).ceil(),
                itemBuilder: (context, index) {
                  int firstIndex = index * 2;
                  int secondIndex = firstIndex + 1;

                  return Row(
                    children: [
                      if (firstIndex < boardingList.length)
                        Expanded(
                          child: ListTile(
                            leading: selectedBoarding == boardingList[firstIndex]
                                ? const Icon(Icons.circle, color: Colors.blue, size: 25.0,)
                                : const Icon(Icons.circle_outlined, size: 25.0,),
                            title: Text(
                              boardingList[firstIndex],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontFamily: 'Raleway',
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selectedBoarding = boardingList[firstIndex];
                              });
                            },
                          ),
                        ),
                      const SizedBox(width: 8.0),
                      if (secondIndex < boardingList.length)
                        Expanded(
                          child: ListTile(
                            leading: selectedBoarding == boardingList[secondIndex]
                                ? const Icon(Icons.circle, color: Colors.blue, size: 25.0,)
                                : const Icon(Icons.circle_outlined, size: 25.0,),
                            title: Text(
                              boardingList[secondIndex],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: 'Raleway'
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selectedBoarding = boardingList[secondIndex];
                              });
                            },
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
            const Text('Select Your Dropping Point',style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),),
            const SizedBox(
              height: 5.0,
            ),
            Container(
              height: (30 * droppingList.length).toDouble(),
              width: double.infinity,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: (droppingList.length / 2).ceil(),
                itemBuilder: (context, index) {
                  int firstIndex = index * 2;
                  int secondIndex = firstIndex + 1;
                  return Row(
                    children: [
                      if (firstIndex < droppingList.length)
                        Expanded(
                          child: ListTile(
                            leading: selectedDropping == droppingList[firstIndex]
                                ? const Icon(Icons.circle, color: Colors.blue, size: 25.0,)
                                : const Icon(Icons.circle_outlined, size: 25.0,),
                            title: Text(
                              droppingList[firstIndex],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontFamily: 'Raleway',
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selectedDropping = droppingList[firstIndex];
                              });
                            },
                          ),
                        ),
                      const SizedBox(width: 8.0),
                      if (secondIndex < droppingList.length)
                        Expanded(
                          child: ListTile(
                            leading: selectedDropping == droppingList[secondIndex]
                                ? const Icon(Icons.circle, color: Colors.blue, size: 25.0,)
                                : const Icon(Icons.circle_outlined, size: 25.0,),
                            title: Text(
                              droppingList[secondIndex],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontFamily: 'Raleway',
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selectedDropping = droppingList[secondIndex];
                              });
                            },
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            const Text('Please fill the Passenger Details',style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),),
            const SizedBox(
              height: 5.0,
            ),
            Container(
              height: seatsList.length * 430,
              width: double.infinity,
              child: Column(
                children: [
                  for(int i = 0;i < seatsList.length;i++)
                    SizedBox(
                      height: 430, // Adjust the height as needed
                      child: PassengerDetails(seatNo: seatsList[i]),
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              'Contact Info',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway',
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            contactInfo(),
            const SizedBox(
              height: 10.0,
            ),
            assuranceProgram(),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ins == 'yes' ? Text('Price : ₹${(price * seatsList.length) + (seatsList.length * 22)}',style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway',
              fontSize: 15.0,
            ),) :
            Text('Price : ₹${price * seatsList.length}',style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway',
              fontSize: 15.0,
            ),),
            CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.blue,
              child: IconButton(
                onPressed: () async{
                  ToastContext().init(context);

                  validatePhone = phoneNo.text.isEmpty;
                  validateEmail = email.text.isEmpty;

                  if(!validatePhone && !validateEmail && passengersList.isNotEmpty && boarding.isNotEmpty && dropping.isNotEmpty){

                    if(allList.isNotEmpty){
                      allList.clear();
                      bookingList.clear();
                    }

                    BookingModel bookingModel = BookingModel();
                    bookingModel.uEmail = widget.uEmail;
                    bookingModel.busId = busId!;
                    bookingModel.busNo = busNo!;
                    bookingModel.busName = busName!;
                    bookingModel.from = from!;
                    bookingModel.to = to!;
                    bookingModel.busType = type!;
                    bookingModel.startDate = startDate!;
                    bookingModel.endDate = endDate!;
                    bookingModel.startTime = startTime!;
                    bookingModel.endTime = endTime!;
                    bookingModel.seats = seatsList.toString()!;

                    for(int i = 0;i < passengersList.length;i++){
                      bookingList.add('${seatsList.elementAt(i)}, ${passengersList.elementAt(i)}');
                    }

                    bookingModel.boarding = selectedBoarding!;
                    bookingModel.dropping = selectedDropping!;
                    bookingModel.ttlPrice = ins == 'yes' ? (price * seatsList.length) + (seatsList.length * 22) : price * seatsList.length!;
                    bookingModel.passengerDetails = bookingList!;
                    bookingModel.phoneNum = phoneNo.text!;
                    bookingModel.email = email.text!;
                    bookingModel.status = 'Confirmed';

                    allList.add(bookingModel.bookingMap());
                    print('All List : ${allList}');

                    Navigator.push(context, MaterialPageRoute(builder: (context) => Payments(bookingList: allList, uEmail: widget.uEmail,)));
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
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.navigate_next_sharp,color: Colors.white,size: 30.0,),
              ),
            ),
          ],
        )
      ],
    );
  }

  contactInfo(){
    return Container(
      height: 320,
      width: double.infinity,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          TextField(
            decoration: InputDecoration(
              label: const Text('Enter Phone Number ',style: TextStyle(
                color: Colors.blue,
                fontFamily: 'Raleway',
              ),),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  )
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  )
              ),
              errorText: validatePhone ? 'Empty Phone Number Field' : null,
            ),
            keyboardType: TextInputType.phone,
            controller: phoneNo,
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextField(
            decoration: InputDecoration(
              label: const Text('Enter Email ID ',style: TextStyle(
                color: Colors.blue,
                fontFamily: 'Raleway',
              ),),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  )
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  )
              ),
              errorText: validateEmail ? 'Empty Email Field' : null,
            ),
            keyboardType: TextInputType.emailAddress,
            controller: email,
            onChanged: (String? value){
              setState(() {
                email.text = value!;
              });
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            'Your Tickets will be sent to this Contact',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway',
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Send Booking details and trip updates on - ${phoneNo.text}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Raleway',
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: validateContact,
                  onChanged: (bool? newValue){
                    setState(() {
                      validateContact = !validateContact;
                    });
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  assuranceProgram(){
    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          const Text('Assurance Program',style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
            fontSize: 15.0,
          ),),
          const SizedBox(
            height: 10.0,
          ),
          ListTile(
            leading: IconButton(
              onPressed: (){
                setState(() {
                  ins = 'yes';
                });
              },
              icon: ins == 'yes' ? const Icon(Icons.circle,size: 25.0,color: Colors.blue,) : const Icon(Icons.circle_outlined, size: 25.0,),
            ),
            title: const Text('Yes, Protect my trip at ₹ 22 per Passenger',style: TextStyle(
              color: Colors.black,
              fontFamily: 'Raleway',
              fontSize: 13.0,
            ),),
          ),
          ListTile(
            leading: IconButton(
              onPressed: (){
                setState(() {
                  ins = 'no';
                });
              },
              icon: ins == 'no' ? const Icon(Icons.circle,size: 25.0,color: Colors.blue,) : const Icon(Icons.circle_outlined, size: 25.0,),
            ),
            title: const Text('No, I would like to proceed without insurance',style: TextStyle(
              color: Colors.black,
              fontFamily: 'Raleway',
              fontSize: 13.0,
            ),),
          )
        ],
      ),
    );
  }
}

class Passenger {
  String? name;
  String? age;
  String? gender;

  psMap(){
    var mapping = Map<String, dynamic>();
    mapping['name'] = name!;
    mapping['age'] = age!;
    mapping['gender'] = gender!;
    return mapping;
  }
}

List<Map<String, dynamic>> passengersList = [];
List<Map<String, dynamic>> contactList = [];

class PassengerDetails extends StatefulWidget {
  final String seatNo;
  const PassengerDetails({Key? key, required this.seatNo}) : super(key: key);

  @override
  _PassengerDetailsState createState() => _PassengerDetailsState();
}

class _PassengerDetailsState extends State<PassengerDetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String gender = 'Male';

  bool validateName = false, validateAge = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: generatePassenger(),
    );
  }

  Widget generatePassenger() {
    return Container(
      height: 560,
      width: double.infinity,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Text(
            'Seat Number : ${widget.seatNo!}',
            style: const TextStyle(
              color: Colors.blue,
              fontFamily: 'Raleway',
            ),
            textAlign: TextAlign.end,
          ),
          const SizedBox(height: 10.0),
          TextField(
            decoration: InputDecoration(
              label: const Text('Enter Passenger Name',
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
              errorText: validateName ? 'Empty Name Field' : null,
            ),
            keyboardType: TextInputType.text,
            controller: nameController,
          ),
          const SizedBox(height: 10.0),
          TextField(
            decoration: InputDecoration(
              label: const Text('Enter Passenger Age',
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
              errorText: validateAge ? 'Empty Age Field' : null,
            ),
            keyboardType: TextInputType.number,
            controller: ageController,
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      gender = 'Male';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gender == 'Male' ? Colors.blue : Colors.blueGrey,
                  ),
                  child: const Text(
                    'Male',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Raleway',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5.0),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      gender = 'Female';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gender == 'Female' ? Colors.blue : Colors.blueGrey,
                  ),
                  child: const Text(
                    'Female',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Raleway',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5.0),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      gender = 'Others';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gender == 'Others' ? Colors.blue : Colors.blueGrey,
                  ),
                  child: const Text(
                    'Others',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Raleway',
                    ),
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                validateName = nameController.text.isEmpty;
                validateAge = ageController.text.isEmpty;
              });

              if (!validateName && !validateAge && gender.isNotEmpty) {
                Passenger passenger = Passenger();
                passenger.name = nameController.text;
                passenger.age = ageController.text;
                passenger.gender = gender;
                passengersList.add(passenger.psMap());

                ToastContext().init(context);
                Toast.show(
                  'Saved',
                  duration: 3,
                  gravity: Toast.bottom,
                  backgroundColor: Colors.green,
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Raleway',
                  ),
                );
              }
              else {
                ToastContext().init(context);
                Toast.show(
                  'Empty Passenger Fields',
                  duration: 3,
                  gravity: Toast.bottom,
                  backgroundColor: Colors.red,
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Raleway',
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Raleway',
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          const Text('Hit the Save Button once you fill the Passenger Details',style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w600,
          ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

