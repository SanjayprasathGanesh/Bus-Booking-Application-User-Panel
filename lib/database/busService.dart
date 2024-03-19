import 'package:redbus/database/repository.dart';
import 'package:redbus/models/busModel.dart';
import 'package:redbus/models/contactusModel.dart';
import 'package:redbus/models/rentBusModel.dart';

import '../models/userModel.dart';

class BusService{
  late Repository repository;

  BusService(){
    repository = Repository();
  }

  GetSearchedBus(String from, String to,String date) async{
    return await repository.getSearchedBus(from, to, date);
  }

  SearchBus(String from, String to,String date) async{
    return await repository.searchBus(from, to, date);
  }

  GetBusDetails(String docId) async{
    return await repository.getBusDetails(docId);
  }

  UpdateBookedSeats(String id, String seat) async{
    return await repository.updateBookedSeats(id, seat);
  }

  AddBookings(Map<String, dynamic> bookingsMap) async{
    return await repository.addBookings(bookingsMap);
  }

  GetBusId(BusModel busModel) async{
    return await repository.getBusId(busModel.busMap());
  }

  GetBookings(String uEmail) async{
    return await repository.getBookings(uEmail);
  }

  UpdateCancel(String docId) async{
    return await repository.updateCancel(docId);
  }

  UpdateCancelledSeats(String id, String seats) async{
    return await repository.updateCancelledSeats(id, seats);
  }

  RentBus(RentBusModel rentBusModel) async{
    return await repository.rentABus(rentBusModel);
  }

  ContactUs(ContactUsModel contactUsModel) async{
    return await repository.contactUs(contactUsModel);
  }

  CreateWallet(String uEmail, String busName, String busNo, String date, int price) async{
    return await repository.createWallet(uEmail, busName, busNo, date, price);
  }

  ReadWallet(String uEmail) async{
    return await repository.readWallet(uEmail);
  }

  ReadWalletHistroy(String uEmail) async{
    return await repository.readWalletHistroy(uEmail);
  }

  GetBalanceWallet(String uEmail) async{
    return await repository.getTotalPriceFromWallet(uEmail);
  }

  UpdateWallet(String email,String busNo, String date, String usedFor, String usedOn) async{
    return await repository.updateWallet(email,busNo, date, usedFor, usedOn);
  }

  GetAllOffers() async{
    return await repository.getAllOffers();
  }

  GetAllRoutes() async{
    return await repository.getAllRoutes();
  }

  CheckUser(String uEmail, String psw) async{
    return await repository.checkUser(uEmail, psw);
  }

  AddUser(UserModel userModel) async{
    return await repository.addUser(userModel);
  }

  GetUser(String uEmail) async{
    return await repository.getUser(uEmail);
  }

  UpdateUser(String docId, UserModel userModel) async{
    return await repository.updateUser(docId, userModel);
  }

  DeleteUser(String docId) async{
    return await repository.deleteUser(docId);
  }
}