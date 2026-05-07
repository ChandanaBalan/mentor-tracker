import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import '../providers/session_provider.dart';
import '../../domain/entities/session_entity.dart';
class SessionDetailScreen extends StatefulWidget {
  final SessionEntity? session;
  const SessionDetailScreen({super.key, this.session});
  @override
  State<SessionDetailScreen> createState() => _SessionDetailScreenState();
}
class _SessionDetailScreenState extends State<SessionDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _mentorNameCtrl;
  late TextEditingController _menteeNameCtrl;
  late TextEditingController _sessionNumberCtrl;
  late TextEditingController _topicsCtrl;
  late TextEditingController _actionsCtrl;
  late TextEditingController _mentorCommentsCtrl;
  late DateTime _selectedDate;
  @override
  void initState() {
    super.initState();
    final s = widget.session;
    _mentorNameCtrl = TextEditingController(text: s?.mentorName ?? '');
    _menteeNameCtrl = TextEditingController(text: s?.menteeName ?? '');
    _sessionNumberCtrl = TextEditingController(text: s?.sessionNumber.toString() ?? '');
    _topicsCtrl = TextEditingController(text: s?.topicsDiscussed ?? '');
    _actionsCtrl = TextEditingController(text: s?.actionItems ?? '');
    _mentorCommentsCtrl = TextEditingController(text: s?.mentorComments ?? '');
    _selectedDate = s?.date ?? DateTime.now();
  }
  @override
  void dispose() {
    _mentorNameCtrl.dispose();
    _menteeNameCtrl.dispose();
    _sessionNumberCtrl.dispose();
    _topicsCtrl.dispose();
    _actionsCtrl.dispose();
    _mentorCommentsCtrl.dispose();
    super.dispose();
  }
  void _saveSession() {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<SessionProvider>(context, listen: false);
      
      final session = SessionEntity(
        id: widget.session?.id ?? Random().nextInt(1000000).toString(),
        mentorName: _mentorNameCtrl.text,
        menteeName: _menteeNameCtrl.text,
        date: _selectedDate,
        sessionNumber: int.parse(_sessionNumberCtrl.text),
        topicsDiscussed: _topicsCtrl.text,
        actionItems: _actionsCtrl.text,
        mentorComments: _mentorCommentsCtrl.text, // Guaranteed to save even if empty
      );
      provider.saveSession(session);
      
      Navigator.pop(context);
    }
  }
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF6C63FF),
              onPrimary: Colors.white,
              surface: Color(0xFF1E1E2C),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final isMentor = Provider.of<SessionProvider>(context).currentRole == UserRole.mentor;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.session == null ? 'New Session' : 'Edit Session'),
        actions: [
          if (widget.session != null)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () {
                Provider.of<SessionProvider>(context, listen: false).deleteSession(widget.session!.id);
                Navigator.pop(context);
              },
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
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              _buildSectionCard(
                title: 'Session Info',
                icon: Icons.info_outline,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _sessionNumberCtrl,
                          label: 'Session Number',
                          icon: Icons.numbers,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: _pickDate,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E2C),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white12),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today, color: Color(0xFF00FFB2)),
                                const SizedBox(width: 12),
                                Text(DateFormat.yMMMd().format(_selectedDate)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(controller: _mentorNameCtrl, label: 'Mentor Name', icon: Icons.person),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(controller: _menteeNameCtrl, label: 'Mentee Name', icon: Icons.person_outline),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSectionCard(
                title: 'Discussion & Actions',
                icon: Icons.chat_bubble_outline,
                children: [
                  _buildTextField(
                    controller: _topicsCtrl,
                    label: 'Topics Discussed',
                    icon: Icons.topic,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _actionsCtrl,
                    label: 'Action Items',
                    icon: Icons.check_circle_outline,
                    maxLines: 4,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSectionCard(
                title: 'Mentor Comments',
                icon: Icons.comment,
                children: [
                  if (!isMentor) 
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.1),
                        border: Border.all(color: Colors.orange.withValues(alpha: 0.5)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.lock_outline, color: Colors.orange, size: 20),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Only mentors can edit this section. You are viewing as a Mentee.',
                              style: TextStyle(color: Colors.orange, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  _buildTextField(
                    controller: _mentorCommentsCtrl,
                    label: 'Comments (Mentor Only)',
                    icon: Icons.note_alt_outlined,
                    maxLines: 4,
                    enabled: isMentor,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveSession,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 5,
                ),
                child: const Text('Save Session', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildSectionCard({required String title, required IconData icon, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF00FFB2)),
              const SizedBox(width: 12),
              Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
          const Divider(color: Colors.white12, height: 32),
          ...children,
        ],
      ),
    );
  }
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    bool enabled = true,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      enabled: enabled,
      validator: (value) {
        if (value == null || value.isEmpty) {
          // Explicitly NO validation for Mentor Comments.
          // The form will save cleanly even if this field is empty.
          if (label == 'Comments (Mentor Only)') return null; 
          return 'Please enter $label';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Padding(
          padding: EdgeInsets.only(bottom: maxLines > 1 ? (maxLines * 15.0 - 20) : 0),
          child: Icon(icon, color: enabled ? Colors.white54 : Colors.white24),
        ),
        filled: true,
        fillColor: enabled ? const Color(0xFF1E1E2C) : const Color(0xFF1E1E2C).withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
