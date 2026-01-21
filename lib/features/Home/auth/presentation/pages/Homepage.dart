import 'package:flutter/material.dart';

import '../../../../Profile/auth/Presentation/pages/ProfilePage.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentIndex = 0;

  final List<Widget> screens = const [
    Center(child: Text("Home")),
    Center(child: Text("Income")),
    Center(child: Text("Expenses")),
    Center(child: Text("Savings")),
    Center(child: Text("Budget")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profilepage(),
                  ),
                );

              },
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white),
              ),

            ),
            const SizedBox(width: 10),
            const Text("Welcome", style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.white),
          ),
        ],
      ),

      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: "Income",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_off),
            label: "Expenses",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.savings),
            label: "Savings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: "Budget",
          ),
        ],
      ),
    );
  }
}

