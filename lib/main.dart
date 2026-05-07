import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/sessions/data/datasources/session_local_data_source.dart';
import 'features/sessions/data/repositories/session_repository_impl.dart';
import 'features/sessions/domain/usecases/get_sessions.dart';
import 'features/sessions/domain/usecases/save_session.dart';
import 'features/sessions/domain/usecases/delete_session.dart';
import 'features/sessions/presentation/providers/session_provider.dart';
import 'features/sessions/presentation/pages/dashboard_screen.dart';
void main() {
  final dataSource = SessionLocalDataSourceImpl();
  final repository = SessionRepositoryImpl(localDataSource: dataSource);
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
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.dark().textTheme,
        ),
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

