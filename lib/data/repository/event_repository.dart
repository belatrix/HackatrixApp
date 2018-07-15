import 'dart:async';

abstract class EventRepository {
  Future<List<dynamic>> getUpcomingEventList(int city);
  Future<List<dynamic>> getEventList(int city);
  Future<List<dynamic>> getIdeasByEventList(int eventId);
  Future<List<dynamic>> getVotesByEventList(int eventId);
  Future<List<dynamic>> getMeetingByEventList(int eventId);
  Future<bool> registerAttendance(int meetingId, String email);
}