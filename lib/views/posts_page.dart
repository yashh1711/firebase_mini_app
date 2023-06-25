import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_mini_app/utils/routes.dart';
import 'package:flutter/material.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

FirebaseAuth _auth = FirebaseAuth.instance;

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('Posts Here'),
          )
        ],
      ),
    );
  }
}
