import 'package:flutter/material.dart';
import 'package:untitled3/screens/login_kid.dart';
import 'package:untitled3/screens/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  void Kid(BuildContext context) {
     Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginKid()),
                );
  }

  void Parent(BuildContext context) {
     Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('KIDZY'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo en haut de la page
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Column(
                children: [
                  Image.asset(
                    'images/kidzy.png', // Chemin vers votre image de logo
                    width: 200, // Taille réduite du logo
                    height: 200,
                  ),
                  SizedBox(height: 20), // Espacement entre le logo et le texte
                  Text(
                    'Welcome',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // Espacement entre le texte et les boutons

            // Boutons avec des images au centre de la page
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                
                   child: GestureDetector(
  onTap: () {
    // Action à effectuer lors du clic sur le CircleAvatar
    Parent(context);
    print('CircleAvatar clicked!');
  },
  child: CircleAvatar(
    radius: 50,
    backgroundColor: Colors.black,
    backgroundImage: AssetImage('images/4.png'),
    
  ),
)
                ),
                Text(
                  'Parent',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16, // Taille de texte réduite
                  ),
                ),
                SizedBox(height: 10), // Espacement entre le texte et le deuxième bouton
                Padding(
                  padding: const EdgeInsets.all(10.0),
                
                    child: GestureDetector(
  onTap: () {
    // Action à effectuer lors du clic sur le CircleAvatar
    Kid(context);
    print('CircleAvatar clicked!');
  },
  child: CircleAvatar(
    radius: 50,
    backgroundColor: Colors.black,
    backgroundImage: AssetImage('images/5.png'),
    
  ),
)


                  
                ),
                Text(
                  'Kid',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16, // Taille de texte réduite
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ImageCircleButton extends StatelessWidget {
  final String imagePath;

  const ImageCircleButton({
    required this.imagePath, required Null Function() onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {}, // Vous pouvez laisser vide car onPressed est géré dans le parent
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(15), // Taille réduite du bouton
        backgroundColor: Colors.white,
      ),
      child: CircleAvatar(
        backgroundImage: AssetImage(imagePath),
        radius: 40, // Taille réduite du cercle
      ),
    );
  }
}
