import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portal_eclb/view/widgets/container/alignment/centered_container.dart';
import 'package:portal_eclb/view/widgets/page_header/page_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                color: Colors.black,
                height: 72,
                width: 1536,
                child: Row(
                  children: <Widget>[
                    CenteredContainer(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Row(
                                children: <Widget>[
                                  Icon(FontAwesomeIcons.locationDot, color: Colors.white, size: 16,),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Praça Amaral Peixoto, 13, Centro, Bom Jesus do Itabapoana - RJ",
                                    textAlign: TextAlign.left,
                                    style:
                                    TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 75,
                                  ),
                                  IconButton(
                                      onPressed: () {

                                      },
                                      icon: Icon(FontAwesomeIcons.whatsapp, size: 16, color: Colors.white, )
                                  ),
                                  IconButton(
                                      onPressed: () {

                                      },
                                      icon: Icon(FontAwesomeIcons.instagram, size: 16, color: Colors.white, )
                                  ),
                                  IconButton(
                                      onPressed: () {

                                      },
                                      icon: Icon(FontAwesomeIcons.facebook, size: 16, color: Colors.white, )
                                  ),
                                  IconButton(
                                      onPressed: () {

                                      },
                                      icon: Icon(FontAwesomeIcons.youtube, size: 16, color: Colors.white, )
                                  ),
                                  SizedBox(
                                    width: 160,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.search),
                                        hintText: "Pesquisar",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0)
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey,


                                      ),

                                    ),
                                  ),
                                ]
                            )
                          ],
                        )
                    )
                  ],
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              CenteredContainer(
                child: Column(
                  children: <Widget>[
                    PageHeader()
                  ],
                ),
              )
            ],
          )
        ],
      )
    );
  }
}
