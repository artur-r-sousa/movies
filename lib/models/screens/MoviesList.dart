import 'dart:collection';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies/models/entities/Movie.dart';
import 'package:movies/models/entities/User.dart';
import '../../ApiControl.dart';


class MoviesList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList>{
  Future<Movie> futureMovie;
  List<Movie> updatedList;
  static const double defaultPadding = 8.0;
  String movieName = "";

  TextEditingController movieNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    User mockupUser = new User(1, 'artur', new HashSet());

    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Movies',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontFamily: 'SourceSansPro')),
              CircleAvatar(
                backgroundColor: Colors.blueGrey[50],
              )
            ],
          ),

        ),
        drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Material(
                                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                child: Padding(padding: EdgeInsets.all(8.0),
                                  child: Image.asset('lib/assets/images/personLogo.png', width: 100, height: 100,),)
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(mockupUser.name, style: TextStyle(fontSize: 18, color: Colors.white),),
                              ),
                            ],
                          ),
                        ],
                      )
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Colors.deepOrange,
                          Colors.orangeAccent
                        ]
                      )
                  ),
                ),
                ListTile(
                  title: Text('Profile Info'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Favorites'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            )
        ),
        body: Container(
            color: Colors.white,
            child: SizedBox(
              width: width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding, vertical: defaultPadding),
                        child: SizedBox(
                          width: width-50,
                          child: TextField(
                            onChanged: (_) {
                              setState(() {
                                movieName = movieNameController.text;
                              });
                            },
                            controller: movieNameController,
                            decoration: InputDecoration(
                                fillColor: Colors.blueGrey[50],
                                filled: true,
                                hintText: 'Search a movie name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),

                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: FutureBuilder<List<Movie>>(
                        future: ApiControl().fetchMovies(movieName),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                itemCount: ApiControl.list.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(9.0),
                                        child: Card(
                                          elevation: 9.0,
                                          child: Row(
                                            children: <Widget>[

                                              SizedBox(
                                                  height: 350,
                                                  width: 250,
                                                  child: Image.network(
                                                      'https://image.tmdb.org/t/p/w500/' +
                                                          snapshot.data[index]
                                                              .posterPath)),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,

                                                  children: <Widget>[
                                                    AutoSizeText(
                                                      snapshot.data[index].name,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                      maxLines: 4,
                                                      minFontSize: 12,
                                                      softWrap: true,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                    ),
                                                    Row(
                                                      children: [
                                                        AutoSizeText(
                                                          snapshot.data[index]
                                                              .ratings,
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                          ),
                                                          maxLines: 4,
                                                          softWrap: true,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          color:
                                                          Colors.yellowAccent,
                                                        )
                                                      ],
                                                    ),
                                                    AutoSizeText(
                                                      DateFormat("yyyy").format(
                                                          DateTime.parse(snapshot
                                                              .data[index]
                                                              .releaseDate)),
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                      maxLines: 4,
                                                      softWrap: true,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(height: 200,)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10,)
                                    ],
                                  );
                                });
                          } else if (!snapshot.hasData) {
                            print('no data');

                            Text('this');
                          }
                          return Text('');
                        }),
                  )
                ],
              ),
            )),
      ),
    );
  }
}