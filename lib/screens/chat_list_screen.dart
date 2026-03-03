
import 'package:flutter/material.dart';
import '../models/chat.dart';
import '../theme/app_theme.dart';
import 'chat_detail_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for Matches
    final List<ChatMatch> matches = [
      ChatMatch(
        id: '1',
        petName: 'Firulais',
        petImageUrl: 'https://images.unsplash.com/photo-1552053831-71594a27632d?q=80&w=200',
        lastMessage: '¿Cuándo nos vemos para jugar? 🎾',
        lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
        isUnread: true,
      ),
      ChatMatch(
        id: '2',
        petName: 'Luna',
        petImageUrl: 'https://images.unsplash.com/photo-1513245543132-31f507417b26?q=80&w=200',
        lastMessage: 'Me encanta tu foto de perfil ✨',
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Subtle Glow in Background
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryColor.withOpacity(0.05),
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Text(
                    'Nuevos Matches',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white70),
                  ),
                ),
                _buildNewMatchesList(matches),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Text(
                    'Mensajes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white70),
                  ),
                ),
                Expanded(
                  child: _buildMessagesList(context, matches),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            'Mensajes',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
            radius: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildNewMatchesList(List<ChatMatch> matches) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: matches.length,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(right: 16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.primaryColor, width: 2),
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(matches[index].petImageUrl),
                  radius: 30,
                ),
              ),
              const SizedBox(height: 8),
              Text(matches[index].petName, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessagesList(BuildContext context, List<ChatMatch> matches) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatDetailScreen(match: match),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(match.petImageUrl),
                  radius: 28,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        match.petName,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        match.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: match.isUnread ? Colors.white : Colors.white60,
                          fontWeight: match.isUnread ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                if (match.isUnread)
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
