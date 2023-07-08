Ty? fromJson<Ty>(Map json, String key) {
  if(!json.keys.contains(key)) {
    return null;
  }

  return json[key] as Ty;
}