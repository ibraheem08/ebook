import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook/user/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Userupdate extends StatefulWidget {
  final String myid;
  Userupdate(this.myid);

  @override
  State<Userupdate> createState() => _UserProfileState();
}

class UserProfiles {
  final String id;
  final String Fullname;
  final String Email;
  final String Password;

  UserProfiles(this.id, this.Fullname, this.Email, this.Password);
}

class _UserProfileState extends State<Userupdate> {
  List<UserProfiles> mylist = [];
  bool dataa = true;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.myid)
          .get();

      if (userSnapshot.exists) {
        var id = userSnapshot.id;
        var Fullname = userSnapshot['Fullname'];
        var Email = userSnapshot['Email'];
        var Password = userSnapshot['Password'];

        setState(() {
          mylist.add(UserProfiles(
            id,
            Fullname,
            Email,
            Password,
          ));
          nameController = TextEditingController(text: Fullname);
          emailController = TextEditingController(text: Email);
          passwordController = TextEditingController(text: Password);
        });
      } else {
        setState(() {
          dataa = false;
        });
      }
    } else {
      // Handle the case where there is no authenticated user
    }
  }

  void updateUserData() async {
    String newName = nameController.text;
    String newEmail = emailController.text;
    String newPassword = passwordController.text;

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.myid)
        .update({
      'Fullname': newName,
      'Email': newEmail,
      'Password': newPassword,
    });

    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/images/profile_image.jpg'),
            ),
            SizedBox(height: 20),
            SizedBox(height: 8),
            Text(
              'Premium User',
              style: TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            buildEditableInfoCard('Name', nameController),
            buildEditableInfoCard('Email', emailController),
            buildEditableInfoCard('Password', passwordController),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                updateUserData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(
                'Update Profile',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEditableInfoCard(String title, TextEditingController controller) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
        subtitle: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
