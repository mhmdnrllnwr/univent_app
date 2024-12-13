import 'package:flutter/material.dart';
import 'signin_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // Customize AppBar color
        title: const Text("My Profile"), // Customize the title
        actions: [
          IconButton(
            onPressed: () {
              // Add functionality for settings button
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ProfileHeader(
              avatarUrl:
                  'https://via.placeholder.com/150', // Replace with user's profile image URL
              title: "Welcome!", // Customize title
              subtitle: "Login to explore more!", // Customize subtitle
            ),
            const SizedBox(height: 16),
            ActionButtons(
              onSignUpPressed: () {
                // Define functionality for Sign Up button
              },
              onLoginPressed: () {
                // Define functionality for Login button
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SignInPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            OptionsRow(
              options: [
                OptionItem(
                  icon: Icons.shield,
                  title: "Troopers Protect",
                  onPressed: () {
                    // Action for Troopers Protect
                  },
                ),
                OptionItem(
                  icon: Icons.person_add,
                  title: "Refer A Friend",
                  onPressed: () {
                    // Action for Refer A Friend
                  },
                ),
                OptionItem(
                  icon: Icons.school,
                  title: "Troopers Academy",
                  onPressed: () {
                    // Action for Troopers Academy
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            SupportSection(
              items: [
                SupportItem(
                  icon: Icons.help,
                  title: "How To",
                  onPressed: () {
                    // Action for How To
                  },
                ),
                SupportItem(
                  icon: Icons.headset,
                  title: "Contact Us",
                  onPressed: () {
                    // Action for Contact Us
                  },
                ),
                SupportItem(
                  icon: Icons.question_answer,
                  title: "FAQs",
                  onPressed: () {
                    // Action for FAQs
                  },
                ),
                SupportItem(
                  icon: Icons.privacy_tip,
                  title: "Privacy Policy",
                  onPressed: () {
                    // Action for Privacy Policy
                  },
                ),
                SupportItem(
                  icon: Icons.description,
                  title: "Terms & Conditions",
                  onPressed: () {
                    // Action for Terms & Conditions
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final String avatarUrl;
  final String title;
  final String subtitle;

  const ProfileHeader({
    super.key,
    required this.avatarUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[900],
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(avatarUrl),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  final VoidCallback onSignUpPressed;
  final VoidCallback onLoginPressed;

  const ActionButtons({
    super.key,
    required this.onSignUpPressed,
    required this.onLoginPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: onSignUpPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.orange,
            side: const BorderSide(color: Colors.orange),
          ),
          child: const Text("SIGN UP"),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: onLoginPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
          ),
          child: const Text("LOGIN"),
        ),
      ],
    );
  }
}

class OptionsRow extends StatelessWidget {
  final List<OptionItem> options;

  const OptionsRow({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: options.map((option) {
        return GestureDetector(
          onTap: option.onPressed,
          child: Column(
            children: [
              Icon(option.icon, size: 40, color: Colors.orange),
              const SizedBox(height: 8),
              Text(option.title),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class OptionItem {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  OptionItem({
    required this.icon,
    required this.title,
    required this.onPressed,
  });
}

class SupportSection extends StatelessWidget {
  final List<SupportItem> items;

  const SupportSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items.map((item) {
            return ListTile(
              leading: Icon(item.icon, color: Colors.orange),
              title: Text(item.title),
              onTap: item.onPressed,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class SupportItem {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  SupportItem({
    required this.icon,
    required this.title,
    required this.onPressed,
  });
}
