import 'package:flutter/material.dart';
import 'package:hackatrix/domain/model/city.dart';
import 'package:hackatrix/domain/model/user.dart';
import 'package:hackatrix/presentation/event/event_page.dart';
import 'package:hackatrix/presentation/home/home_presenter.dart';
import 'package:hackatrix/presentation/menu/drawer_widget.dart';
import 'package:hackatrix/presentation/util/theme.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> implements HomeView, DrawerListener {
  List<City> _cityList = [
    new City(id: 0, name: 'Proximos Eventos'),
    new City(id: 1, name: 'Lima'),
    new City(id: 2, name: 'Mendoza'),
    new City(id: 3, name: 'Buenos Aires'),
    new City(id: 4, name: 'Bogota'),
    new City(id: 5, name: 'Rosario'),
  ].toList();

  HomePresenter _presenter;
  User _user;
  DrawerWidget _drawer;
  int _selectedDrawerIndex;
  City _city;

  _HomePageState() {
    _presenter = new HomePresenter(this);
    _drawer = new DrawerWidget(this);
    _user = null;
    _selectedDrawerIndex = 0;
    _city = _cityList[0];
  }

  @override
  void initState() {
    super.initState();
    _presenter.loadUser();
  }

  @override
  void onUserLoaded(user) {
    setState(() {
      _user = user;
    });
  }

  @override
  void onUserLoggedIn(user) {
    setState(() {
      _user = user;
    });
  }

  @override
  void onSelectedItem(pos) {
    setState(() {
      _selectedDrawerIndex = pos;
    });
    Navigator.of(context).pop();
  }

  Widget _getDrawerItemWidget() {
    switch (_selectedDrawerIndex) {
      case 0:
        return new EventPage(_city.id);
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomAppBar(AppBar(
        title: buildTitleAppBar(context),
        elevation: 0.0,
      )),
      drawer: _drawer.build(context, _user),
      body: _getDrawerItemWidget(),
    );
  }

  Widget buildTitleAppBar(BuildContext context) {
    if (_selectedDrawerIndex == 0) {
      final dropdownOptions = _cityList
          .map(
            (City city) => DropdownMenuItem(
                  value: city,
                  child: Text(
                    city.name,
                    style: CompanyTextStyle.H6.apply(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
          )
          .toList();

      return DropdownButtonHideUnderline(
          child: DropdownButton<City>(
              items: dropdownOptions,
              value: _city,
              onChanged: (city) {
                setState(() {
                  _city = city;
                });
              }));
    } else {
      return Text(
        _drawer.getDrawerTitle(_selectedDrawerIndex),
        style: CompanyTextStyle.H6,
      );
    }
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  CustomAppBar(this.appBar);

  @override
  Widget build(BuildContext context) {
    return new Theme(child: appBar, data: buildDarkCompanyThemeData());
  }

  @override
  Size get preferredSize => appBar.preferredSize;
}
