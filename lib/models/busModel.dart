class BusModel {
  String? busName;
  String? busNo;
  String? startDate;
  String? endDate;
  String? busType;

  busMap() {
    var mapping = Map<String, dynamic>();
    mapping['busName'] = busName!;
    mapping['busNo'] = busNo!;
    mapping['startDate'] = startDate!;
    mapping['endDate'] = endDate!;
    mapping['busType'] = busType!;
    return mapping;
  }
}
