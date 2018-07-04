import 'dart:async';

import 'package:hackatrix/data/repository/event_repository.dart';
import 'package:hackatrix/data/repository/util/network_util.dart';
import 'package:hackatrix/domain/model/event.dart';
import 'package:hackatrix/data/repository/util/api.dart';
import 'package:hackatrix/domain/model/idea.dart';
import 'package:hackatrix/domain/model/meeting.dart';
import 'package:hackatrix/domain/model/vote.dart';

class EventRest implements EventRepository {

  NetworkUtil _netUtil = new NetworkUtil();

  @override
  Future<List<Event>> getEventList(int city){
    return _netUtil.get(API_EVENT_LIST, parameters: {"city": city.toString()}).then((dynamic response) {
      //if(response["error"]) throw new Exception(response["error_msg"]);
      List<Event> list =  List();
      (response as List).forEach((dataItem) =>  list.add(Event.fromJson(dataItem)));
      return list;
    });
  }

  @override
  Future<List<Idea>> getIdeasByEventList(int eventId) {
      return _netUtil.get(API_EVENT_IDEA_LIST(eventId)).then((dynamic response) {
      //if(response["error"]) throw new Exception(response["error_msg"]);
      List<Idea> list =  List();
      (response as List).forEach((dataItem) =>  list.add(Idea.fromJson(dataItem)));
      return list;
    });
  }

  @override
  Future<List<Vote>> getVotesByEventList(int eventId) {
      return _netUtil.get(API_EVENT_IDEA_VOTES(eventId)).then((dynamic response) {
      //if(response["error"]) throw new Exception(response["error_msg"]);
      List<Vote> list =  List();
      (response as List).forEach((dataItem) =>  list.add(Vote.fromJson(dataItem)));
      return list;
    });
  }

  @override
  Future<List<Meeting>> getMeetingByEventList(int eventId) {
      return _netUtil.get(API_EVENT_MEETING_LIST, parameters: {"event": eventId.toString()}).then((dynamic response) {
      //if(response["error"]) throw new Exception(response["error_msg"]);
      List<Meeting> list =  List();
      (response as List).forEach((dataItem) =>  list.add(Meeting.fromJson(dataItem)));
      return list;
    });
  }

  @override
  Future<bool> registerAttendance(int meetingId, String email) {
   return _netUtil.post(API_EVENT_REGISTER_ATTENDANCE, body: {"meeting_id": meetingId.toString(),"user_email": email}).then((dynamic response) {
        return true;
    });
  }
  
}
