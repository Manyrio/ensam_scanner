String getDifference(DateTime? time) {
  if (time == null) return "";

  String date;
  Duration dif = DateTime.now().difference(time);

  if (dif.inMinutes >= 0 && dif.inMinutes < 1) {
    date = "à l'instant";
  } else if (dif.inMinutes < 60) {
    date = "il y a ${dif.inMinutes} min";
  } else if (dif.inHours < 24) {
    date = "il y a ${dif.inHours} heures";
  } else {
    date = "il y a ${dif.inDays} jours";
  }
  return date;
}