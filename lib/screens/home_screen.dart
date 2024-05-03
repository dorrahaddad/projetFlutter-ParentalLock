import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled3/database/database_service.dart';
import 'package:untitled3/main_app_ui/home.dart';
import 'package:untitled3/screens/login_kid.dart';
import 'package:untitled3/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
   
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
   
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Image.asset(
                  'images/page.png',
                  height: 380,
                  ),
                 SizedBox(height: 20,),
            Text(
              "Hello, You're signed in!",
              style: TextStyle(fontSize: 22),
              
            ),
            SizedBox(height: 10),
            Text(
              user.email!,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
  onPressed: () {
    FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  },
  icon: Icon(Icons.exit_to_app),
  label: Text("Sign Out", style: TextStyle(fontSize: 18)),
  style: ElevatedButton.styleFrom(
  padding: EdgeInsets.all(14),
  backgroundColor: Color.fromARGB(255, 151, 53, 38),
  minimumSize: Size(double.infinity, 30), // increase width to fill available space
),
),
SizedBox(height: 20),
// Bouton "Add Child"
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OtherScreen()),
    );
  },
  child: Text("Add Child", style: TextStyle(fontSize: 18)),
 style: ElevatedButton.styleFrom(
  padding: EdgeInsets.all(14),
  backgroundColor: Color.fromARGB(255, 151, 53, 38),
  minimumSize: Size(double.infinity, 30), // increase width to fill available space
),
),
SizedBox(height: 20),
// Bouton "View Children"
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChildrenScreen()),
    );
  },
  child: Text("View Children", style: TextStyle(fontSize: 18)),
  style: ElevatedButton.styleFrom(
  padding: EdgeInsets.all(14),
  backgroundColor: Color.fromARGB(255, 151, 53, 38),
  minimumSize: Size(double.infinity, 30), // increase width to fill available space
),
),
          ],
        ),
      ),
    );
  }
}

class ChildrenScreen extends StatefulWidget {
  @override
  _ChildrenScreenState createState() => _ChildrenScreenState();
}

class _ChildrenScreenState extends State<ChildrenScreen> {
  final _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  List<Map<String, dynamic>> childrenList = [];

  @override
  void initState() {
    super.initState();
    getChildrenData();
  }

  Future<void> getChildrenData() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection('children')
        .where('email', isEqualTo: user.email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      List<Map<String, dynamic>> tempList = [];
      querySnapshot.docs.forEach((doc) {
        tempList.add({
          'enfant': doc['enfant'],
          'temps': doc['temps'],
        });
      });

      setState(() {
        childrenList = tempList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Children List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: childrenList.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  title: Text('Child: ${childrenList[index]['enfant']}'),
                  subtitle: Text('Time: ${childrenList[index]['temps']} minutes'),
                ),
                Divider(
                  thickness: 1, // Adjust the thickness of the underline as needed
                  color: Colors.grey, // Color of the underline
                  height: 0, // Remove any extra spacing above the underline
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
class OtherScreen extends StatelessWidget {
  final TextEditingController childController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  Future<void> addNewChild(BuildContext context) async {
    String childName = childController.text.trim();
    String childTime = timeController.text.trim();

    if (childName.isNotEmpty && childTime.isNotEmpty) {
      await _firestore.collection('children').add({
        'email': user.email,
        'enfant': childName,
        'temps': childTime,
      });

      childController.clear();
      timeController.clear();
       Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginKid()),
    );
       
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Child'),
      ),
      
      body: Padding(
         
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
             Image.asset(
                  'images/login.png',
                  height: 300,
                  ),
                 SizedBox(height: 20,),
            TextField(
              controller: childController,
              decoration: InputDecoration(
                labelText: 'Child Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: timeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Time in minutes',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
           ElevatedButton(
  onPressed: () {
    addNewChild(context); // Passage du contexte à la fonction
  },
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.all(14),
    backgroundColor: Color.fromARGB(255, 151, 53, 38), // Couleur d'arrière-plan personnalisée
  ),
  child: Text('Add Child'),
)

          ],
        ),
      ),
    );
  }
}
