import 'package:event_listing_app/features/auth/presentation/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:event_listing_app/features/home/presentation/widgets/categories_selection.dart';
import 'package:event_listing_app/features/home/presentation/widgets/custom_appbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CartegorySelection(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Top Picks in Kozhikode',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  FilterChip(
                    label: const Text("🔥 Popular"),
                    onSelected: (_) {},
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text("This Weekend"),
                    onSelected: (_) {},
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 240.h, 
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(16),
                children: [
                  _buildEventCard(
                    title: 'Death by Laughter ft. Vivek Muralidharan',
                    dateTime: 'Fri, 11 Jul, 2025 • 08:00 PM',
                    imageUrl: 'https://images.pexels.com/photos/10012375/pexels-photo-10012375.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  ),
                  const SizedBox(width: 16),
                  _buildEventCard(
                    title: 'LuLu Fashion Week Kozhikode 2025',
                    dateTime: 'Sat, 24 May, 2025 • 03:00 PM',
                    imageUrl: 'https://images.pexels.com/photos/2954405/pexels-photo-2954405.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Explore Events by Date',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildDateCard('This Weekend', 'May 24'),
                  const SizedBox(width: 8),
                  _buildDateCard('This Week', 'May 22'),
                  const SizedBox(width: 8),
                  _buildDateCard('This Month', 'May 22'),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Events curated for you',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Icon(Icons.tune, size: 20),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () async{
                    await ref.read(authControllerProvider).signOut();
                    context.go('/');
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text("Logout"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard({
    required String title,
    required String dateTime,
    required String imageUrl,
  }) {
    return Container(
      width: 280.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, 
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl, 
              height: 120, 
              width: 280, 
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 120,
                  width: 280,
                  color: Colors.grey[300],
                  child: const Icon(Icons.error, color: Colors.grey),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              dateTime, 
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title, 
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateCard(String label, String date) {
    return Expanded(
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue.shade100),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 10)),
            const SizedBox(height: 4),
            Text(date, style: const TextStyle(color: Colors.grey,fontSize: 10)),
          ],
        ),
      ),
    );
  }
}