import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redbus/models/bookingModel.dart';
import 'package:redbus/models/busModel.dart';
import 'package:redbus/models/contactusModel.dart';
import 'package:redbus/models/rentBusModel.dart';

import '../models/userModel.dart';

class Repository{

  Future<bool> searchBus(String from, String to, String date) async {
    try {

      QuerySnapshot querySnapshot = await FirebaseFirestore
          .instance
          .collection('bus')
          .where('startDate', isEqualTo: date)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          String routes = doc['routes'];

          if (routes.contains(from) && routes.contains(to)) {
            return true;
          }
        }
      }
    } catch (e) {
      print('Error searching for buses: $e');
    }
    return false;
  }

  Future<QuerySnapshot<Object?>?> getSearchedBus(String from, String to, String date) async {
    try {

      QuerySnapshot querySnapshot = await FirebaseFirestore
          .instance
          .collection('bus')
          .where('startDate', isEqualTo: date)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          String routes = doc['routes'];

          if (routes.contains(from) && routes.contains(to)) {
            return querySnapshot;
          }
        }
      }
    } catch (e) {
      print('Error searching for buses: $e');
    }
    return null;
  }


  Future<DocumentSnapshot> getBusDetails(String docId) async{
    return await FirebaseFirestore
        .instance
        .collection('bus')
        .doc(docId)
        .get();
  }

  Future<QuerySnapshot> getBusId(Map<String, dynamic> busMap) async{
    return await FirebaseFirestore
        .instance
        .collection('bus')
        .where('busName', isEqualTo: busMap?['busName'])
        .where('busNo', isEqualTo: busMap?['busNo'])
        .where('startDate', isEqualTo: busMap?['startDate'])
        .where('endDate', isEqualTo: busMap?['endDate'])
        .where('type', isEqualTo: busMap?['busType'])
        .get();
  }

  Future<void> updateBookedSeats(String id, String seat) async {
    try {
      // Get the booked Seats
      DocumentSnapshot<Map<String, dynamic>> seatsDoc = await FirebaseFirestore.instance
          .collection('bus')
          .doc(id)
          .get();

      String s = '';
      if (seatsDoc.exists) {
        String currentSeats = seatsDoc.data()?['bookedSeats'] ?? '';
        s = '$currentSeats $seat,';
      } else {
        s = '$seat,';
      }

      await FirebaseFirestore
          .instance
          .collection('bus')
          .doc(id)
          .update({'bookedSeats': s });

    } catch (e) {
      print('Error updating booked seats: $e');
      // Handle the error as needed
    }
  }


  Future<void> addBookings(Map<String, dynamic> bookingMap) async{
    return await FirebaseFirestore
        .instance
        .collection('bookings')
        .doc()
        .set(bookingMap);
  }

  Future<QuerySnapshot> getBookings(String uEmail) async{
    return await FirebaseFirestore
        .instance
        .collection('bookings')
        .where('uEmail', isEqualTo: uEmail)
        .get();
  }
  
  Future<void> updateCancel(String docId) async{
    return await FirebaseFirestore
        .instance
        .collection('bookings')
        .doc(docId)
        .update({
          'status': 'Cancelled',
        });
  }

  // Future<void> updateCancelledSeats(String id, String seat) async {
  //   try {
  //     // Get the booked Seats
  //     DocumentSnapshot<Map<String, dynamic>> seatsDoc = await FirebaseFirestore.instance
  //         .collection('bus')
  //         .doc(id)
  //         .get();
  //
  //     String s = '';
  //     if (seatsDoc.exists) {
  //       String currentSeats = seatsDoc.data()?['bookedSeats'] ?? '';
  //
  //       List<String> seatSections = currentSeats.split('],');
  //
  //       for (int i = 0; i < seatSections.length; i++) {
  //         String section = seatSections[i].trim().replaceAll('[', '').replaceAll(']', '');
  //         List<String> seats = section.split(', ');
  //         seats.removeWhere((ss) => seat.contains(ss));
  //
  //         // Join the remaining seats back into the section
  //         seatSections[i] = '[${seats.join(', ')}]';
  //       }
  //
  //       // Join the sections back into the final seat string
  //       s = seatSections.join(',');
  //
  //     }
  //
  //     await FirebaseFirestore
  //         .instance
  //         .collection('bus')
  //         .doc(id)
  //         .update({'bookedSeats': s });
  //
  //   } catch (e) {
  //     print('Error updating booked seats: $e');
  //   }
  // }

  Future<void> updateCancelledSeats(String busId, String seat) async {
    print(seat);
    try {
      // Get the bookedSeats
      DocumentSnapshot<Map<String, dynamic>> busDoc = await FirebaseFirestore.instance
          .collection('bus')
          .doc(busId)
          .get();

      print('BusDoc: ${busDoc.data()}');

      if (busDoc.exists) {
        print('Entering If');
        String prevSeats = busDoc.data()?['bookedSeats'];
        print('prevSeats : $prevSeats');
        List<dynamic> bookedSeats = prevSeats.split(',');
        print('Before: $bookedSeats');
        bookedSeats = bookedSeats.map((string) => string.trim()).toList();
        print('Before 1: $bookedSeats');
        // Remove the specified seat
        /*bookedSeats.forEach((section) {
          if (section is List<dynamic> && section.contains('[$seat]')) {
            section.remove('[$seat]');
          }
        });*/

        for(int i = 0;i < bookedSeats.length;i++){
          print('Specific Element: ${bookedSeats.elementAt(i)}');
          if(bookedSeats.elementAt(i) == seat){
            bool check = bookedSeats.remove(seat);
            print(check);
            print(bookedSeats);
          }
        }

        print('After : $bookedSeats');

        // Update the bookedSeats field
        await FirebaseFirestore
            .instance
            .collection('bus')
            .doc(busId)
            .update({'bookedSeats': bookedSeats.join(',')});
      }
    }
    catch (e) {
      print('Error updating booked seats: $e');
    }
  }



  Future<void> rentABus(RentBusModel rentBusModel) async{
    return await FirebaseFirestore
        .instance
        .collection('bus rent')
        .doc()
        .set(rentBusModel.rentMap());
  }

  Future<void> contactUs(ContactUsModel contactUsModel) async{
    return await FirebaseFirestore
        .instance
        .collection('user contact forms')
        .doc()
        .set(contactUsModel.contactMap());
  }

  Future<void> createWallet(String uEmail, String busName, String busNo, String date, int price) async{
    return await FirebaseFirestore
        .instance
        .collection('user wallet')
        .doc()
        .set({
          'uEmail': uEmail,
          'busName': busName,
          'busNo': busNo,
          'date': date,
          'price': price,
          'isUsed': false,
          'usedFor': '-',
          'usedOn': '-',
        });
  }

  Future<QuerySnapshot> readWallet(String uEmail) async{
    return await FirebaseFirestore
        .instance
        .collection('user wallet')
        .where('uEmail', isEqualTo: uEmail)
        .where('isUsed', isEqualTo: false)
        .get();
  }

  Future<QuerySnapshot> readWalletHistroy(String uEmail) async{
    return await FirebaseFirestore
        .instance
        .collection('user wallet')
        .where('uEmail', isEqualTo: uEmail)
        .where('isUsed', isEqualTo: true)
        .get();
  }

  Future<int?> getTotalPriceFromWallet(String uEmail) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore
        .instance
        .collection('user wallet')
        .where('uEmail', isEqualTo: uEmail)
        .where('isUsed', isEqualTo: false)
        .get();

    int? totalPrice = 0;

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (data['price'] != null && data['price'] is int) {
        int? n = data?['price'];
        totalPrice = (totalPrice! + (n!));
      }
    }

    return totalPrice;
  }

  Future<void> updateWallet(String email, String busNo, String date, String usedFor, String usedOn) async{

    QuerySnapshot qs = await FirebaseFirestore
        .instance
        .collection('user wallet')
        .where('uEmail', isEqualTo: email)
        .where('busNo', isEqualTo: busNo)
        .where('date', isEqualTo: date)
        .where('isUsed', isEqualTo: false)
        .get();

    String id = qs.docs[0].id;

    return await FirebaseFirestore
        .instance
        .collection('user wallet')
        .doc(id)
        .update({
          'isUsed': true,
          'usedFor': usedFor,
          'usedOn': usedOn,
        });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllOffers() async{
    return await FirebaseFirestore
        .instance
        .collection('offers')
        .get();
  }

  Future<QuerySnapshot> getAllRoutes() async{
    return await FirebaseFirestore
        .instance
        .collection('bus')
        .get();
  }
  
  Future<bool> checkUser(String uEmail, String psw) async{
    QuerySnapshot querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('uEmail', isEqualTo: uEmail)
        .where('psw', isEqualTo: psw)
        .get();

    print(querySnapshot.size);

    if(querySnapshot.size >= 1){
      return true;
    }
    return false;
  }

  Future<void> addUser(UserModel userModel) async{
    return await FirebaseFirestore
        .instance
        .collection('users')
        .doc()
        .set(userModel.userMap());
  }

  Future<QuerySnapshot> getUser(String uEmail) async{
    return await FirebaseFirestore
        .instance
        .collection('users')
        .where('uEmail', isEqualTo: uEmail)
        .get();
  }

  Future<void> updateUser(String docId, UserModel userModel) async{
    return await FirebaseFirestore
        .instance
        .collection('users')
        .doc(docId)
        .update({
          'uEmail': userModel.uEmail,
          'name': userModel.name,
          'phoneNum': userModel.phoneNum,
          'dob': userModel.dob,
          'age': userModel.age,
          'gender': userModel.gender,
          'psw': userModel.psw,
        });
  }

  Future<void> deleteUser(String docId) async{
    return await FirebaseFirestore
        .instance
        .collection('users')
        .doc(docId)
        .delete();
  }

  Future<QuerySnapshot> getSPBus(String from,String to,String date) async{
    return FirebaseFirestore.instance
        .collection('bus')
        .where('from', isEqualTo: from)
        .where('to', isEqualTo: to)
        .where('startDate', isEqualTo: date)
        .get();
  }

}
