import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

Future<void> supabaseInitialize() async {
  await Supabase.initialize(
    url: 'https://txamrwecbfhyxwmdhszc.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR4YW1yd2VjYmZoeXh3bWRoc3pjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk1ODUxMzksImV4cCI6MjA3NTE2MTEzOX0.2kE4DXQH0gXQpKT_bK4qNi5qgJImrBaa8NGoy_AuuZ0',
  );
}
