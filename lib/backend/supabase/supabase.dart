import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

export 'database/database.dart';

const _kSupabaseUrl = 'https://xdmphmvjlqojaanhcwoq.supabase.co';
const _kSupabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhkbXBobXZqbHFvamFhbmhjd29xIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDg0ODk0NjksImV4cCI6MjAyNDA2NTQ2OX0.gstLqW8xlJURVHwwyH4i_Gw6VY9ZUqhlo3KlcZZiDJc';

class SupaFlow {
  SupaFlow._();

  static SupaFlow? _instance;
  static SupaFlow get instance => _instance ??= SupaFlow._();

  final _supabase = Supabase.instance.client;
  static SupabaseClient get client => instance._supabase;

  static Future initialize() => Supabase.initialize(
        url: _kSupabaseUrl,
        anonKey: _kSupabaseAnonKey,
        debug: false,
      );
}
