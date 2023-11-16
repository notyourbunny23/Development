import 'package:flutter/material.dart';
import 'package:g_kasse/widgets.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF7FF),
      drawer: const GDrawer(),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        children: [
          GestureDetector(
            child: Image.asset("assets/logo_small.png"),
            onTap: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
          const Text(
            "About\n",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sed lobortis ex. Donec diam mi, tincidunt id blandit in, tempor eget velit. Integer porta, justo congue aliquet molestie, massa ligula scelerisque est, quis auctor enim est at odio. Cras aliquet in lacus non viverra. Quisque ex justo, consectetur sit amet dui et, finibus ornare ipsum. Phasellus tempus felis et interdum placerat. Duis tincidunt vitae erat non blandit. Fusce lacus lectus, venenatis sed nisi nec, posuere feugiat est. Praesent lectus leo, eleifend sit amet pharetra ut, scelerisque non nisl. Mauris viverra, metus in tincidunt consectetur, metus nunc convallis sem, quis tempor lorem ligula a nisl. Donec a eros nulla. Nullam nec metus vel metus tristique vulputate sed vel ex. Morbi quis ex eget eros ullamcorper interdum. Maecenas mauris odio, dapibus quis purus vel, vestibulum varius leo. Nulla mattis fermentum ante sit amet consequat.\n\nDonec feugiat at ligula semper ullamcorper. Ut maximus posuere mauris, sed tristique risus cursus non. Maecenas non felis lobortis, suscipit sapien id, tincidunt ligula. Nullam nec leo nibh. Maecenas et placerat metus. Curabitur imperdiet tortor id suscipit venenatis. Morbi elementum massa sed purus scelerisque molestie. Phasellus vestibulum et metus nec venenatis. Suspendisse potenti. Duis dignissim magna a magna cursus accumsan. Mauris convallis odio augue, in sollicitudin quam imperdiet id. Duis dapibus massa vel nibh congue, quis luctus urna porta. Vestibulum quis interdum arcu.")
        ],
      ),
    );
  }
}
