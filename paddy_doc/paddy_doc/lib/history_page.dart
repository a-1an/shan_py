import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paddy_doc/model/history_model.dart';

class HistoryPage extends StatelessWidget {
  final List<HistoryModel> historyList;
  const HistoryPage({super.key, required this.historyList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History",
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 24.0,
              color: Color(0xFFFFFFFF),
            )),
        backgroundColor: const Color(0xFFA0C056),
      ),
      body: historyList.isEmpty
          ? const Center(
              child: Text("No History yet!!"),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ListView.separated(
                  itemBuilder: (context, index) =>
                      thumbNail(historyList[index]),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 5,
                      ),
                  itemCount: historyList.length),
            ),
    );
  }

  Widget thumbNail(HistoryModel historyModel) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime dateTime = dateFormat.parse(historyModel.date);
    String time = DateFormat('hh:mm a').format(DateTime.now());

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(
            File(historyModel.imagePath),
            height: 180.0,
            width: double.infinity,
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              const Icon(Icons.date_range),
              Text(
                historyModel.date.split(' ').first,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.lock_clock),
              Text(
                time,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            historyModel.diseaseIdentified,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
