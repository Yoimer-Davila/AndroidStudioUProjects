import 'package:drift/drift.dart';

Ty? fromJson<Ty>(Map<String, dynamic> json, String key) => json.keys.contains(key)
    ? json[key] as Ty : null;


void andThen(Future future, {Function? then}) =>
    future.then((value) {
      then != null ? then() : {};
    });

Value<Ty> valueOf<Ty>(Ty value) => Value(value);