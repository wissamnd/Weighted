import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'logic/actions.dart';
import 'logic/middleware.dart';
import 'logic/reducer.dart';
import 'logic/States/redux_state.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import "logic/States/mainpage_state.dart";
import 'logic/States/firebase_state.dart';
import 'logic/States/weightEntryDialog_state.dart';
import 'logic/States/removedEntry_state.dart';
import 'screens/splashScreen.dart';
void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  // initializing Redux store
  final Store<ReduxState> store = new Store<ReduxState>(reduce,
      initialState: new ReduxState(
          entries: [],
          unit: 'kg',
          removedEntryState: new RemovedEntryState(hasEntryBeenRemoved: false),
          firebaseState: new FirebaseState(),
          mainPageState: new MainPageReduxState(hasEntryBeenAdded: false),
          weightEntryDialogState: new WeightEntryDialogReduxState()),
          middleware: [middleware].toList());

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
}
  @override
  initState() {
    
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@drawable/notification');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
    initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
    onSelectNotification: onSelectNotification);
    showDailyNotification(flutterLocalNotificationsPlugin);
  }

  // function which is responsible for sending a daily (at 9 a.m) notification to the user of the app
  // currently only works on android 
  void showDailyNotification(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async{
    var time = new Time(9,0,0);
    var androidPlatformChannelSpecifics =
    new AndroidNotificationDetails('repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name', 'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics =
    new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
    androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
    0,
    'Good Morning',
    "Don't forget to take your weight",
    time,
    platformChannelSpecifics);
  }
  



  @override
  Widget build(BuildContext context) {
    store.dispatch(new InitAction());
    return new StoreProvider(
      store: store,
      child: new DynamicTheme(
      data: (brightness) => new ThemeData(
        brightness:brightness,
        primarySwatch: Colors.blue,
        accentColor: Colors.blueAccent,
      ),
      themedWidgetBuilder: (context, theme) {
        return new MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Weighted',
          theme: theme,
          home:SplashScreen(),
        );
      }
    )
    );
  }
}
