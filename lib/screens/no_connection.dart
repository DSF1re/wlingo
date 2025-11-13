import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:wlingo/screens/auth_screen.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({super.key});

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 70),
            Expanded(
              flex: 2,
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/intLost.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              flex: 5,
              child: Text(
                'No \ninternet connection',
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () async {
                  final isOnline = await InternetConnection().hasInternetAccess;
                  if (context.mounted) {
                    if (!isOnline) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Нет интернет соединения')),
                      );
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AuthScreen()),
                      );
                    }
                  }
                },
                child: Text('Check again'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
