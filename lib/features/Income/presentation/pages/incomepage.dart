import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/CustomButton.dart';
import '../../../../core/utils/Customcontainer.dart';
import '../../../../core/utils/summaryContainer.dart';
import '../../../../core/utils/TextField.dart';
import '../../../../core/utils/bottom_sheet_helper.dart';

class incomePage extends StatefulWidget {
  const incomePage({super.key});

  @override
  State<incomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<incomePage> {
  final TextEditingController _sourceNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  final CollectionReference incomeRef = FirebaseFirestore.instance.collection('incomes');

  Future<void> _saveOrUpdateIncome({String? docId}) async {
    if (_sourceNameController.text.isNotEmpty && _amountController.text.isNotEmpty) {
      Map<String, dynamic> data = {
        "title": _sourceNameController.text,
        "price": _amountController.text,
        "date": _dateController.text.isEmpty
            ? DateFormat('dd-MM-yyyy').format(DateTime.now())
            : _dateController.text,
        "timestamp": FieldValue.serverTimestamp(),
      };

      if (docId == null) {
        await incomeRef.add(data);
      } else {
        await incomeRef.doc(docId).update(data);
      }

      _sourceNameController.clear();
      _amountController.clear();
      _dateController.clear();
      Navigator.pop(context);
    }
  }

  void _openIncomeFormSheet({String? docId, String? oldTitle, String? oldPrice, String? oldDate}) {
    if (docId != null) {
      _sourceNameController.text = oldTitle ?? "";
      _amountController.text = oldPrice ?? "";
      _dateController.text = oldDate ?? "";
    } else {
      _sourceNameController.clear();
      _amountController.clear();
      _dateController.clear();
    }

    final screenHeight = MediaQuery.of(context).size.height;

    openCustomSheet(
      context: context,
      title: docId == null ? "Add New Income" : "Edit Income",
      fields: [
        CustomTextField(
          label: "Source Name",
          controller: _sourceNameController,
          isPassword: false,
        ),
        SizedBox(height: screenHeight * 0.015),
        CustomTextField(
          label: "Amount",
          controller: _amountController,
          isPassword: false,
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: screenHeight * 0.015),
        CustomTextField(
          label: "Date",
          controller: _dateController,
          isPassword: false,
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              builder: (context, child) => Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.dark(
                    primary: Color(0xFF72E369),
                    onPrimary: Colors.white,
                    surface: Color(0xFF101010),
                    onSurface: Colors.white,
                  ),
                ),
                child: child!,
              ),
            );
            if (picked != null) {
              setState(() {
                _dateController.text = DateFormat('dd-MM-yyyy').format(picked);
              });
            }
          },
        ),
      ],
      actionText: docId == null ? "Save" : "Update",
      onAction: () => _saveOrUpdateIncome(docId: docId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Income", style: TextStyle(color: Colors.white, fontSize: 24)),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: incomeRef.orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Center(child: Text("Error loading data", style: TextStyle(color: Colors.white)));
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator(color: Color(0xFF00E676)));

          var docs = snapshot.data!.docs;
          double total = 0;
          for (var doc in docs) {
            total += double.tryParse(doc['price'].toString().replaceAll(',', '')) ?? 0;
          }

          return Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SummaryCard(
                  title: "Total Income this month",
                  value: "\$ ${NumberFormat('#,###').format(total)}",
                ),
                SizedBox(height: screenHeight * 0.02),
                const Text("Income Sources", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: screenHeight * 0.02),
                Expanded(
                  child: ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      var data = docs[index].data() as Map<String, dynamic>;
                      String docId = docs[index].id;

                      return Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                        child: Customcontainer(
                          title: data['title'],
                          remainingText: data['date'],
                          price: data['price'],
                          onEdit: () => _openIncomeFormSheet(
                            docId: docId,
                            oldTitle: data['title'],
                            oldPrice: data['price'],
                            oldDate: data['date'],
                          ),
                          onDelete: () => incomeRef.doc(docId).delete(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: screenHeight * 0.01),
        child: CustomButton(
          text: "+ Add Income",
          width: screenWidth * 0.45,
          height: screenHeight * 0.065,
          onPressed: () => _openIncomeFormSheet(),
          borderRadius: screenWidth * 0.05,
        ),
      ),
    );
  }
}