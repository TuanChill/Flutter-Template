import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Template Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Modular.to.navigate('/profile/'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back!',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'How can we help you today?',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Quick Actions
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildQuickActionCard(
                    context,
                    icon: Icons.calendar_today,
                    title: 'Book Appointment',
                    subtitle: 'Schedule a visit',
                    onTap: () {
                      // Navigate to appointment booking
                    },
                  ),
                  _buildQuickActionCard(
                    context,
                    icon: Icons.medical_services,
                    title: 'Medical Records',
                    subtitle: 'View your history',
                    onTap: () {
                      // Navigate to medical records
                    },
                  ),
                  _buildQuickActionCard(
                    context,
                    icon: Icons.medication,
                    title: 'Prescriptions',
                    subtitle: 'Manage medications',
                    onTap: () {
                      // Navigate to prescriptions
                    },
                  ),
                  _buildQuickActionCard(
                    context,
                    icon: Icons.notifications,
                    title: 'Notifications',
                    subtitle: 'View updates',
                    onTap: () {
                      // Navigate to notifications
                    },
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
