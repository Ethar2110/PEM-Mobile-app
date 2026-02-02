import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/Customcontainer.dart';
import '../../../../core/utils/CustomButton.dart';
import '../../../../core/utils/summaryContainer.dart';

class incomePage extends StatefulWidget {
  const incomePage({super.key});

  @override
  State<incomePage> createState() => _incomePageState();
}

class _incomePageState extends State<incomePage> {
  final List<Map<String, dynamic>> incomeSources = [
    {"title": "Salary", "date": "08-01-2026", "price": "15,000"},
    {"title": "Gift", "date": "08-01-2026", "price": "14,500"},
    {"title": "Freelance", "date": "01-12-2025", "price": "3,500"},
  ];

  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF00E676),
              onPrimary: Colors.black,
              surface: Color(0xFF1C1C1C),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        titleSpacing: 20,
        toolbarHeight: 65,
        title: const Text("Income", style: TextStyle(color: Colors.white, fontSize: 24)),
        backgroundColor: Colors.black,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey.withOpacity(0.2)),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SummaryCard(
              title: "Total Income this month",
              value: "\$ 12,500",
            ),

            const SizedBox(height: 15),

            const Text(
              "Income Sources",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: incomeSources.length,
              itemBuilder: (context, index) {
                final item = incomeSources[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Customcontainer(
                    title: item['title'],
                    remainingText: item['date'],
                    price: item['price'],
                    onEdit: () => print("Edit clicked"),
                    onDelete: () => print("Delete clicked"),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      floatingActionButton: SizedBox(
        width: 170,
        height: 50,
        child: CustomButton(
          text: "+ Add Income",
          onPressed: _openIncomeFormSheet,
          borderRadius: 25,
        ),
      ),
    );
  }

  void _openIncomeFormSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF121212),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          top: 25, left: 20, right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Source Name", style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 10),
            _buildInputField("Source Name"),

            const SizedBox(height: 20),
            const Text("Amount", style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 10),
            _buildInputField("Set Amount", isNumber: true),

            SizedBox(height: 20),
            const Text("Target Date", style: TextStyle(color: Colors.white, fontSize: 16)),
             SizedBox(height: 10),
            _buildInputField(
              "Set Target Date",
              isDate: true,
              controller: _dateController,
              onTap: () => _selectDate(context),
            ),

             SizedBox(height: 30),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Color(0xFF00E676),
                  padding:  EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                child:  Text("Save", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String hint, {bool isNumber = false, bool isDate = false, TextEditingController? controller, VoidCallback? onTap}) {
    return TextField(
      controller: controller,
      readOnly: isDate,
      onTap: onTap,
      style:  TextStyle(color: Colors.white),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:  TextStyle(color: Colors.white24),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        suffixIcon: isDate ? Icon(Icons.calendar_today, color: Colors.white, size: 18) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
    );
  }
}