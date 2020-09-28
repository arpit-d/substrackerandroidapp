getNotificationTimings(DateTime createdAt) {
  String setTime = createdAt.hour.toString() +
      createdAt.minute.toString() +
      createdAt.second.toString() +
      createdAt.millisecond.toString();
}
