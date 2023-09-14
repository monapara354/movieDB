import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_info/api_service.dart';

import 'package:movie_info/screens/movie_page.dart';
import 'package:movie_info/screens/tv_paage.dart';
import 'package:readmore/readmore.dart';

class PersonDetail extends StatelessWidget {
  int id;
  String name;
  PersonDetail({super.key, required this.id, required this.name});

  @override
  Widget build(BuildContext context) {
    final service = APIService().getPerson(id);
    final movieLists = APIService().personMovies(id);
    final tvLists = APIService().personTV(id);
    final _height = MediaQuery.of(context).size.height - kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;

    String gender(int value) {
      if (value == 2) {
        return 'Male';
      }
      return 'Female';
    }

    // print(id);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 35, 39),
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text(name),
        centerTitle: true,
        elevation: 3,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: service,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: _height * 0.4,
                  // decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(25),
                  //     color: Colors.amberAccent),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 5, bottom: 10),
                  //  color: Colors.cyan,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  //  width: _width * 0.5,
                );
              }
              //  print('ddddd' + snapshot.data!.id.toString());
              return Column(
                children: [
                  Container(
                    height: _height * 0.4,
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(25),
                    //     color: Colors.amberAccent),
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 5, bottom: 10),
                    //  color: Colors.cyan,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        imageUrl: 'https://image.tmdb.org/t/p/w300' +
                            snapshot.data!.profilePath.toString(),
                        fit: BoxFit.fill,
                        placeholder: (context, url) {
                          return Center(
                              child: Container(
                            width: _width * 0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromARGB(255, 65, 65, 65),
                            ),
                            //  color: const Color.fromARGB(255, 65, 65, 65),
                          ));
                        },
                        errorWidget: (context, url, error) {
                          return const Icon(
                            Icons.person,
                            color: Colors.cyan,
                            size: 50,
                          );
                        },
                        // width: _width * 0.75,
                        // height: _height * 0.4,
                      ),
                    ),
                    //  width: _width * 0.5,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      snapshot.data!.name.toString(),
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.cyanAccent,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      snapshot.data!.knownForDepartment.toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  info(
                      'Birth Date', snapshot.data!.birthday.toString(), _width),
                  info('gender', gender(snapshot.data!.gender as int), _width),
                  info('Place Of Birth', snapshot.data!.placeOfBirth.toString(),
                      _width),
                  Container(
                    //  color: Colors.amberAccent,
                    //  width: _width * 0.35,
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 10, left: 18),
                    child: const Text(
                      'Overview',
                      style: TextStyle(
                          color: Color.fromARGB(255, 131, 175, 195),
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    //  color: Colors.amberAccent,
                    // width: _width * 0.35,
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 13, left: 30, right: 10),
                    child: ReadMoreText(
                      snapshot.data!.biography.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      // overflow: TextOverflow.fade,
                      trimLines: 5,
                      moreStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.cyanAccent,
                      ),
                      lessStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.cyanAccent,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    //  color: Colors.amberAccent,
                    //  width: _width * 0.35,
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 10, left: 18, bottom: 5),
                    child: const Text(
                      'Movies',
                      style: TextStyle(
                          color: Colors.amberAccent,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  movieList(_height, movieLists, _width),
                  const SizedBox(
                    height: 10,
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Container(
                    //  color: Colors.amberAccent,
                    //  width: _width * 0.35,
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 18, bottom: 5),
                    child: const Text(
                      'TV Show',
                      style: TextStyle(
                          color: Colors.amberAccent,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TvList(_height, tvLists, _width),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            }),
      ),
    );
  }

  Row info(String title, String value, double _width) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // color: Colors.amberAccent,
          width: _width * 0.20,
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(top: 10, left: 18),
          child: Text(
            title,
            style: const TextStyle(
                color: Color.fromARGB(255, 131, 175, 195),
                fontWeight: FontWeight.w500,
                fontSize: 15),
            overflow: TextOverflow.visible,
          ),
        ),
        Container(
          // color: Colors.cyanAccent,
          width: _width * 0.50,
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(top: 10, left: 18),
          child: Text(
            value.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 16),
            overflow: TextOverflow.clip,
          ),
        ),
      ],
    );
  }
}

////  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

Container movieList(double _height, Future sss, double _width) {
  return Container(
    margin: const EdgeInsets.only(left: 10),
    height: _height * 0.30,
    alignment: Alignment.center,
    // color: Colors.amberAccent,
    //   width: _width * 0.4,
    child: FutureBuilder(
      future: sss,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: ((context, index) {
                return Container(
                  alignment: Alignment.center,
                  foregroundDecoration: const BoxDecoration(
                    borderRadius:
                        BorderRadiusDirectional.all(Radius.circular(15)),
                  ),
                  width: _width * 0.31,
                  //  height: _height * 0.30,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.amberAccent),
                  //   borderRadius:
                  //       BorderRadiusDirectional.all(Radius.circular(20)),
                  //   // color: Colors.black45,
                  // ),
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 65, 65, 65),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                        ),
                        // color: Colors.amberAccent,

                        // padding: EdgeInsets.symmetric(horizontal: 5),
                        // margin: EdgeInsets.symmetric(horizontal: 5),
                        width: _width * 0.31,
                        // height: _height * 0.25,
                      ),
                      //  Spacer(flex: 6),
                      Container(
                        // padding: EdgeInsets.only(left: 5, right: 5),
                        width: _width * 0.31,
                        //    color: Colors.black38,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 65, 65, 65),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                );
              }));
        }
        //  List wwww = snapshot.data;
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: snapshot.data['cast'].length,
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return MoviePage(id: snapshot.data['cast'][index]['id']);
                  })));
                },
                child: Container(
                  // color: Colors.amber,
                  // foregroundDecoration: BoxDecoration(
                  //   border: Border.all(color: Colors.white),
                  //   borderRadius:
                  //       const BorderRadiusDirectional.all(Radius.circular(12)),
                  // ),
                  //  width: _width * 0.31,
                  //  height: _height * 0.30,
                  //  margin: const EdgeInsets.symmetric(horizontal: 7),
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.amberAccent),
                  //   borderRadius:
                  //       BorderRadiusDirectional.all(Radius.circular(20)),
                  //   // color: Colors.black45,
                  // ),
                  child: Column(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        width: _width * 0.31,
                        height: _height * 0.23,
                        margin:
                            const EdgeInsets.only(top: 5, left: 7, right: 7),
                        decoration: const BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12))),
                        child: CachedNetworkImage(
                          imageUrl: 'https://image.tmdb.org/t/p/w300' +
                              snapshot.data['cast'][index]['poster_path']
                                  .toString(),
                          fit: BoxFit.fill,
                          placeholder: (context, url) {
                            return Center(
                                child: Container(
                              width: _width * 0.31,
                              height: _height * 0.23,
                              color: const Color.fromARGB(255, 65, 65, 65),
                            ));
                          },
                          errorWidget: (context, url, error) {
                            return Container(
                                //  color: Colors.amberAccent,
                                width: _width * 0.28,
                                child: const Icon(
                                  Icons.error,
                                  size: 40,
                                ));
                          },
                        ),
                      ),
                      //  Spacer(flex: 6),
                      Container(
                        width: _width * 0.31,
                        margin: const EdgeInsets.only(left: 7, right: 7),
                        padding: const EdgeInsets.only(left: 5, right: 5),

                        //    color: Colors.black38,
                        decoration: const BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12))),
                        alignment: Alignment.center,
                        // padding: const EdgeInsets.only(
                        //     top: 11, bottom: 10, left: 2, right: 2),
                        child: Text(
                          snapshot.data['cast'][index]['title'].toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
      },
    ),
  );
}
//  *********  tv show ***************************************************

Container TvList(double _height, Future sss, double _width) {
  return Container(
    margin: const EdgeInsets.only(left: 10),
    height: _height * 0.30,
    // color: Colors.amber,
    alignment: Alignment.center,
    //   width: _width * 0.4,
    child: FutureBuilder(
      future: sss,
      builder: (context, snapshot) {
        print(snapshot.hasData);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: ((context, index) {
                return Container(
                  alignment: Alignment.center,
                  foregroundDecoration: const BoxDecoration(
                    borderRadius:
                        BorderRadiusDirectional.all(Radius.circular(15)),
                  ),
                  width: _width * 0.31,
                  //  height: _height * 0.30,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.amberAccent),
                  //   borderRadius:
                  //       BorderRadiusDirectional.all(Radius.circular(20)),
                  //   // color: Colors.black45,
                  // ),
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 65, 65, 65),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                        ),
                        // color: Colors.amberAccent,

                        // padding: EdgeInsets.symmetric(horizontal: 5),
                        // margin: EdgeInsets.symmetric(horizontal: 5),
                        width: _width * 0.31,
                        // height: _height * 0.25,
                      ),
                      //  Spacer(flex: 6),
                      Container(
                        // padding: EdgeInsets.only(left: 5, right: 5),
                        width: _width * 0.31,
                        //    color: Colors.black38,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 65, 65, 65),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                );
              }));
        }

        return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: snapshot.data['cast'].length,
            itemBuilder: ((context, index) {
              return
                  //  snapshot.data['cast'].length == null
                  //     ? Container(
                  //         color: Colors.amberAccent,
                  //         width: 100,
                  //         height: 100,
                  //       )
                  //     :
                  InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return TVpage(id: snapshot.data['cast'][index]['id']);
                  })));
                },
                child: Container(
                  alignment: Alignment.center,
                  // foregroundDecoration: const BoxDecoration(
                  //   borderRadius:
                  //       BorderRadiusDirectional.all(Radius.circular(15)),
                  // ),
                  // color: Colors.red,

                  // width: _width * 0.31,
                  // height: _height * 0.30,

                  // margin: const EdgeInsets.symmetric(horizontal: 5),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(12),
                  //   // color: Colors.red,
                  // ),
                  child: Column(
                    children: [
                      //  Flexible(
                      //   borderRadius: BorderRadius.only(
                      //           topLeft: Radius.circular(15),
                      //           topRight: Radius.circular(15))
                      // // fit: FlexFit.tight,
                      // flex: 6,
                      // child:
                      Container(
                        clipBehavior: Clip.hardEdge,
                        width: _width * 0.31,
                        height: _height * 0.23,
                        margin:
                            const EdgeInsets.only(top: 5, left: 7, right: 7),
                        decoration: const BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12))),
                        child: CachedNetworkImage(
                          // width: _width * 0.31,

                          imageUrl: 'https://image.tmdb.org/t/p/w300' +
                              snapshot.data['cast'][index]['poster_path']
                                  .toString(),
                          fit: BoxFit.fill,
                          placeholder: (context, url) {
                            return Center(
                                child: Container(
                              width: _width * 0.31,
                              height: _height * 0.23,
                              color: const Color.fromARGB(255, 65, 65, 65),
                            ));
                          },
                          errorWidget: (context, url, error) {
                            return Container(
                                //  color: Colors.amberAccent,
                                width: _width * 0.28,
                                child: const Icon(
                                  Icons.error,
                                  size: 40,
                                ));
                          },
                        ),
                      ),

                      Container(
                        width: _width * 0.31,
                        //    color: Colors.black38,
                        margin: const EdgeInsets.only(left: 7, right: 7),
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        decoration: const BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12))),
                        alignment: Alignment.center,
                        // padding: const EdgeInsets.only(
                        //     top: 11, bottom: 10, left: 2, right: 2),
                        child: Text(
                          snapshot.data['cast'][index]['name'].toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
      },
    ),
  );
}
