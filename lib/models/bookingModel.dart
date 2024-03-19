class BookingModel{
  String? uEmail;
  String? busId;
  String? busName;
  String? busNo;
  String? from;
  String? to;
  String? busType;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? seats;
  String? boarding;
  String? dropping;
  int? ttlPrice;
  late List<String>? passengerDetails;
  String? phoneNum;
  String? email;
  String? status;

  bookingMap(){
    var mapping = <String, dynamic>{};
    mapping['uEmail'] = uEmail!;
    mapping['busId'] = busId ?? null;
    mapping['busName'] = busName!;
    mapping['busNo'] = busNo!;
    mapping['from'] = from!;
    mapping['to'] = to!;
    mapping['busType'] = busType!;
    mapping['startDate'] = startDate!;
    mapping['endDate'] = endDate!;
    mapping['startTime'] = startTime!;
    mapping['endTime'] = endTime!;
    mapping['seats'] = seats!;
    mapping['boarding'] = boarding!;
    mapping['dropping'] = dropping!;
    mapping['ttlPrice'] = ttlPrice!;
    mapping['passengerDetails'] = passengerDetails!;
    mapping['phoneNum'] = phoneNum!;
    mapping['email'] = email;
    mapping['status'] = status;
    return mapping;
  }
}