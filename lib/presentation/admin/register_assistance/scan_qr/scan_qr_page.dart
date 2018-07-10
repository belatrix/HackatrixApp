//import 'dart:async';
//import 'package:flutter/material.dart';
//import 'package:hackatrix/data/repository/rest/event_rest.dart';
//import 'package:hackatrix/domain/model/meeting.dart';
//import 'package:hackatrix/presentation/admin/register_assistance/scan_qr/scan_qr_presenter.dart';
//import 'package:hackatrix/presentation/util/custom_widgets/my_scaffold.dart';
//import 'package:barcode_scan/barcode_scan.dart';
//import 'package:flutter/services.dart';
//import 'package:progress_hud/progress_hud.dart';
//
//class ScanQRPage extends StatefulWidget {
//  final Meeting _meeting;
//
//  ScanQRPage(this._meeting);
//
//  @override
//  _ScanQRPageState createState() => new _ScanQRPageState();
//}
//
//class _ScanQRPageState extends State<ScanQRPage> implements ScanQRView {
//  ScanQRPresenter _presenter;
//  String _result = "Presiona el boton inferior para iniciar la lectura";
//  ProgressHUD _progressHUD;
//
//  @override
//  void initState() {
//    super.initState();
//    _progressHUD = new ProgressHUD(
//      backgroundColor: Colors.black12,
//      loading: false,
//    );
//  }
//
//  _ScanQRPageState() {
//    _presenter = new ScanQRPresenter(this, new EventRest());
//  }
//
//  @override
//  void onError(String errorMessage) {
//    _progressHUD.state.dismiss();
//    _result = errorMessage;
//    setState(() {});
//  }
//
//  @override
//  void onResult(String email) {
//    _progressHUD.state.dismiss();
//    _result = "Usuario $email registrado satisfactoriamente";
//    setState(() {});
//  }
//
//  Future _scanQR() async {
//    try {
//      String qrResult = await BarcodeScanner.scan();
//      setState(() {
//        _result = qrResult;
//      });
//      _progressHUD.state.show();
//      _presenter.actionRegisterAttendance(widget._meeting.id, _result);
//    } on PlatformException catch (ex) {
//      if (ex.code == BarcodeScanner.CameraAccessDenied) {
//        setState(() {
//          _result = "Permisos de cámara fueron denegados";
//        });
//      } else {
//        setState(() {
//          _result = "Error desconcido $ex";
//        });
//      }
//    } on FormatException {
//      setState(() {
//        _result = "Lectura cancelada";
//      });
//    } catch (ex) {
//      setState(() {
//        _result = "Error desconocido: $ex";
//      });
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new MyScaffold(
//      title: "Lector de QR",
//      body: new Stack(
//        children: <Widget>[
//          new Padding(
//              padding: EdgeInsets.all(25.0),
//              child: new Center(
//                child: new Text(
//                  _result,
//                  textAlign: TextAlign.center,
//                  style: new TextStyle(
//                    fontSize: 19.0,
//                  ),
//                ),
//              )),
//          _progressHUD,
//        ],
//      ),
//      floatingActionButton: new FloatingActionButton.extended(
//        label: new Text("Leer QR"),
//        onPressed: _scanQR,
//        elevation: 5.0,
//        icon: new Icon(Icons.camera_alt),
//      ),
//    );
//  }
//}
