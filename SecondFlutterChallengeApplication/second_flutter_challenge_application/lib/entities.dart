Ty? fromJson<Ty>(dynamic json, String key) {
  if(!json.keys.contains(key)) {
    return null;
  }

  return json[key] as Ty;
}

class City {
  late final String city;
  late final String completeCity;
  City(String city) { this.city = normalizeCity(city); completeCity = city; }

  String normalizeCity(String city) {
    return city.replaceAll(RegExp(r'(America/)|[/_]'), " ").trim();
  }

  @override
  String toString() { return city; }

  @override
  bool operator ==(Object other) => city == (other as City).city;

  @override
  int get hashCode => city.hashCode;

}
/*
{
  "abbreviation": "HDT",
  "client_ip": "38.25.17.187",
  "datetime": "2023-06-06T08:31:45.750724-09:00",
  "day_of_week": 2,
  "day_of_year": 157,
  "dst": true,
  "dst_from": "2023-03-12T12:00:00+00:00",
  "dst_offset": 3600,
  "dst_until": "2023-11-05T11:00:00+00:00",
  "raw_offset": -36000,
  "timezone": "America/Adak",
  "unixtime": 1686072705,
  "utc_datetime": "2023-06-06T17:31:45.750724+00:00",
  "utc_offset": "-09:00",
  "week_number": 23
}
* */
class CityTime {
  late final DateTime datetime;
  late final int dayOfWeek;
  late final int dayOfYear;
  late final String timezone;
  late final String utcDatetime;
  late final String utcOffset;
  final String name;
  CityTime(dynamic json, this.name) {
    datetime = DateTime.parse(fromJson(json, "datetime"));
    utcOffset = fromJson(json, "utc_offset");
    timezone = fromJson(json, "timezone");
  }

  String _beforeZero(int number) {
    return number > 9 ? number.toString() : "0$number";
  }
  
  String date() {
    return "${datetime.year}-${_beforeZero(datetime.month)}-${_beforeZero(datetime.day)}";
  }
  String time() {
    return "${datetime.hour}:${_beforeZero(datetime.minute)}:${_beforeZero(datetime.second)}";
  }
}