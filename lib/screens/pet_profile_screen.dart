
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/pet.dart';
import '../theme/app_theme.dart';

class PetProfileScreen extends StatelessWidget {
  final Pet pet;

  const PetProfileScreen({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Background (Blurred Imagery)
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              child: Image.network(
                pet.imageUrls.first,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.3),
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          
          // 2. Main Content
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                _buildTransparentHeader(context),
                SliverToBoxAdapter(
                  child: _buildImmersiveContent(context),
                ),
              ],
            ),
          ),
          
          // 3. Floating Bottom Action (Minimal)
          Positioned(
            bottom: 30,
            left: 24,
            right: 24,
            child: _buildMinimalFooter(context),
          ),
        ],
      ),
    );
  }

  Widget _buildTransparentHeader(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Center( // Center Icon in Glass
          child: GlassContainer(
            shape: BoxShape.circle,
            padding: const EdgeInsets.all(10), // Reduced to match icon size
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.white),
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.right(16.0),
          child: Center(
            child: GlassContainer(
              borderRadius: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: const Text('Edit Profile', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ],
      expandedHeight: 400,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Hero(
            tag: 'pet-${pet.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(pet.imageUrls.first, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImmersiveContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            '52.4k Supporters',
            style: TextStyle(color: Colors.white70, fontSize: 13, letterSpacing: 1),
          ),
          const SizedBox(height: 8),
          Text(
            pet.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold, letterSpacing: -1),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            children: [
              _buildSimpleChip('Pet Coach'),
              _buildSimpleChip(pet.breed),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            pet.description,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16, height: 1.6),
          ),
          const SizedBox(height: 48),
          _buildOrganicStats(),
          const SizedBox(height: 48),
          _buildGalleryRow(),
          const SizedBox(height: 120),
        ],
      ),
    );
  }

  Widget _buildSimpleChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.white70)),
    );
  }

  Widget _buildOrganicStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatColumn('Energy', 'High'),
        _buildStatColumn('Age', '${pet.age} y'),
        _buildStatColumn('Match', '98%'),
      ],
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 12)),
      ],
    );
  }

  Widget _buildGalleryRow() {
    return SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: const DecorationImage(
              image: NetworkImage('https://images.unsplash.com/photo-1513245543132-31f507417b26?q=80&w=200'),
              fit: BoxFit.cover,
            ),
          ),
        )),
      ),
    );
  }

  Widget _buildMinimalFooter(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GlassContainer(
            padding: const EdgeInsets.symmetric(vertical: 20),
            opacity: 0.2,
            blur: 40,
            borderRadius: 100,
            child: const Center(
              child: Text(
                'Get Start Match',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        GlassContainer(
          shape: BoxShape.circle,
          padding: const EdgeInsets.all(18),
          child: const Icon(Icons.mail_outline, color: Colors.white, size: 24),
        ),
      ],
    );
  }
}
