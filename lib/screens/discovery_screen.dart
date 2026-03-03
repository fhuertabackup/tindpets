
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
      appBar: AppBar(
        title: const Text('TindPets'),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GlassContainer(
            borderRadius: 50,
            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.person_outline, size: 20),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GlassContainer(
              borderRadius: 50,
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.chat_bubble_outline, size: 20),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Expanded(
              child: pets.isEmpty
                  ? const Center(child: Text('No hay más mascotas por ahora 🐾'))
                  : CardSwiper(
                      controller: controller,
                      cardsCount: pets.length,
                      onSwipe: (previousIndex, currentIndex, direction) {
                        return true;
                      },
                      cardBuilder: (context, index, horizontalOffsetPercentage, verticalOffsetPercentage) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCircleAction(
                    icon: Icons.close,
                    color: Colors.white,
                    bgColor: Colors.white.withOpacity(0.1),
                    onTap: () => controller.swipe(CardSwiperDirection.left),
                  ),
                  _buildCircleAction(
                    icon: Icons.star,
                    color: Colors.blueAccent,
                    bgColor: Colors.blueAccent.withOpacity(0.1),
                    onTap: () {},
                  ),
                  _buildCircleAction(
                    icon: Icons.favorite,
                    color: AppTheme.primaryColor,
                    bgColor: AppTheme.primaryColor.withOpacity(0.1),
                    onTap: () => controller.swipe(CardSwiperDirection.right),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleAction({
    required IconData icon,
    required Color color,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        borderRadius: 100,
        padding: const EdgeInsets.all(20),
        color: bgColor,
        child: Icon(icon, color: color, size: 30),
      ),
    );
  }
}
