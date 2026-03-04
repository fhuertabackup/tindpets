
import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/pet.dart';
import '../theme/app_theme.dart';
import 'chat_detail_screen.dart';
import '../models/chat.dart';

class MatchCelebrationScreen extends StatelessWidget {
  final Pet myPet;
  final Pet matchedPet;

  const MatchCelebrationScreen({
    super.key, 
    required this.myPet, 
    required this.matchedPet
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Blurred background
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              child: Image.network(
                matchedPet.imageUrls.first,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.6),
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '¡Es un Match! 🐾',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                      letterSpacing: -2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'A ${matchedPet.name} también le gustas.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                  const SizedBox(height: 64),
                  _buildPhotoOverlap(),
                  const SizedBox(height: 80),
                  _buildActionButton(
                    context,
                    'Enviar mensaje',
                    AppTheme.primaryColor,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatDetailScreen(
                            match: ChatMatch(
                              id: 'new',
                              petName: matchedPet.name,
                              petImageUrl: matchedPet.imageUrls.first,
                              lastMessage: '',
                              lastMessageTime: DateTime.now(),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildActionButton(
                    context,
                    'Seguir buscando',
                    Colors.white.withOpacity(0.1),
                    () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoOverlap() {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // My Pet (Left)
          Positioned(
            left: 50,
            child: Transform.rotate(
              angle: -0.2,
              child: _buildCircleImage(myPet.imageUrls.first),
            ),
          ),
          // Matched Pet (Right)
          Positioned(
            right: 50,
            child: Transform.rotate(
              angle: 0.2,
              child: _buildCircleImage(matchedPet.imageUrls.first),
            ),
          ),
          // Heart Icon
          const Center(
            child: GlassContainer(
              shape: BoxShape.circle,
              padding: EdgeInsets.all(16),
              color: AppTheme.primaryColor,
              child: Icon(Icons.favorite, color: Colors.white, size: 40),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleImage(String url) {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String label, Color color, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
        child: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
