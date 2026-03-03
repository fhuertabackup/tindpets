
import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/chat.dart';
import '../theme/app_theme.dart';

class ChatDetailScreen extends StatelessWidget {
  final ChatMatch match;

  const ChatDetailScreen({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    // Mock messages
    final List<ChatMessage> messages = [
      ChatMessage(id: '1', senderId: '2', text: '¡Hola! Me encantó la foto de Firulais 😍', timestamp: DateTime.now().subtract(const Duration(hours: 1)), isMe: false),
      ChatMessage(id: '2', senderId: '1', text: '¡Muchas gracias! Luna se ve increíble también.', timestamp: DateTime.now().subtract(const Duration(minutes: 50)), isMe: true),
      ChatMessage(id: '3', senderId: '2', text: '¿Te gustaría ir al parque este sábado?', timestamp: DateTime.now().subtract(const Duration(minutes: 30)), isMe: false),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(match.petImageUrl),
              radius: 18,
            ),
            const SizedBox(width: 12),
            Text(match.petName, style: const TextStyle(fontSize: 18, color: Colors.white)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.videocam_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.info_outline), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return _buildMessageBubble(msg);
              },
            ),
          ),
          _buildMessageInput(context),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage msg) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: msg.isMe ? AppTheme.primaryColor : Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(msg.isMe ? 20 : 0),
            bottomRight: Radius.circular(msg.isMe ? 0 : 20),
          ),
        ),
        child: Text(
          msg.text,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Row(
        children: [
          const GlassContainer(
            shape: BoxShape.circle,
            padding: EdgeInsets.all(12),
            child: Icon(Icons.add, color: Colors.white70, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                hintText: 'Escribe algo...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          const GlassContainer(
            shape: BoxShape.circle,
            padding: EdgeInsets.all(12),
            color: AppTheme.primaryColor,
            child: Icon(Icons.send, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }
}
