import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/session_provider.dart';
import '../../domain/entities/session_entity.dart';
import 'session_detail_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionProvider = Provider.of<SessionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mentor/Mentee Sessions', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  'Role: ${sessionProvider.currentRole.name.toUpperCase()}',
                  style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF00FFB2)),
                ),
                const SizedBox(width: 8),
                Switch(
                  value: sessionProvider.currentRole == UserRole.mentor,
                  onChanged: (val) {
                    sessionProvider.toggleRole();
                  },
                  activeColor: const Color(0xFF6C63FF),
                ),
              ],
            ),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF121212), Color(0xFF1A1A2E)],
          ),
        ),
        child: sessionProvider.sessions.isEmpty
            ? const Center(
                child: Text(
                  'No sessions found.\nClick the + button to add one.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white54, fontSize: 18),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(24.0),
                itemCount: sessionProvider.sessions.length,
                itemBuilder: (context, index) {
                  final session = sessionProvider.sessions[index];
                  return _SessionCard(session: session);
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SessionDetailScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('New Session'),
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
      ),
    );
  }
}

class _SessionCard extends StatefulWidget {
  final SessionEntity session;

  const _SessionCard({required this.session});

  @override
  State<_SessionCard> createState() => _SessionCardState();
}

class _SessionCardState extends State<_SessionCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 16.0),
        transform: Matrix4.translationValues(0, _isHovering ? -5 : 0, 0),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E2C),
          borderRadius: BorderRadius.circular(16),
          boxShadow: _isHovering
              ? [BoxShadow(color: const Color(0xFF6C63FF).withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 10))]
              : [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SessionDetailScreen(session: widget.session)),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C63FF).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Session ${widget.session.sessionNumber}',
                          style: const TextStyle(
                            color: Color(0xFF6C63FF),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        DateFormat.yMMMd().format(widget.session.date),
                        style: const TextStyle(color: Colors.white54, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.person, color: Color(0xFF00FFB2), size: 16),
                      const SizedBox(width: 8),
                      Text('Mentor: ${widget.session.mentorName}', style: const TextStyle(color: Colors.white70)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.person_outline, color: Color(0xFF00FFB2), size: 16),
                      const SizedBox(width: 8),
                      Text('Mentee: ${widget.session.menteeName}', style: const TextStyle(color: Colors.white70)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Discussed: ${widget.session.topicsDiscussed}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
