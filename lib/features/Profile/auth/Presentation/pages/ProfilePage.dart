import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profilepage> {
  bool pushNotification = true;
  bool whiteTheme = false;

  String email = '';
  String username = '';
  String phone = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (doc.exists) {
      setState(() {
        email = doc['email'] ?? '';
        username = doc['username'] ?? '';
        phone = doc['phone'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: whiteTheme ? Colors.white : Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: Column(
              children: [
                SizedBox(height: height * 0.04),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  username,
                  style: TextStyle(
                    color: whiteTheme ? Colors.black : Colors.green,
                    fontSize: width * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height * 0.005),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: width * 0.04,
                    color: whiteTheme ? Colors.black54 : Colors.white,
                  ),
                ),
                SizedBox(height: height * 0.005),
                Text(
                  phone,
                  style: TextStyle(
                    fontSize: width * 0.04,
                    color: whiteTheme ? Colors.black54 : Colors.white,
                  ),
                ),
                SizedBox(height: height * 0.02),

                ElevatedButton(
                  onPressed: () {
                    _showEditProfileSheet(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.25,
                      vertical: height * 0.015,
                    ),
                  ),
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: height * 0.03),
                _buildSectionTitle("Preferences"),
                _buildSwitchRow(Icons.notifications, "Push notifications", pushNotification,
                        (value) {
                      setState(() {
                        pushNotification = value;
                      });
                    }),
                SizedBox(height: height * 0.03),
                _buildSwitchRow(Icons.brightness_6, "White theme", whiteTheme,
                        (value) {
                      setState(() {
                        whiteTheme = value;
                      });
                    }),
                SizedBox(height: height * 0.03),
                _buildLogoutRow(Icons.logout, "Logout"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditProfileSheet(BuildContext context) {
    final nameController = TextEditingController(text: username);
    final emailController = TextEditingController(text: email);
    final phoneController = TextEditingController(text: phone);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Edit Profile",
              style: TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: "Phone",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () async {
                final uid = FirebaseAuth.instance.currentUser!.uid;

                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .update({
                  'username': nameController.text,
                  'email': emailController.text,
                  'phone': phoneController.text,
                });

                setState(() {
                  username = nameController.text;
                  email = emailController.text;
                  phone = phoneController.text;
                });

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
              ),
              child: const Text("Save Changes"),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) => Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: whiteTheme ? Colors.grey[800] : Colors.grey,
        ),
      ),
    ),
  );

  Widget _buildSwitchRow(IconData icon, String title, bool value, Function(bool) onChanged) {
    return Card(
      color: whiteTheme ? Colors.grey[200] : Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: whiteTheme ? Colors.black : Colors.white),
        title: Text(title, style: TextStyle(color: whiteTheme ? Colors.black : Colors.white)),
        trailing: Switch(value: value, onChanged: onChanged, activeColor: Colors.green),
      ),
    );
  }

  Widget _buildLogoutRow(IconData icon, String title) {
    return Card(
      color: whiteTheme ? Colors.grey[200] : Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: Colors.red),
        title: Text(title, style: const TextStyle(color: Colors.red)),
        onTap: () {},
      ),
    );
  }
}
