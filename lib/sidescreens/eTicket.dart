import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share/share.dart';

class ETicket extends StatelessWidget {
  Map<String, dynamic> bookingsMap;
  final String uEmail;
  ETicket({Key? key, required this.bookingsMap, required this.uEmail}) : super(key: key);

  showTicketDetails(){
    print('${bookingsMap?['startTime']}');
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
        border: Border.all(
          color: Colors.blue,
          width: 3.0
        ),
        borderRadius: BorderRadius.circular(13.0)
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(child: Image(image: AssetImage('images/logo.jpg'),width: 350,height: 200,)),
          Text('${bookingsMap?['from']} - ${bookingsMap?['to']}',style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
          ),),
          Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Passenger Details',style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                    ),),
                    const SizedBox(height: 10),
                    // 3rd Row
                    Text('${bookingsMap?['passengerDetails']}',style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Raleway',
                    ),
                    ),
                    const SizedBox(height: 10),
                  ]
              )
          ),
          Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Bus Details',style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                    ),),
                    const SizedBox(height: 10),
                    Text('Bus Type: ${bookingsMap?['busType']}',style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Raleway',
                    ),),
                    const SizedBox(height: 10),
                    // 4th Row
                    Text('Boarding : ${bookingsMap?['boarding']}',style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Raleway',
                    ),),
                    const SizedBox(height: 10),
                    Text('Dropping : ${bookingsMap?['dropping']}',style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Raleway',
                    ),),
                    const SizedBox(height: 10),
                    // 5th Row
                    Text('Start Time: ${bookingsMap?['startTime']}',style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Raleway',
                    ),),
                    const SizedBox(height: 10),
                    Text('End Time: ${bookingsMap?['endTime']}',style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Raleway',
                    ),),
                    const SizedBox(height: 10),
                    Text('Bus Name: ${bookingsMap?['busName']}',style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Raleway',
                    ),),
                    const SizedBox(height: 10),
                    Text('Bus Number: ${bookingsMap?['busNo']}',style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Raleway',
                    ),),
                  ]
              )
          )
        ],
      ),
    );
  }

  Future<void> _generateAndDownloadETicket() async {
    final pdf = pw.Document();
    final ByteData data = await rootBundle.load('images/logo.jpg');
    final Uint8List imageBytes = data.buffer.asUint8List();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(15.0),
            decoration: pw.BoxDecoration(
              borderRadius: pw.BorderRadius.circular(10.0),
              border: const pw.Border(
                top: pw.BorderSide(color: PdfColors.blue, width: 10.0),
                bottom: pw.BorderSide(color: PdfColors.blue, width: 10.0),
                left: pw.BorderSide(color: PdfColors.blue, width: 10.0),
                right: pw.BorderSide(color: PdfColors.blue, width: 10.0)
              )
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Image(pw.MemoryImage(imageBytes), width: 200, height: 500),
                    pw.SizedBox(width: 20),
                    pw.Text('Travel Queries', style: const pw.TextStyle(fontSize: 16)),
                  ],
                ),
                pw.SizedBox(height: 5),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.SizedBox(width: 10),
                    // pw.SizedBox(width: 20),
                    pw.Text('Call +91-9360227091, +0422 409 409', style: const pw.TextStyle(fontSize: 15)),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Divider(
                  height: 3.0,
                  thickness: 5.0,
                ),
                pw.SizedBox(height: 10),
                // 2nd Row
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Date: ${DateTime.now().toString().split(" ")[0]}',style: const pw.TextStyle(fontSize: 15)),

                    pw.Text('Travels Name: ${bookingsMap?['busName']}',style: const pw.TextStyle(fontSize: 15)),

                    pw.Text('Price : ${bookingsMap?['ttlPrice'] / bookingsMap?['seats'].toString()
                        .replaceAll(RegExp(r'[^0-9,]'), '')
                        .split(',')
                        .map((seat) => int.parse(seat.trim()))
                        .toList().length}',
                        style: const pw.TextStyle(fontSize: 15)),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Divider(
                  height: 3.0,
                  thickness: 5.0,
                ),
                pw.SizedBox(height: 20),
                pw.Text('${bookingsMap?['from']} - ${bookingsMap?['to']}',style: const pw.TextStyle(fontSize: 15)),
                pw.SizedBox(height: 20),
                pw.Container(
                  padding: const pw.EdgeInsets.all(10.0),
                  decoration: pw.BoxDecoration(
                    borderRadius: pw.BorderRadius.circular(15.0),
                    border: const pw.Border(
                        top: pw.BorderSide(color: PdfColors.green, width: 5.0),
                        bottom: pw.BorderSide(color: PdfColors.green, width: 5.0),
                        left: pw.BorderSide(color: PdfColors.green, width: 5.0),
                        right: pw.BorderSide(color: PdfColors.green, width: 5.0)
                    )
                  ),
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Passenger Details',style: pw.TextStyle(
                        fontSize: 15,
                        fontWeight: pw.FontWeight.bold,
                      ),),
                      pw.SizedBox(height: 10),
                      // 3rd Row
                      pw.Text('${bookingsMap?['passengerDetails']}',style: const pw.TextStyle(
                        fontSize: 15,
                      ),
                      ),
                      pw.SizedBox(height: 10),
                    ]
                  )
                ),
                pw.SizedBox(height: 20),
                pw.Container(
                    padding: const pw.EdgeInsets.all(10.0),
                    decoration: pw.BoxDecoration(
                        borderRadius: pw.BorderRadius.circular(15.0),
                        border: const pw.Border(
                            top: pw.BorderSide(color: PdfColors.green, width: 5.0),
                            bottom: pw.BorderSide(color: PdfColors.green, width: 5.0),
                            left: pw.BorderSide(color: PdfColors.green, width: 5.0),
                            right: pw.BorderSide(color: PdfColors.green, width: 5.0)
                        )
                    ),
                  child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                      pw.Text('Bus Details',style: pw.TextStyle(
                        fontSize: 15,
                        fontWeight: pw.FontWeight.bold,
                      ),),
                      pw.SizedBox(height: 10),
                      pw.Text('Bus Type: ${bookingsMap?['busType']}',style: const pw.TextStyle(
                        fontSize: 15,
                      ),),
                      pw.SizedBox(height: 5),
                      // 4th Row
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Boarding : ${bookingsMap?['boarding']}',style: const pw.TextStyle(
                            fontSize: 15,
                          ),),
                          pw.SizedBox(height: 10),
                          pw.Text('Dropping : ${bookingsMap?['dropping']}',style: const pw.TextStyle(
                            fontSize: 15,
                          ),),
                        ],
                      ),
                        pw.SizedBox(height: 5),
                      // 5th Row
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Start Time: ${bookingsMap?['startTime']}',style: const pw.TextStyle(
                            fontSize: 15,
                          ),),
                          pw.SizedBox(height: 10),
                          pw.Text('End Time: ${bookingsMap?['endTime']}',style: const pw.TextStyle(
                            fontSize: 15,
                          ),),
                        ],
                      ),
                        pw.SizedBox(height: 5),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Bus Name: ${bookingsMap?['busName']}',style: const pw.TextStyle(
                            fontSize: 15,
                          ),),
                          pw.SizedBox(width: 20),
                          pw.Text('Bus Number: ${bookingsMap?['busNo']}',style: const pw.TextStyle(
                            fontSize: 15,
                          ),),
                        ],
                      ),
                    ]
                  )
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Payment Type: ${bookingsMap?['paymentMode']}',style: const pw.TextStyle(
                      fontSize: 15,
                    ),),
                    pw.SizedBox(width: 20),
                    pw.Text('Total Price:  ${bookingsMap?['ttlPrice']}',style: pw.TextStyle(
                      fontSize: 15,
                      fontWeight: pw.FontWeight.bold,
                    ),),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Terms and Conditions',
                  style: pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(
                  '1. Booking a ticket implies acceptance of the terms and conditions outlined below.',
                  style: const pw.TextStyle(fontSize: 12),
                ),
                pw.Text(
                  '2. Tickets are non-transferable and non-refundable once the journey has commenced.',
                  style: const pw.TextStyle(fontSize: 12),
                ),
                pw.Text(
                  '3. The bus company reserves the right to alter the bus type, boarding, and dropping points without prior notice.',
                  style: const pw.TextStyle(fontSize: 12),
                ),
                pw.Text(
                  '4. Passengers are responsible for boarding the bus at least 30 minutes before the scheduled departure time.',
                  style: const pw.TextStyle(fontSize: 12),
                ),
                pw.Text(
                  '5. Smoking, consuming alcohol, and carrying illegal substances are strictly prohibited on the bus.',
                  style: const pw.TextStyle(fontSize: 12),
                ),
                pw.Text(
                  '6. The bus company is not liable for any loss or damage to passengers\' belongings during the journey.',
                  style: const pw.TextStyle(fontSize: 12),
                ),
                pw.Text(
                  '7. Children below the age of 12 must be accompanied by an adult. Child fares apply to children aged 2 to 12.',
                  style: const pw.TextStyle(fontSize: 12),
                ),
                pw.Text(
                  '8. In case of cancellations or rescheduling, passengers will be informed via the contact details provided during booking.',
                  style: const pw.TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );

    // Save the PDF to a Uint8List
    final Uint8List pdfBytes = await pdf.save();

    // Save the PDF to a file
    const String fileName = 'e_ticket.pdf';
    final String directoryPath = (await getTemporaryDirectory()).path;
    final String filePath = '$directoryPath/$fileName';

    await File(filePath).writeAsBytes(pdfBytes);

    // Share the file using the share package
    Share.shareFiles([filePath], text: 'Your E-Ticket for the Upcoming Journey');
  }

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
                const Text('Note : If you give Yes, then you will be redirected to the Home Page',style: TextStyle(fontFamily: 'Raleway'),),
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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => moveBack(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("E-Ticket",style:
          TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              fontFamily: 'Raleway'
          ),),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 5),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Your Ticket Has been Booked Successfully",style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Raleway'
                ),textAlign: TextAlign.center,),
              ),
              const SizedBox(height: 5),
              showTicketDetails(),
              const SizedBox(height: 10),
              // Download button
              const Row(
                children: [
                  Expanded(
                    child: ListTile(
                      leading: Icon(Icons.date_range_outlined,color: Colors.grey,),
                      title: Text('Change Date',style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontFamily: 'Raleway',
                      ),),
                      enabled: false,
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: Icon(Icons.clear_outlined,color: Colors.grey,),
                      title: Text('Cancel',style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontFamily: 'Raleway',
                      ),),
                      enabled: false,
                    ),
                  ),
                ],
              ),
              Center(
                child: ListTile(
                  leading: const Icon(Icons.share_sharp,color: Colors.blue,),
                  title: const Text('Share',style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Raleway',
                  ),),
                  onTap: _generateAndDownloadETicket,
                ),
              ),
              Container(
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                    child: const Text('Back to Home',style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Raleway',
                    ),),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text('Have a Safe Journey',textAlign: TextAlign.center,style: TextStyle(
                color: Colors.blue,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway',
              ),),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
