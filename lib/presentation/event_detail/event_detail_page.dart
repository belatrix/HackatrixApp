import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hackatrix/domain/model/event.dart';
import 'package:hackatrix/presentation/event_detail/ideas/event_ideas_page.dart';
import 'package:hackatrix/presentation/event_detail/information/event_information_page.dart';
import 'package:hackatrix/presentation/util/theme.dart' as theme;

class EventDetailPage extends StatefulWidget {
  final Event _event;

  EventDetailPage(this._event);

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  int _currentIndex = 0;

  Widget _buildBodyContext(BuildContext context) {
    if (_currentIndex == 0) {
      return EventInformationPage(widget._event);
    } else {
      return EventIdeasPage(widget._event);
    }
  }

  @override
  Widget build(BuildContext context) {
    var imageHero = new Hero(
      tag: "${widget._event.id}",
      child: new SizedBox.expand(
        child: new CachedNetworkImage(
          imageUrl: widget._event.image,
          fit: BoxFit.cover,
        ),
      ),
    );

    var bottomItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.info),
        title: Text("Información"),
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('images/ic_idea.png')),
        title: Text("Ideas"),
      ),
    ];

    return new Scaffold(
      body: new NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              expandedHeight: 270.0,
              floating: false,
              pinned: true,
              elevation: 0.0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              actions: [
                IconButton(
                    icon: Icon(Icons.today),
                    onPressed: () {
                      print('Add to calendar');
                    }),
              ],
              flexibleSpace: new FlexibleSpaceBar(
                  centerTitle: false,
                  title: Text(widget._event.title.replaceAll("Hackatrix ", ""),
                      style: theme.CompanyTextStyle.H6.apply(
                        color: Colors.white,
                      )),
                  background: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      imageHero,
                      Container(
                        height: 60.0,
                        foregroundDecoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.transparent,
                            Colors.black87,
                          ], tileMode: TileMode.clamp),
                        ),
                      )
                    ],
                  )),
            ),
          ];
        },
        body: _buildBodyContext(context),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomItems,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
