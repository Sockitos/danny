class FirestorePath {
  static String achievement(String achievementId) =>
      'achievements/$achievementId';
  static String achievements() => 'achievements';
  static String tracker(String trackerId) => 'trackers/$trackerId';
  static String trackers() => 'trackers';
  static String userTracker(String uid, String trackerId) =>
      'users/$uid/trackers/$trackerId';
  static String userTrackers(String uid) => 'users/$uid/trackers';
  static String userInfo(String uid) => 'users/$uid';
  static String userRating(String uid, String ratingId) =>
      'users/$uid/ratings/$ratingId';
  static String userRatings(String uid) => 'users/$uid/ratings';
  static String weekly() => 'weeklies/current';
}
