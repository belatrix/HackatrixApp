import 'package:flutter/widgets.dart';
import 'package:hackatrix/data/repository/rest/event_rest.dart';
import 'home_bloc.dart';

class HomeProvider extends InheritedWidget {
  final HomeBloc homeBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static HomeBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(HomeProvider) as HomeProvider)
          .homeBloc;

  HomeProvider({Key key, HomeBloc homeBloc, Widget child})
      : this.homeBloc = homeBloc ?? HomeBloc(EventRest()),
        super(child: child, key: key);

}
