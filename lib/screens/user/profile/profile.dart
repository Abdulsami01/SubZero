import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  User? _user;
  String? _profileImageUrl;
  TextEditingController _bioController = TextEditingController();
  List<String> _preferredGenres = [];
  List<String> _links = [];
  final List<String> _allGenres = ['FPS', 'MOBA', 'RTS', 'RPG', 'Sports Games'];

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  // Future<void> _updateProfileImage() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (pickedFile != null) {
  //     String fileName =
  //         '${_user!.uid}_${DateTime.now().millisecondsSinceEpoch}';
  //     Reference ref = _storage.ref().child('profile_images').child(fileName);
  //     UploadTask uploadTask = ref.putFile(File(pickedFile.path));
  //     TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});
  //     String imageUrl = await snapshot.ref.getDownloadURL();
  //
  //     setState(() {
  //       _profileImageUrl = imageUrl;
  //     });
  //     _firestore
  //         .collection('users')
  //         .doc(_user!.uid)
  //         .update({'profileImageUrl': imageUrl});
  //   }
  // }

  Future<void> _addLink() async {
    TextEditingController linkController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Link'),
          content: TextField(
            controller: linkController,
            decoration: InputDecoration(hintText: 'Enter link'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _links.add(linkController.text);
                });
                _firestore
                    .collection('users')
                    .doc(_user!.uid)
                    .update({'links': _links});
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _deleteLink(int index) {
    setState(() {
      _links.removeAt(index);
    });
    _firestore.collection('users').doc(_user!.uid).update({'links': _links});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection('users').doc(_user!.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            var userData = snapshot.data!.data() as Map<String, dynamic>;
            _bioController.text = userData['bio'] ?? '';
            _preferredGenres =
                List<String>.from(userData['preferredGenres'] ?? []);
            _links = List<String>.from(userData['links'] ?? []);
            _profileImageUrl = userData['profileImageUrl'];

            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {},
                    // onTap: _updateProfileImage,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 50,
                      backgroundImage: _profileImageUrl != null
                          ? NetworkImage(_profileImageUrl!)
                          : null,
                      child: _profileImageUrl == null
                          ? Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    // onPressed: _updateProfileImage,
                    child: Text('Edit profile image'),
                  ),
                  _buildProfileInfo('Name', userData['name'] ?? ''),
                  SizedBox(
                    height: 10,
                  ),
                  _buildProfileInfo('Email', userData['email'] ?? ''),
                  SizedBox(
                    height: 20,
                  ),
                  _buildLinksSection(),
                  SizedBox(
                    height: 10,
                  ),
                  _buildPreferredGenresSection(),
                  SizedBox(
                    height: 30,
                  ),
                  _buildBioSection(),
                ],
              ),
            );
          } else {
            return Center(child: Text('No user data found'));
          }
        },
      ),
    );
  }

  Widget _buildProfileInfo(String title, String value) {
    return ListTile(
      title: Text(title),
      subtitle: Text(
        value,
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
    );
  }

  Widget _buildLinksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text('Links'),
          trailing: IconButton(
            icon: Icon(Icons.add),
            onPressed: _addLink,
          ),
        ),
        ..._links.asMap().entries.map((entry) {
          int index = entry.key;
          String link = entry.value;
          return ListTile(
            title: Text(link),
            leading: Icon(Icons.link_outlined),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteLink(index),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildPreferredGenresSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text('Preferred games genre'),
          trailing: DropdownButton<String>(
            icon: Icon(Icons.arrow_drop_down),
            onChanged: (value) {
              if (value != null && !_preferredGenres.contains(value)) {
                setState(() {
                  _preferredGenres.add(value);
                });
                _firestore
                    .collection('users')
                    .doc(_user!.uid)
                    .update({'preferredGenres': _preferredGenres});
              }
            },
            items: _allGenres.map((genre) {
              return DropdownMenuItem<String>(
                value: genre,
                child: Text(genre),
              );
            }).toList(),
          ),
        ),
        Wrap(
          spacing: 8.0,
          children: _preferredGenres.map((genre) {
            return Chip(
              label: Text(genre),
              onDeleted: () {
                setState(() {
                  _preferredGenres.remove(genre);
                });
                _firestore
                    .collection('users')
                    .doc(_user!.uid)
                    .update({'preferredGenres': _preferredGenres});
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBioSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text('Bio'),
          subtitle: Text(
            _bioController.text.isEmpty
                ? 'A description of this user.'
                : _bioController.text,
            style: TextStyle(color: Colors.black),
          ),
          trailing: Icon(Icons.edit),
          onTap: () async {
            TextEditingController bioEditController =
                TextEditingController(text: _bioController.text);
            await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Edit Bio'),
                  content: TextField(
                    controller: bioEditController,
                    decoration: InputDecoration(hintText: 'Enter bio'),
                    maxLines: null,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _bioController.text = bioEditController.text;
                        });
                        _firestore
                            .collection('users')
                            .doc(_user!.uid)
                            .update({'bio': _bioController.text});
                        Navigator.of(context).pop();
                      },
                      child: Text('Save'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
