import 'package:week_eleven_flutter_networking/utilities.dart';

class Contact {
  late final ContactName name;
  late final String cell;
  late final ContactPicture picture;

  Contact(json) {
    name = ContactName(fromJson(json, "name"));
    cell = fromJson(json, "cell");
    picture = ContactPicture(fromJson(json, "picture"));
  }

}

class ContactName {
  late final String first;
  ContactName(json) {
    first = fromJson(json, "first");
  }
}

class ContactPicture {
  late final String thumbnail;
  late final String large;
  ContactPicture(json) {
    thumbnail = fromJson(json, "thumbnail");
    large = fromJson(json, "large");
  }
}