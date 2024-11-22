import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordsScreen extends StatefulWidget {
  const PasswordsScreen({super.key});

  @override
  State<PasswordsScreen> createState() => _PasswordsScreenState();
}

class _PasswordsScreenState extends State<PasswordsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          _buildSearchBar(),
          SizedBox(height: 20.h),
          Expanded(child: _buildPasswordList()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      cursorColor: const Color(0xff205BFF),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search_outlined, color: Colors.white),
        fillColor: const Color(0xff171A26),
        filled: true,
        hintText: "Search passwords...",
        hintStyle: GoogleFonts.outfit(color: const Color(0xff8F8F93)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      textInputAction: TextInputAction.search,
      onChanged: (value) {
        setState(() {
          _searchQuery = value.trim().toLowerCase();
        });
      },
    );
  }

  Widget _buildPasswordList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('passwords').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              "No passwords found",
              style: GoogleFonts.outfit(color: Colors.white),
            ),
          );
        }

        var filteredDocs = snapshot.data!.docs.where((doc) {
          var email = doc['email'].toString().toLowerCase();
          var website = doc['webLink'].toString().toLowerCase();
          var category = doc['category'].toString().toLowerCase();

          return email.contains(_searchQuery) ||
              website.contains(_searchQuery) ||
              category.contains(_searchQuery);
        }).toList();

        if (filteredDocs.isEmpty) {
          return Center(
            child: Text(
              "No results found for '$_searchQuery'",
              style: GoogleFonts.outfit(color: Colors.white),
            ),
          );
        }

        return ListView.builder(
          itemCount: filteredDocs.length,
          itemBuilder: (context, index) {
            var doc = filteredDocs[index];
            return _buildPasswordCard(doc);
          },
        );
      },
    );
  }

  Widget _buildPasswordCard(QueryDocumentSnapshot doc) {
    var email = doc['email'] ?? "No email"; 
    var website = doc['webLink'] ?? "No website";
    var category = doc['category'] ?? "No category";
    var password = doc['password'] ?? "No password";
    var docId = doc.id;

    return Card(
      color: const Color(0xff171A26),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onLongPress: () => _deletePassword(docId),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xff205BFF),
            child: Text(
              category[0].toUpperCase(),
              style: GoogleFonts.outfit(color: Colors.white),
            ),
          ),
          title: Text(
            category,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            email,
            style: GoogleFonts.outfit(
              color: const Color(0xff8F8F93),
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.copy, color: Colors.white),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: password));
              Fluttertoast.showToast(
                msg: "Password copied!",
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: Colors.green,
                textColor: Colors.white,
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _deletePassword(String docId) async {
    try {
      bool confirmDelete = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete Password",style: GoogleFonts.outfit(color: const Color(0xff205BFF),),),
            content: Text("Are you sure you want to delete this password?",style: GoogleFonts.outfit(color: Colors.black),),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("Cancel",style: GoogleFonts.outfit(color: Colors.black),),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text("Delete",style: GoogleFonts.outfit(color: Colors.red),),
              ),
            ],
          );
        },
      ) ?? false;

      if (confirmDelete) {
        await FirebaseFirestore.instance
            .collection('passwords')
            .doc(docId)
            .delete();
        
        Fluttertoast.showToast(
          msg: "Password deleted successfully!",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to delete password.",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
