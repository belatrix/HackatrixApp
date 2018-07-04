import 'dart:async';

import 'package:hackatrix/domain/model/event.dart';
import 'package:hackatrix/domain/model/idea.dart';
import 'package:hackatrix/domain/model/meeting.dart';
import 'package:hackatrix/domain/model/vote.dart';

abstract class EventRepository {
  Future<List<Event>> getEventList(int city);
  Future<List<Idea>> getIdeasByEventList(int eventId);
  Future<List<Vote>> getVotesByEventList(int eventId);
  Future<List<Meeting>> getMeetingByEventList(int eventId);
  Future<bool> registerAttendance(int meetingId, String email);
}