import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/game_record_model.dart';
import '../../../../core/error/exceptions.dart';

/// 게임 관련 원격 데이터 소스
abstract class GameRemoteDataSource {
  /// 게임 기록 저장
  Future<GameRecordModel> saveGameRecord(GameRecordModel record);
  
  /// 사용자의 게임 기록 목록 조회
  Future<List<GameRecordModel>> getUserGameRecords(String userId, {int limit = 10});
  
  /// 전체 랭킹 조회
  Future<List<GameRecordModel>> getGlobalRanking({int limit = 100});
  
  /// 일간 랭킹 조회
  Future<List<GameRecordModel>> getDailyRanking({int limit = 100});
  
  /// 사용자 최고 기록 조회
  Future<GameRecordModel?> getUserBestRecord(String userId);
  
  /// 사용자 통계 업데이트
  Future<void> updateUserStats(String userId, GameRecordModel record);
}

class GameRemoteDataSourceImpl implements GameRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  GameRemoteDataSourceImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _firestore = firestore,
        _auth = auth;

  @override
  Future<GameRecordModel> saveGameRecord(GameRecordModel record) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw const UnauthorizedException('사용자가 로그인되지 않았습니다.');
      }

      // 사용자 ID를 현재 로그인한 사용자로 설정
      final recordWithUserId = record.copyWith(
        userId: user.uid,
        timestamp: DateTime.now(),
      );

      // Firestore에 저장
      final docRef = await _firestore
          .collection('gameRecords')
          .add(recordWithUserId.toFirestore());

      // 저장된 문서 조회하여 ID 포함한 모델 반환
      final savedDoc = await docRef.get();
      return GameRecordModel.fromFirestore(savedDoc, null);
    } on FirebaseException catch (e) {
      throw ServerException('게임 기록 저장 실패: ${e.message}');
    } catch (e) {
      throw ServerException('게임 기록 저장 중 오류 발생: $e');
    }
  }

  @override
  Future<List<GameRecordModel>> getUserGameRecords(String userId, {int limit = 10}) async {
    try {
      final querySnapshot = await _firestore
          .collection('gameRecords')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => GameRecordModel.fromFirestore(doc, null))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException('사용자 게임 기록 조회 실패: ${e.message}');
    }
  }

  @override
  Future<List<GameRecordModel>> getGlobalRanking({int limit = 100}) async {
    try {
      final querySnapshot = await _firestore
          .collection('gameRecords')
          .where('isValid', isEqualTo: true)
          .orderBy('score', descending: true)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => GameRecordModel.fromFirestore(doc, null))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException('전체 랭킹 조회 실패: ${e.message}');
    }
  }

  @override
  Future<List<GameRecordModel>> getDailyRanking({int limit = 100}) async {
    try {
      // 오늘 00:00:00부터 23:59:59까지
      final now = DateTime.now();
      final todayStart = DateTime(now.year, now.month, now.day);
      final todayEnd = todayStart.add(const Duration(days: 1));

      final querySnapshot = await _firestore
          .collection('gameRecords')
          .where('isValid', isEqualTo: true)
          .where('timestamp', isGreaterThanOrEqualTo: Timestamp.fromDate(todayStart))
          .where('timestamp', isLessThan: Timestamp.fromDate(todayEnd))
          .orderBy('timestamp')
          .orderBy('score', descending: true)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => GameRecordModel.fromFirestore(doc, null))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException('일간 랭킹 조회 실패: ${e.message}');
    }
  }

  @override
  Future<GameRecordModel?> getUserBestRecord(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('gameRecords')
          .where('userId', isEqualTo: userId)
          .where('isValid', isEqualTo: true)
          .orderBy('score', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return null;
      }

      return GameRecordModel.fromFirestore(querySnapshot.docs.first, null);
    } on FirebaseException catch (e) {
      throw ServerException('사용자 최고 기록 조회 실패: ${e.message}');
    }
  }

  @override
  Future<void> updateUserStats(String userId, GameRecordModel record) async {
    try {
      final userStatsRef = _firestore.collection('userStats').doc(userId);
      
      await _firestore.runTransaction((transaction) async {
        final statsDoc = await transaction.get(userStatsRef);
        
        if (statsDoc.exists) {
          // 기존 통계 업데이트
          final currentStats = statsDoc.data()!;
          final currentBestScore = currentStats['bestScore'] as int? ?? 0;
          final currentTotalPlays = currentStats['totalPlays'] as int? ?? 0;
          final currentTotalPlayTime = currentStats['totalPlayTime'] as int? ?? 0;
          final currentTotalScore = currentStats['totalScore'] as int? ?? 0;

          transaction.update(userStatsRef, {
            'bestScore': record.score > currentBestScore ? record.score : currentBestScore,
            'totalPlays': currentTotalPlays + 1,
            'totalPlayTime': currentTotalPlayTime + record.playTime,
            'totalScore': currentTotalScore + record.score,
            'averageScore': (currentTotalScore + record.score) / (currentTotalPlays + 1),
            'lastPlayDate': Timestamp.fromDate(record.timestamp),
            'updatedAt': FieldValue.serverTimestamp(),
          });
        } else {
          // 새 통계 생성
          transaction.set(userStatsRef, {
            'userId': userId,
            'bestScore': record.score,
            'totalPlays': 1,
            'totalPlayTime': record.playTime,
            'totalScore': record.score,
            'averageScore': record.score.toDouble(),
            'lastPlayDate': Timestamp.fromDate(record.timestamp),
            'createdAt': FieldValue.serverTimestamp(),
            'updatedAt': FieldValue.serverTimestamp(),
          });
        }
      });
    } on FirebaseException catch (e) {
      throw ServerException('사용자 통계 업데이트 실패: ${e.message}');
    }
  }
}