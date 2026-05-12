import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/config/supabase_config.dart';
import 'features/sessions/data/datasources/session_remote_data_source.dart';
import 'features/sessions/data/repositories/session_repository_impl.dart';
import 'features/sessions/domain/usecases/get_sessions.dart';
import 'features/sessions/domain/usecases/save_session.dart';
import 'features/sessions/domain/usecases/delete_session.dart';
import 'features/sessions/presentation/providers/session_provider.dart';
import 'features/sessions/presentation/pages/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Supabase
    await Supabase.initialize(
      url: SupabaseConfig.url,
      anonKey: SupabaseConfig.anonKey,
    );

    final supabaseClient = Supabase.instance.client;
    final dataSource = SessionRemoteDataSourceImpl(
      supabaseClient: supabaseClient,
    );
    final repository = SessionRepositoryImpl(remoteDataSource: dataSource);
    final getSessions = GetSessions(repository);
    final saveSession = SaveSession(repository);
    final deleteSession = DeleteSession(repository);

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => SessionProvider(
              getSessionsUseCase: getSessions,
              saveSessionUseCase: saveSession,
              deleteSessionUseCase: deleteSession,
            ),
          ),
        ],
        child: const MentorTrackerApp(),
      ),
    );
  } catch (e, stackTrace) {
    debugPrint('Initialization error: $e');
    debugPrintStack(stackTrace: stackTrace);

    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                'Application failed to start.\n\nError:\n$e',
                style: TextStyle(color: Colors.redAccent, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MentorTrackerApp extends StatelessWidget {
  const MentorTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MentorTracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF6C63FF),
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6C63FF),
          secondary: Color(0xFF00FFB2),
          surface: Color(0xFF1E1E1E),
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}
