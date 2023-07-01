import 'dart:io';

import 'package:flutter/material.dart';
import 'package:platform_alert_dialog/platform_alert_dialog.dart';

void main() => runApp(const HomePage());

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    _selection = Platform.isIOS ? TargetPlatform.iOS : TargetPlatform.android;
    super.initState();
  }

  late TargetPlatform _selection;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Platform Alert Dialog Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        platform: _selection,
      ),
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Platform Alert Dialog'),
              actions: <Widget>[
                PopupMenuButton<TargetPlatform>(
                  icon: const Icon(Icons.style),
                  onSelected: (TargetPlatform result) {
                    setState(() {
                      _selection = result;
                    });
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<TargetPlatform>>[
                    PopupMenuItem<TargetPlatform>(
                      value: TargetPlatform.android,
                      child: Text(
                        'Android',
                        style: TextStyle(
                          fontWeight: Theme.of(context).platform ==
                                  TargetPlatform.android
                              ? FontWeight.bold
                              : null,
                        ),
                      ),
                    ),
                    PopupMenuItem<TargetPlatform>(
                      value: TargetPlatform.fuchsia,
                      child: Text(
                        'Fuchsia',
                        style: TextStyle(
                          fontWeight: Theme.of(context).platform ==
                                  TargetPlatform.fuchsia
                              ? FontWeight.bold
                              : null,
                        ),
                      ),
                    ),
                    PopupMenuItem<TargetPlatform>(
                      value: TargetPlatform.iOS,
                      child: Text(
                        'iOS',
                        style: TextStyle(
                          fontWeight:
                              Theme.of(context).platform == TargetPlatform.iOS
                                  ? FontWeight.bold
                                  : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            body: Center(
                child: ElevatedButton(
              child: const Text('Show Dialog'),
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return PlatformAlertDialog(
                      title: const Text('Rewind and remember'),
                      content: const SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text('You will never be satisfied.'),
                            Text('You’re like me. I’m never satisfied.'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        PlatformDialogAction(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        PlatformDialogAction(
                          actionType: ActionType.Preferred,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Regret'),
                        ),
                      ],
                    );
                  },
                );
              },
            )),
          );
        },
      ),
    );
  }
}
