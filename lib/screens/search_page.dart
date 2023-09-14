import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_info/screens/movie_page.dart';
import 'package:movie_info/screens/person_details.dart';
import 'package:movie_info/screens/tv_paage.dart';

import '../api_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  final service = APIService().getUpcomingMovie();

  String search = '';
  @override
  Widget build(BuildContext context) {
    final movie = APIService().searchMovie(search);
    final tv = APIService().searchTV(search);
    final person = APIService().searchPerson(search);

    TabController tabController = TabController(length: 3, vsync: this);
    final _height = MediaQuery.of(context).size.height - kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 27, 35, 39),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                Container(
                  height: 50,
                  width: _width * 0.8,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        search = value;
                      });
                    },
                    // onSubmitted: (value) {
                    //   setState(() {
                    //     search = value;
                    //   });
                    // },
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Search ...',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      // focusColor: Colors.amberAccent,
                      // fillColor: Colors.red ,
                    ),
                  ),
                ),
                //  Text('data')
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              color: const Color.fromARGB(255, 27, 35, 39),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: TabBar(
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blueGrey),
                    controller: tabController,
                    indicatorColor: Colors.cyan,
                    tabs: const [
                      Tab(
                        child: Text(
                          'Movie',
                          style: TextStyle(
                              fontSize: 18, color: Colors.amberAccent),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'TV Show',
                          style: TextStyle(
                              fontSize: 18, color: Colors.amberAccent),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'People',
                          style: TextStyle(
                              fontSize: 18, color: Colors.amberAccent),
                        ),
                      )
                    ],
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            // Text('data')
            // Container(
            //     //  margin: EdgeInsets.only(bottom: 10),
            //     //   color: Colors.cyanAccent,
            //     // width: _width * 0.95,
            //     // height: _height * 0.8,
            //     child:
            Expanded(
              child: TabBarView(controller: tabController, children: [
                FutureBuilder(
                    // **************************  Movie *************************************
                    future: movie,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              // crossAxisSpacing: 0,
                              // mainAxisSpacing: 18,
                            ),
                            itemCount: 8,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    width: _width * 0.31,
                                    height: _height * 0.23,
                                    // decoration: const BoxDecoration(
                                    //   color: Color.fromARGB(255, 65, 65, 65),
                                    //   borderRadius: BorderRadius.only(
                                    //       topLeft: Radius.circular(12),
                                    //       topRight: Radius.circular(12)),
                                    // ),
                                  ),
                                  Container(
                                    width: _width * 0.31,
                                    //    color: Colors.black38,
                                    // decoration: const BoxDecoration(
                                    //     color: Colors.black87,
                                    //     borderRadius: BorderRadius.only(
                                    //         bottomLeft: Radius.circular(12),
                                    //         bottomRight: Radius.circular(12))),
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 6, left: 3, right: 3),
                                  ),
                                ],
                              );
                            }
                            // else {
                            //   return Container(
                            //       // color: Colors.amberAccent,
                            //       // child: Text('Not Found!'),
                            //       );
                            // }
                            );
                      }
                      List wwww = snapshot.data;
                      return GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            //   crossAxisSpacing: 10,
                            // mainAxisSpacing: 20,
                          ),
                          itemCount: wwww.length,
                          itemBuilder: (context, index) {
                            if (wwww[index]['title']
                                .toString()
                                .toLowerCase()
                                .startsWith(search)) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: ((context) {
                                    return MoviePage(id: wwww[index]['id']);
                                  })));
                                },
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12)),
                                      child: CachedNetworkImage(
                                        width: _width * 0.31,
                                        height: _height * 0.20,
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/w200' +
                                                wwww[index]['poster_path']
                                                    .toString(),
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) {
                                          return Center(
                                              child: Container(
                                            color: const Color.fromARGB(
                                                255, 65, 65, 65),
                                          ));
                                        },
                                        errorWidget: (context, url, error) {
                                          return Container(
                                            color: Colors.brown,
                                            child: const Icon(
                                              Icons.error,
                                              size: 50,
                                              color: Colors.white10,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: _width * 0.31,
                                      //    color: Colors.black38,
                                      decoration: const BoxDecoration(
                                          color: Colors.black87,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(12),
                                              bottomRight:
                                                  Radius.circular(12))),
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 6, left: 3, right: 3),
                                      child: Text(
                                        wwww[index]['title'].toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                            // else {
                            //   return Container(
                            //       // color: Colors.amberAccent,
                            //       // child: Text('Not Found!'),
                            //       );
                            // }
                          });
                    }),
                FutureBuilder(
                    // **************************  TV *************************************
                    future: tv,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              // crossAxisSpacing: 0,
                              // mainAxisSpacing: 18,
                            ),
                            itemCount: 8,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    width: _width * 0.31,
                                    height: _height * 0.20,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 65, 65, 65),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12)),
                                    ),
                                  ),
                                  Container(
                                    width: _width * 0.31,
                                    //    color: Colors.black38,
                                    decoration: const BoxDecoration(
                                        color: Colors.black87,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(12),
                                            bottomRight: Radius.circular(12))),
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 6, left: 3, right: 3),
                                  ),
                                ],
                              );
                            }
                            // else {
                            //   return Container(
                            //       // color: Colors.amberAccent,
                            //       // child: Text('Not Found!'),
                            //       );
                            // }
                            );
                      }
                      List wwww = snapshot.data;
                      return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: wwww.length,
                          itemBuilder: (context, index) {
                            if (wwww[index]['name']
                                .toString()
                                .toLowerCase()
                                .startsWith(search)) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: ((context) {
                                    return TVpage(id: wwww[index]['id']);
                                  })));
                                },
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12)),
                                      child: CachedNetworkImage(
                                        width: _width * 0.31,
                                        height: _height * 0.20,
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/w300' +
                                                wwww[index]['poster_path']
                                                    .toString(),
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) {
                                          return Center(
                                              child: Container(
                                            color: const Color.fromARGB(
                                                255, 65, 65, 65),
                                          ));
                                        },
                                        errorWidget: (context, url, error) {
                                          return Container(
                                            color: Colors.brown,
                                            child: const Icon(
                                              Icons.error,
                                              size: 50,
                                              color: Colors.white10,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: _width * 0.31,
                                      //    color: Colors.black38,
                                      decoration: const BoxDecoration(
                                          color: Colors.black54,
                                          // border: Border(
                                          //     bottom: BorderSide(
                                          //         color: Colors.white)),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(12),
                                              bottomRight:
                                                  Radius.circular(12))),
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 6, left: 3, right: 3),
                                      child: Text(
                                        wwww[index]['name'].toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                            // else {
                            //   return Container(
                            //       // color: Colors.amberAccent,
                            //       // child: Text('Not Found!'),
                            //       );
                            // }
                          });
                    }),
                FutureBuilder(
                    // **************************  Person *************************************
                    future: person,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              // crossAxisSpacing: 0,
                              // mainAxisSpacing: 18,
                            ),
                            itemCount: 8,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    width: _width * 0.31,
                                    height: _height * 0.23,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 65, 65, 65),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12)),
                                    ),
                                  ),
                                  Container(
                                    width: _width * 0.31,
                                    //    color: Colors.black38,
                                    decoration: const BoxDecoration(
                                        color: Colors.black87,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(12),
                                            bottomRight: Radius.circular(12))),
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 6, left: 3, right: 3),
                                  ),
                                ],
                              );
                            }
                            // else {
                            //   return Container(
                            //       // color: Colors.amberAccent,
                            //       // child: Text('Not Found!'),
                            //       );
                            // }
                            );
                      }
                      List wwww = snapshot.data;
                      //  print(wwww);
                      return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            // crossAxisSpacing: 0,
                            // mainAxisSpacing: 18,
                          ),
                          itemCount: wwww.length,
                          itemBuilder: (context, index) {
                            if (wwww[index]['name']
                                .toString()
                                .toLowerCase()
                                .startsWith(search)) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: ((context) {
                                    return PersonDetail(
                                      id: wwww[index]['id'],
                                      name: wwww[index]['name'],
                                    );
                                  })));
                                },
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12)),
                                      child: CachedNetworkImage(
                                        width: _width * 0.31,
                                        height: _height * 0.20,
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/w300' +
                                                wwww[index]['profile_path']
                                                    .toString(),
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) {
                                          return Center(
                                              child: Container(
                                            color: const Color.fromARGB(
                                                255, 65, 65, 65),
                                          ));
                                        },
                                        errorWidget: (context, url, error) {
                                          return Container(
                                            color: Colors.brown,
                                            child: const Icon(
                                              Icons.error,
                                              size: 50,
                                              color: Colors.white10,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: _width * 0.31,
                                      //    color: Colors.black38,
                                      decoration: const BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(12),
                                              bottomRight:
                                                  Radius.circular(12))),
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 6, left: 3, right: 3),
                                      child: Text(
                                        wwww[index]['name'].toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                            // else {
                            //   return Container(
                            //       // color: Colors.amberAccent,
                            //       // child: Text('Not Found!'),
                            //       );
                            // }
                          });
                    }),
              ]),
            )
            // )
          ],
        ),
      ),
    );
  }
}
