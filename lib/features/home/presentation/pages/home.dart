import 'package:flutter/material.dart';
import '../../../../core/utils/Customcontainer.dart';
import '../../../../core/utils/summaryContainer.dart';
import '../../../Profile/auth/Presentation/pages/ProfilePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
                  MaterialPageRoute(builder: (_) => Profilepage()),
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
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey[900],
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications, color: Colors.white),
              ),
            ),
          ),

        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Expanded(
                  child: SummaryCard(
                    title: "Total Balance",
                    value: "4,530",
                      valueSize: 26,
                    height: 120,
                    backgroundColor: Color(0xFF1C1C1C),
                    titleColor: Colors.white70,
                    valueColor: Colors.green,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: SummaryCard(
                    title: "Month's Income",
                    value: "4,530",
                    height: 120,
                    valueSize: 26,
                    backgroundColor: Color(0xFF1C1C1C),
                    titleColor: Colors.white70,
                    valueColor: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
             SummaryCard(
              title: "This Month's Expenses",
              value: "4,563",
              height: 120,
              valueSize: 26,
              backgroundColor: Color(0xFF1C1C1C),
              titleColor: Colors.white70,
              valueColor: Colors.green,
            ),
            const SizedBox(height: 20),

            
            Row(
              children: [
                const Text(
                  "Your Budgets",
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                TextButton(
                    onPressed: (){}
                    , child: Text("View All", style: TextStyle(color:  Color(0xFF72E369)),)
                )
              ],
            ),
            const SizedBox(height: 10),
            Customcontainer(
              title: "Groceries",
              remainingText: "102 remaining",
              progressText: "350 / 500 EG",
              progressValue: 0.7,
              targetDate: "30/01/2026",
              statusText: "On Track",
              onEdit: () {},
              onDelete: () {},
            ),

            const SizedBox(height: 20),
            const Text(
              "Recent Activity",
              style: TextStyle(
                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Customcontainer(
              title: "Milk",
              remainingText: "Today, Food",
              price: "-45.00",
            ),
            const SizedBox(height: 10),
            Customcontainer(
              title: "Milk",
              remainingText: "Today, Food",
              price: "-45.00",
            ),
          ],
        ),
      ),
    );
  }
}
