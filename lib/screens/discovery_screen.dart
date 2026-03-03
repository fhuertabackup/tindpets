
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import '../providers/pet_provider.dart';
import '../widgets/pet_card.dart';
import '../theme/app_theme.dart';
import 'pet_profile_screen.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  final CardSwiperController controller = CardSwiperController();
  int activeIndex = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final petProvider = Provider.of<PetProvider>(context);
    final pets = petProvider.pets;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 1. Dynamic Immersive Background (Blurred Pet Photo)
          if (pets.isNotEmpty && activeIndex < pets.length)
            Positioned.fill(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: ImageFiltered(
                  key: ValueKey(pets[activeIndex].id),
                  imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                  child: Image.network(
                    pets[activeIndex].imageUrls.first,
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(0.4),
                    colorBlendMode: BlendMode.darken,
                  ),
                ),
              ),
            ),
            
          // 2. Main Discovery UI
          SafeArea(
            child: Column(
              children: [
                _buildMinimalAppBar(),
                Expanded(
                  child: pets.isEmpty
                      ? const Center(child: Text('No hay más mascotas 🐾'))
                      : CardSwiper(
                          controller: controller,
                          cardsCount: pets.length,
                          onSwipe: (previousIndex, currentIndex, direction) {
                            setState(() {
                              activeIndex = currentIndex ?? 0;
                            });
                            return true;
                          },
                          cardBuilder: (context, index, horizontalOffsetPercentage, verticalOffsetPercentage) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                              child: PetCard(
                                pet: pets[index],
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PetProfileScreen(pet: pets[index]),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),
                _buildMinimalActionButtons(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMinimalAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TutorProfileScreen()),
              );
            },
            child: const GlassContainer(
              shape: BoxShape.circle,
              padding: EdgeInsets.all(10),
              child: Icon(Icons.person_outline, color: Colors.white, size: 20),
            ),
          ),
          const Text(
            'TindPets',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatListScreen()),
              );
            },
            child: const GlassContainer(
              shape: BoxShape.circle,
              padding: EdgeInsets.all(10),
              child: Icon(Icons.chat_bubble_outline, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMinimalActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildAction(Icons.close, Colors.white60, () => controller.swipe(CardSwiperDirection.left)),
          _buildAction(Icons.star, Colors.blueAccent, () {}),
          _buildAction(Icons.favorite, AppTheme.primaryColor, () => controller.swipe(CardSwiperDirection.right)),
        ],
      ),
    );
  }

  Widget _buildAction(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        shape: BoxShape.circle,
        padding: const EdgeInsets.all(18),
        opacity: 0.15,
        child: Icon(icon, color: color, size: 26),
      ),
    );
  }
}
