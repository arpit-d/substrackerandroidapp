import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';
import 'package:substracker/database/hive_sub.dart';
import 'package:substracker/database/new_sub.dart';
import 'package:substracker/models/expenses.dart';
import 'package:substracker/models/filter.dart';
import 'package:substracker/models/sort.dart';
import 'package:substracker/ui/apptheme/theme.dart';
import 'package:substracker/ui/homepage/homepage.dart';

import 'models/numofsubs.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
    // systemNavigationBarColor: Colors.transparent)
  ));
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter<SubData>(SubDataAdapter());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const _title = 'SubStracker';
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Sort()),
        ChangeNotifierProvider(create: (_) => Filter()),
        Provider(create: (_) => MyDatabase()),
        ChangeNotifierProvider(create: (_) => Expenses()),
        ChangeNotifierProvider(create: (_) => NumOfSubs()),
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        // ChangeNotifierProvider(create: (_) => PaidExpenses()),
      ],
      child: MaterialApWidget(title: _title),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}

class MaterialApWidget extends StatelessWidget {
  const MaterialApWidget({
    Key key,
    @required String title,
  })  : _title = title,
        super(key: key);

  final String _title;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: FutureBuilder(
        future: Hive.openBox('subs'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return Text(snapshot.error.toString());
            else
              return HomePage();
          } else {
            return Scaffold();
          }
        },
      ),
      theme: theme.darkTheme ? darkTheme : lightTheme,
    );
  }
}
