
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import '../providers/pet_provider.dart';
import '../widgets/pet_card.dart';
import '../theme/app_theme.dart';

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
      appBar: AppBar(
        title: const Text('TindPets'),
        leading: IconButton(
          icon: const Icon(Icons.person_outline),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
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
                          padding: const EdgeInsets.all(16.0),
                          child: PetCard(pet: pets[index]),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    icon: Icons.close,
                    color: Colors.red,
                    onTap: () => controller.swipe(CardSwiperDirection.left),
                  ),
                  _buildActionButton(
                    icon: Icons.star,
                    color: Colors.blue,
                    size: 40,
                    onTap: () {},
                  ),
                  _buildActionButton(
                    icon: Icons.favorite,
                    color: AppTheme.primaryColor,
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

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    double size = 30,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(icon, color: color, size: size),
      ),
    );
  }
}
