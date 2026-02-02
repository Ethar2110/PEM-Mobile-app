import 'package:flutter/material.dart';
import '../../../../core/utils/Customcontainer.dart';
import '../../../../core/utils/CustomButton.dart';

class budgetpage extends StatefulWidget {
  const budgetpage({super.key});

  @override
  State<budgetpage> createState() => _budgetpageState();
}

class _budgetpageState extends State<budgetpage> {
  final List<Map<String, dynamic>> budgetData = [
    {"title": "Car", "remaining": "102 remaining", "progress": "350 of 500", "value": 0.7},
    {"title": "Rent", "remaining": "15 days left", "progress": "800 of 1000", "value": 0.8},
    {"title": "Savings", "remaining": "Goal nearly reached", "progress": "900 of 1000", "value": 0.9},
  ];

  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        titleSpacing: 20,
        toolbarHeight: 65,
        title: Text("Budget Management", style: TextStyle(color: Colors.white, fontSize: 24)),
        backgroundColor: Colors.black,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize:  Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey.withOpacity(0.4)),
        ),
      ),

      body: ListView.builder(
        padding:  EdgeInsets.symmetric(vertical: 16),
        itemCount: budgetData.length,
        itemBuilder: (context, index) {
          final item = budgetData[index];
          return Padding(
            padding:  EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Customcontainer(
              title: item['title'],
              remainingText: item['remaining'],
              progressText: item['progress'],
              progressValue: item['value'],
              targetDate: item['date'],
              statusText: item['status'],
              onEdit: () => print("Edit clicked"),
              onDelete: () => print("Delete clicked"),
            ),
          );
        },
      ),

      floatingActionButton: SizedBox(
        width: 160,
        height: 40,
        child: CustomButton(
          text: "+ Add Budget",
          onPressed: _showAddBudgetBottomSheet,
          borderRadius: 25,
        ),
      ),
    );
  }

  void _showAddBudgetBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Color(0xFF121212),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                top: 20, left: 20, right: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text("Category", style: TextStyle(color: Colors.white, fontSize: 16)),
                   SizedBox(height: 10),
                  _buildDropdownField(setModalState),
                   SizedBox(height: 20),
                   Text("Budget", style: TextStyle(color: Colors.white, fontSize: 16)),
                   SizedBox(height: 10),
                  _buildPriceTextField(),
                   SizedBox(height: 30),
                  _buildSaveButton(context),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDropdownField(StateSetter setModalState) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(15)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCategory,
          hint:  Text("Choose a Category", style: TextStyle(color: Colors.white54)),
          dropdownColor:  Color(0xFF1E1E1E),
          icon:  Icon(Icons.keyboard_arrow_down, color: Colors.white),
          isExpanded: true,
          items: ["Food", "Transport", "Shopping", "Bills"].map((String v) =>
              DropdownMenuItem(value: v, child: Text(v, style:  TextStyle(color: Colors.white)))
          ).toList(),
          onChanged: (newValue) => setModalState(() => selectedCategory = newValue),
        ),
      ),
    );
  }

  Widget _buildPriceTextField() {
    return TextField(
      style:  TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Set Budget",
        hintStyle: TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        width: 100, height: 45,
        child: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor:  Color(0xFF00E676),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          ),
          child:  Text("Save", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}