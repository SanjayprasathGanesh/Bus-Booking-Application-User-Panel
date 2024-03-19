import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redbus/database/busService.dart';
import 'package:redbus/models/rentBusModel.dart';
import 'package:toast/toast.dart';

class RentABus extends StatefulWidget {
  final String uEmail;
  const RentABus({Key? key, required this.uEmail}) : super(key: key);

  @override
  State<RentABus> createState() => _RentABusState();
}

class _RentABusState extends State<RentABus> {

  TextEditingController phone = TextEditingController();
  TextEditingController from = TextEditingController();
  TextEditingController to = TextEditingController();
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  TextEditingController ttlDays = TextEditingController();
  String busType = 'Non AC-Semi Sleeper';
  String reqDriver = 'Self Drived';

  BusService busService = BusService();

  bool validatePhone = false, validateFrom = false, validateTo = false, validateFromDate = false, validateToDate = false, validateTtlDays = false;

  selectFromDate() async{
    DateTime? selected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year+1)
    );

    if(selected != null){
      setState(() {
        fromDate.text = selected.toString().split(" ")[0];
        if(toDate.text.isNotEmpty && selected.isBefore(DateTime.parse(fromDate.text))) {
          Duration duration = selected.difference(DateTime.parse(toDate.text));
          ttlDays.text = duration.inDays.toString();
        }
        else{
          Toast.show(
            'From Date should be before To Date',
            duration: 3,
            textStyle: const TextStyle(
              fontFamily: 'Raleway',
            ),
            backgroundColor: Colors.red,
          );
        }
      });
    }
  }

  selectToDate() async{
    DateTime? selected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year+1)
    );

    if(selected != null){
      setState(() {
        toDate.text = selected.toString().split(" ")[0];
        if(fromDate.text.isNotEmpty && selected.isAfter(DateTime.parse(fromDate.text))) {
          Duration duration = selected.difference(DateTime.parse(fromDate.text));
          ttlDays.text = duration.inDays.toString();
        }
        else{
          Toast.show(
            'From Date should be before To Date',
            duration: 3,
            textStyle: const TextStyle(
              fontFamily: 'Raleway',
            ),
            backgroundColor: Colors.red,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rent a Bus",style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway'
        ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                decoration: InputDecoration(
                    label: const Text("Enter Your Phone Number",style: TextStyle(
                        fontFamily: 'Raleway'
                    ),),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        )
                    ),
                    errorText: validatePhone ? 'Empty Phone Number Field' : null,
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    )
                ),
                controller: phone,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                decoration: InputDecoration(
                  label: const Text("From",style: TextStyle(
                      fontFamily: 'Raleway'
                  ),),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      )
                  ),
                  errorText: validateFrom ? 'Empty From Field' : null,
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  )
                ),
                controller: from,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                decoration: InputDecoration(
                    label: const Text("To",style: TextStyle(
                        fontFamily: 'Raleway'
                    ),),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        )
                    ),
                    errorText: validateTo ? 'Empty To Field' : null,
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    )
                ),
                controller: to,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          label: const Text("From Date",style: TextStyle(
                              fontFamily: 'Raleway'
                          ),),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                              )
                          ),
                          errorText: validateFromDate ? 'Empty From Date Field' : null,
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          )
                      ),
                      controller: fromDate,
                      readOnly: true,
                      onTap: (){
                        selectFromDate();
                      },
                      // keyboardType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          label: const Text("To Date",style: TextStyle(
                              fontFamily: 'Raleway'
                          ),),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                              )
                          ),
                          errorText: validateToDate ? 'Empty To Field' : null,
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          )
                      ),
                      controller: toDate,
                      readOnly: true,
                      onTap: (){
                        selectToDate();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                decoration: InputDecoration(
                    label: const Text("Total Days",style: TextStyle(
                        fontFamily: 'Raleway'
                    ),),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        )
                    ),
                    errorText: validateTtlDays ? 'Empty Total Days Field' : null,
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    )
                ),
                controller: ttlDays,
                readOnly: true,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text("Select the Bus Type",style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway'
              ),),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0)
                ),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    DropdownButton<String>(
                      value: busType,
                      onChanged: (String? newValue) {
                        setState(() {
                          busType = newValue!;
                          print(busType);
                        });
                      },
                      isExpanded: true,
                      items: <String>[
                        'Non AC-Semi Sleeper',
                        'AC-Semi Sleeper',
                        'Non AC-Sleeper',
                        'AC-Sleeper',
                        'Non-AC Seater cum Sleeper',
                        'AC Seater cum Sleeper',
                        'AC-Seater Volvo Multi Axle',
                        'AC-Sleeper Benz',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style: const TextStyle(
                            fontFamily: 'Raleway',
                          ),),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text("Select the Required Driver Count",style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway'
              ),),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0)
                ),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    DropdownButton<String>(
                      value: reqDriver,
                      onChanged: (String? newValue) {
                        setState(() {
                          reqDriver = newValue!;
                          print(reqDriver);
                        });
                      },
                      isExpanded: true,
                      items: <String>[
                        'Self Drived',
                        'Required 1 Driver',
                        'Required 2 Driver',
                        'Required 3 Driver',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style: const TextStyle(
                            fontFamily: 'Raleway',
                          ),),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text('Bus Rent : 100km = Rs 15000 / Depends On Bus Type',style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
              ),),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: (){
                      setState(() {
                        phone.clear();
                        from.clear();
                        to.clear();
                        fromDate.clear();
                        toDate.clear();
                        ttlDays.clear();
                        busType = 'Non AC-Semi Sleeper';
                        reqDriver = 'Self Drived';
                      });
                    },
                    child: const Text('CLEAR',style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () async{
                        setState(() {
                          validatePhone = phone.text.isEmpty;
                          validateFrom = from.text.isEmpty;
                          validateTo = to.text.isEmpty;
                          validateFromDate = fromDate.text.isEmpty;
                          validateToDate = toDate.text.isEmpty;
                          validateTtlDays = ttlDays.text.isEmpty;
                        });

                        if(!validatePhone && !validateFrom && !validateTo && !validateFromDate && !validateToDate && !validateTtlDays){
                          RentBusModel r = RentBusModel();
                          r.uEmail = widget.uEmail;
                          r.phone = phone.text;
                          r.from = from.text;
                          r.to = to.text;
                          r.fromDate = fromDate.text;
                          r.toDate = toDate.text;
                          r.ttlDays = int.parse(ttlDays.text);
                          r.busType = busType;
                          r.reqDriver = reqDriver;
                          r.isAssigned = false;

                          busService.RentBus(r);
                          Toast.show(
                            'Your Request has been Submitted',
                            duration: 3,
                            textStyle: const TextStyle(
                              fontFamily: 'Raleway',
                            ),
                            backgroundColor: Colors.green,
                          );
                          bookingConfirmed();
                          Future.delayed(const Duration(seconds: 1), () {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          });
                        }
                        else{
                          Toast.show(
                            'OOPS Empty Fields, Your Request has not Submitted',
                            duration: 3,
                            textStyle: const TextStyle(
                              fontFamily: 'Raleway',
                            ),
                            backgroundColor: Colors.red,
                          );
                        }

                      },
                      child: const Text('SUBMIT',style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bookingConfirmed(){
    showDialog(
        context: context,
        builder: (param){
          return const AlertDialog(
            title: Text('Request Sent',style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
            ),),
            content: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,color: Colors.green,size: 50.0,
                  ),
                  Text(
                    'Your booking has been submitted!, contacted with the Bus Operator and the Bus Operator will reach you within a short Duration',
                    style: TextStyle(fontSize: 20, fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        }
    ).then((value) {
      // Use Future.delayed to pop the dialog after 5 seconds
      Future.delayed(Duration(seconds: 4), () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      });
    });
  }
}
