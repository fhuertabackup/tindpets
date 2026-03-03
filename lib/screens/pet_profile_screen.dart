
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
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: _buildProfileContent(context),
          ),
        ],
      ),
      bottomNavigationBar: _buildActionBottomBar(context),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 500,
      floating: false,
      pinned: true,
      backgroundColor: Colors.black,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GlassContainer(
          borderRadius: 50,
          padding: const EdgeInsets.all(8),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GlassContainer(
            borderRadius: 12,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Center(
              child: Text(
                'Edit Profile',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'pet-${pet.id}',
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(pet.imageUrls.first, fit: BoxFit.cover),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.4), Colors.black],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.6, 1.0],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pet.name,
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Text(
            '@${pet.name.toLowerCase()}_pet',
            style: const TextStyle(color: Colors.white60, fontSize: 16),
          ),
          const SizedBox(height: 16),
          Text(
            pet.description,
            style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 24),
          _buildStatsSection(),
          const SizedBox(height: 32),
          const Text(
            'Galería',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildGallery(context),
          const SizedBox(height: 24),
          _buildRecommendationBox(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatItem('521', 'Followers'),
        _buildStatItem('345', 'Following'),
        _buildStatItem('566', 'Matches'),
      ],
    );
  }

  Widget _buildStatItem(String val, String label) {
    return Column(
      children: [
        Text(val, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white60, fontSize: 12)),
      ],
    );
  }

  Widget _buildGallery(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(right: 12),
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: NetworkImage(pet.imageUrls[index % pet.imageUrls.length]),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationBox() {
    return GlassContainer(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=vet'),
            radius: 25,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recomendación del Vet',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Este perfil tiene sus vacunas al día y un temperamento ideal.',
                  style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.orange, AppTheme.primaryColor],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Center(
                child: Text(
                  'Follow',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          _buildCircleAction(context, Icons.mail_outline),
        ],
      ),
    );
  }

  Widget _buildCircleAction(BuildContext context, IconData icon) {
    return GlassContainer(
      borderRadius: 100,
      padding: const EdgeInsets.all(16),
      child: Icon(icon, color: Colors.white),
    );
  }
}
