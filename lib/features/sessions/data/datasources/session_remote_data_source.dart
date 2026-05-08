import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/session_model.dart';

abstract class SessionRemoteDataSource {
  Future<List<SessionModel>> getSessions();
  Future<void> saveSession(SessionModel session);
  Future<void> deleteSession(String id);
}

class SessionRemoteDataSourceImpl implements SessionRemoteDataSource {
  final SupabaseClient supabaseClient;

  SessionRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<List<SessionModel>> getSessions() async {
    final response = await supabaseClient.from('sessions').select();
    
    return (response as List<dynamic>)
        .map((e) => SessionModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveSession(SessionModel session) async {
    await supabaseClient.from('sessions').upsert(
          session.toMap(),
          onConflict: 'id',
        );
  }

  @override
  Future<void> deleteSession(String id) async {
    await supabaseClient.from('sessions').delete().eq('id', id);
  }
}
