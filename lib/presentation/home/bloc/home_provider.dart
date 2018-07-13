import 'package:flutter/widgets.dart';
import 'package:hackatrix/data/repository/rest/event_rest.dart';
import 'package:hackatrix/presentation/home/bloc/home_bloc.dart';

//  InheritedWidget Allows to pass its sates to his child widgets
class HomeProvider extends InheritedWidget {
  final HomeBloc homeBloc;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  // To access the block from anywhere in the application
  static HomeBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(HomeProvider) as HomeProvider)
          .homeBloc;

  HomeProvider({Key key, HomeBloc homeBloc, Widget child})
      : this.homeBloc = homeBloc ?? HomeBloc(EventRest()),
        super(child: child, key: key);
}
