import 'package:flutter/material.dart';
import 'package:untitled4/features/Budget/presentation/pages/budgetpage.dart';
import 'package:untitled4/features/Expenses/presentation/pages/expensesPage.dart';
import 'package:untitled4/features/Income/presentation/pages/incomepage.dart';
import 'package:untitled4/features/Saving_Goals/presentation/pages/SavingGoalsPage.dart';
import 'package:untitled4/features/home/presentation/pages/home.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  final List<Widget> screens = const [
    HomePage(),
    incomePage(),
    expensespage(),
    SavingGoalspage(),
    budgetpage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

