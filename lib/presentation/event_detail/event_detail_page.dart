import 'package:flutter/material.dart';
import 'package:hackatrix/domain/model/event.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:hackatrix/presentation/event_detail/ideas/event_ideas_page.dart';
import 'package:hackatrix/presentation/event_detail/information/event_information_page.dart';
import 'package:hackatrix/presentation/event_detail/votes/event_votes_page.dart';
import 'package:hackatrix/presentation/util/theme.dart' as theme;

class EventDetailPage extends StatelessWidget {
  final Event _event;
  EventDetailPage(this._event);

  @override
  Widget build(BuildContext context) {
    var imageHero = new Hero(
      tag: "${_event.id}",
      child: new SizedBox.expand(
        child: new CachedNetworkImage(
          imageUrl: _event.image,
          fit: BoxFit.cover,
        ),
      ),
    );

    var votesPage = new EventVotesPage(_event);

    return new DefaultTabController(
        length: 3,
        child: new Scaffold(
            body: new NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                iconTheme: theme.CompanyThemeIcon,
                elevation:
                    defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
                flexibleSpace: new FlexibleSpaceBar(
                  //centerTitle: true,
                  centerTitle: true,
                  title: new Text(_event.title,
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: new GridTile(
                    child: imageHero,
                    footer: new GridTileBar(
                      backgroundColor: Colors.black38,
                    ),
                  ),
                ),
              ),
              new SliverPersistentHeader(
                delegate: new _SliverAppBarDelegate(new TabBar(
                  labelColor: Colors.black87,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    new Tab(icon: new Icon(Icons.info), text: "ACERCA DE"),
                    new Tab(
                        icon: new Icon(Icons.lightbulb_outline), text: "IDEAS"),
                    new Tab(
                      icon: new Icon(Icons.group),
                      text: "VOTOS",
                    ),
                  ],
                )),
                pinned: true,
              ),
            ];
          },
          body: new TabBarView(
            children: [
              new EventInformationPage(_event),
              new EventIdeasPage(_event),
              votesPage,
            ],
          ),
        )));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
