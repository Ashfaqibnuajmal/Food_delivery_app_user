import 'package:flutter/material.dart';
import 'package:mera_app/features/profile/screens/settings/about_us.dart';
import 'package:mera_app/features/profile/screens/settings/privacy_and_policy.dart';
import 'package:mera_app/features/profile/screens/settings/terms_condition.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    color: Colors.black,
                  )),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Settings",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Card(
                  color: Colors.white,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutUs()));
                    },
                    child: const ListTile(
                      leading: Icon(Icons.person, color: Colors.black),
                      title: Text(
                        "About us",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  color: Colors.white,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PrivacyAndPolicy()));
                    },
                    child: const ListTile(
                      leading: Icon(Icons.person, color: Colors.black),
                      title: Text(
                        "Privacy & Policy",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  color: Colors.white,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TermsCondition()));
                    },
                    child: const ListTile(
                      leading: Icon(Icons.person, color: Colors.black),
                      title: Text(
                        "Terms & Conditions",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: GestureDetector(
              onTap: () {},
              child: Image.asset(
                "assets/socialmidea.png",
                height: 150,
                width: 150,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
