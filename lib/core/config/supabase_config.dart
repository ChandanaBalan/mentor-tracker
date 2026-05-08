/// Supabase project credentials (anon key is safe to ship in client apps).
/// Prefer overriding via `--dart-define=SUPABASE_URL=...` and
/// `--dart-define=SUPABASE_ANON_KEY=...` for CI or multiple environments.
class SupabaseConfig {
  SupabaseConfig._();

  static const String url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://catftjxyuybmdszwddvz.supabase.co',
  );

  static const String anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNhdGZ0anh5dXlibWRzendkZHZ6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzgxMjc5MjIsImV4cCI6MjA5MzcwMzkyMn0.rubi4l6d_PuCnjNnvjYupoTiInJZ21JRYTpcL0o3NIY',
  );
}
