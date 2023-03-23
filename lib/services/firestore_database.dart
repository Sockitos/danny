import 'package:danny/models/achievement.dart';
import 'package:danny/models/rating.dart';
import 'package:danny/models/tracker.dart';
import 'package:danny/models/user_data.dart';
import 'package:danny/models/weekly.dart';
import 'package:danny/services/firestore_path.dart';
import 'package:danny/services/firestore_service.dart';

class FirestoreDatabase {
  FirestoreDatabase({required this.uid});
  final String uid;

  final _service = FirestoreService.instance;

  Future<void> setRating(Rating rating) async => _service.setData(
        path: FirestorePath.userRating(uid, rating.id),
        data: rating.toJson(),
      );

  Future<void> deleteRating(Rating rating) async {
    await _service.deleteData(path: FirestorePath.userRating(uid, rating.id));
  }

  Stream<Rating> ratingStream({required String ratingId}) =>
      _service.documentStream(
        path: FirestorePath.userRating(uid, ratingId),
        builder: (data, documentId) => Rating.fromJson(<String, dynamic>{
          ...data,
          'id': documentId,
        }),
      );

  Stream<List<Rating>> ratingsStream() => _service.collectionStream(
        path: FirestorePath.userRatings(uid),
        builder: (data, documentId) => Rating.fromJson(<String, dynamic>{
          ...data,
          'id': documentId,
        }),
        queryBuilder: (query) => query.orderBy('timestamp'),
      );

  Stream<List<Rating>> ratingsByTrackerStream(Tracker tracker) =>
      _service.collectionStream(
        path: FirestorePath.userRatings(uid),
        builder: (data, documentId) => Rating.fromJson(<String, dynamic>{
          ...data,
          'id': documentId,
        }),
        queryBuilder: (query) =>
            query.orderBy('timestamp').where('tracker', isEqualTo: tracker.id),
      );

  Future<void> setTracker(Tracker tracker) async => _service.setData(
        path: FirestorePath.tracker(tracker.id),
        data: tracker.toJson(),
      );

  Future<void> deleteTracker(Tracker tracker) async {
    await _service.deleteData(path: FirestorePath.tracker(tracker.id));
  }

  Stream<Tracker> trackerStream({required String trackerId}) =>
      _service.documentStream(
        path: FirestorePath.tracker(trackerId),
        builder: (data, documentId) => Tracker.fromJson(<String, dynamic>{
          ...data,
          'id': documentId,
        }),
      );

  Stream<List<Tracker>> trackersStream() => _service.collectionStream(
        path: FirestorePath.trackers(),
        builder: (data, documentId) => Tracker.fromJson(<String, dynamic>{
          ...data,
          'id': documentId,
        }),
      );

  Future<void> setUserTracker(Tracker tracker) async => _service.setData(
        path: FirestorePath.userTracker(uid, tracker.id),
        data: tracker.toJson(),
      );

  Future<void> deleteUserTracker(Tracker tracker) async {
    await _service.deleteData(path: FirestorePath.userTracker(uid, tracker.id));
  }

  Stream<Tracker> userTrackerStream({required String trackerId}) =>
      _service.documentStream(
        path: FirestorePath.userTracker(uid, trackerId),
        builder: (data, documentId) => Tracker.fromJson(<String, dynamic>{
          ...data,
          'id': documentId,
        }),
      );

  Stream<List<Tracker>> userTrackersStream() => _service.collectionStream(
        path: FirestorePath.userTrackers(uid),
        builder: (data, documentId) => Tracker.fromJson(<String, dynamic>{
          ...data,
          'id': documentId,
        }),
      );

  Future<void> setAchievement(Achievement achievement) async =>
      _service.setData(
        path: FirestorePath.achievement(achievement.id),
        data: achievement.toJson(),
      );

  Future<void> deleteAchievement(Achievement achievement) async {
    await _service.deleteData(path: FirestorePath.achievement(achievement.id));
  }

  Stream<Achievement> achievementStream({required String achievementId}) =>
      _service.documentStream(
        path: FirestorePath.achievement(achievementId),
        builder: (data, documentId) => Achievement.fromJson(<String, dynamic>{
          ...data,
          'id': documentId,
        }),
      );

  Stream<List<Achievement>> achievementsStream() => _service.collectionStream(
        path: FirestorePath.achievements(),
        builder: (data, documentId) => Achievement.fromJson(<String, dynamic>{
          ...data,
          'id': documentId,
        }),
      );

  Future<void> setUserInfo(UserData userInfo) async => _service.setData(
        path: FirestorePath.userInfo(uid),
        data: userInfo.toJson(),
      );

  Future<void> deleteUserInfo(UserData userInfo) async {
    await _service.deleteData(path: FirestorePath.userInfo(uid));
  }

  Stream<UserData> userInfoStream() => _service.documentStream(
        path: FirestorePath.userInfo(uid),
        builder: (data, documentId) => UserData.fromJson(data),
      );

  Stream<Weekly> weeklyStream() => _service.documentStream(
        path: FirestorePath.weekly(),
        builder: (data, documentId) => Weekly.fromJson(data),
      );
}
