Ty? fromJson<Ty>(Map json, key) {
  if(!json.keys.contains(key)) {
    return null;
  }

  return json[key] as Ty;
}