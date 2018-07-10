//import 'dart:async';
//
//import 'package:flutter/material.dart';
//import 'package:hackatrix/data/repository/rest/event_rest.dart';
//import 'package:hackatrix/domain/model/event.dart';
//import 'package:hackatrix/domain/model/meeting.dart';
//import 'package:hackatrix/presentation/admin/register_assistance/meeting_list_presenter.dart';
//import 'package:hackatrix/presentation/admin/register_assistance/scan_qr/scan_qr_page.dart';
//import 'package:hackatrix/presentation/util/custom_widgets/my_scaffold.dart';
//
//class MeetingListPage extends StatefulWidget {
//  final Event _event;
//
//  MeetingListPage(this._event);
//
//  @override
//  _MeetingListPageState createState() => new _MeetingListPageState();
//}
//
//class _MeetingListPageState extends State<MeetingListPage>
//    with AutomaticKeepAliveClientMixin<MeetingListPage>
//    implements MeetingListView {
//  MeetingListPresenter _presenter;
//  List<Meeting> _elements = List();
//  Completer<Null> _completer;
//  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
//      new GlobalKey<RefreshIndicatorState>();
//
//  _MeetingListPageState() {
//    _presenter = new MeetingListPresenter(this, new EventRest());
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    _firstLoad();
//  }
//
//  _firstLoad() async {
//    _refreshIndicatorKey.currentState.show();
//  }
//
//  Future<Null> _refreshList() {
//    _completer = new Completer<Null>();
//    _presenter.actionGetMeetingList(widget._event.id);
//    _refreshIndicatorKey.currentState.show();
//    return _completer.future;
//  }
//
//  @override
//  void onResult(List<Meeting> list) {
//    _completer.complete();
//    if (this.mounted) {
//      setState(() {
//        _elements = list;
//      });
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return buildUI();
//  }
//
//  MyScaffold buildUI() {
//    return new MyScaffold(
//        title: widget._event.title,
//        body: new RefreshIndicator(
//          key: _refreshIndicatorKey,
//          child: ListView.builder(
//              itemExtent: 70.0,
//              itemBuilder: (BuildContext context, int index) =>
//                  new MeetingItem(_elements[index], context),
//              itemCount: _elements.length),
//          onRefresh: _refreshList,
//        ));
//  }
//
//  // TODO: implement wantKeepAlive
//  @override
//  bool get wantKeepAlive => true;
//}
//
//class MeetingItem extends StatelessWidget {
//  final Meeting _meeting;
//  final BuildContext _context;
//
//  MeetingItem(this._meeting, this._context);
//
//  _onMeetingSelected() {
//    Navigator.push(
//      _context,
//      new MaterialPageRoute(
//        builder: (BuildContext context) => new ScanQRPage(_meeting),
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Container(
//        child: ListTile(
//          onTap: _onMeetingSelected,
//          key: new Key(_meeting.id.toString()),
//          title: new Text(
//            _meeting.name,
//            style: TextStyle(fontWeight: FontWeight.w500),
//          ),
//        ),
//        decoration: new BoxDecoration(
//            border:
//                new Border(bottom: new BorderSide(color: Colors.grey[300]))));
//  }
//}
