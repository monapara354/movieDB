import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_info/api_service.dart';
import 'package:movie_info/screens/person_details.dart';

class TVpage extends StatelessWidget {
  int id;
  TVpage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    var servies = APIService().getTVdetail(id);
    var castD = APIService().getTVCast(id);

    final _height = MediaQuery.of(context).size.height - kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;

    String aaa(String dates) {
      var sss = DateTime.parse(dates);
      String date = DateFormat.yMMMd('en_US').format(sss);
      return date;
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 35, 39), //87
      body: FutureBuilder(
          future: servies,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // border: Border.all(width: 2),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 0.8,
                        color: Colors.blueGrey)
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            }

            return Stack(
              children: [
                Opacity(
                  opacity: 0.6,
                  child: CachedNetworkImage(
                    imageUrl: 'https://image.tmdb.org/t/p/w400' +
                        snapshot.data!.backdropPath.toString(),
                    // movieList[0]['backdrop_path'].toString(),
                    placeholder: (context, url) {
                      return Center(
                          child: Container(
                        color: const Color.fromARGB(255, 65, 65, 65),
                      ));
                    },
                    errorWidget: (context, url, error) {
                      return const Icon(
                        Icons.person,
                        color: Colors.cyan,
                        size: 50,
                      );
                    },
                    width: double.infinity,
                    height: 250,
                  ),
                ),
                SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                iconSize: 28,
                                color: Colors.white,
                                onPressed: (() {
                                  Navigator.pop(context);
                                }),
                                icon: const Icon(Icons.arrow_back),
                              ),
                              // IconButton(
                              //   iconSize: 28,
                              //   color: Colors.white,
                              //   onPressed: (() {}),
                              //   icon: const Icon(Icons.favorite),
                              // )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  // border: Border.all(width: 2),
                                  boxShadow: const [
                                    BoxShadow(
                                        blurRadius: 5,
                                        spreadRadius: 0.8,
                                        color: Colors.blueGrey)
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/w300' +
                                            snapshot.data!.posterPath
                                                .toString(),
                                    placeholder: (context, url) {
                                      return Center(
                                          child: Container(
                                        color: const Color.fromARGB(
                                            255, 65, 65, 65),
                                      ));
                                    },
                                    errorWidget: (context, url, error) {
                                      return const Icon(
                                        Icons.person,
                                        color: Colors.cyan,
                                        size: 50,
                                      );
                                    },
                                    width: _width * 0.35, //150
                                    height: _height * 0.30,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    //  color: Colors.brown,
                                    width: _width * 0.5,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      snapshot.data!.name.toString(),
                                      style: const TextStyle(
                                          fontSize: 25, color: Colors.white),
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                  // Container(
                                  //   margin:
                                  //       const EdgeInsets.only(left: 20, top: 5),
                                  //   child: Text(
                                  //    // snapshot.data!.networks.toString() +

                                  //     // durationToString(
                                  //     //         snapshot.data!.runtime as int)
                                  //     //     .toString(),
                                  //     // snapshot.data!.runtime.toString() +
                                  //     //     'min ',
                                  //     style: const TextStyle(
                                  //         fontSize: 16, color: Colors.white),
                                  //   ),
                                  // ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 20, top: 10),
                                    child: Row(
                                      children: [
                                        Container(
                                          //  color: Colors.brown,
                                          width: _width * 0.10,
                                          height: _height * 0.06,
                                          child: Image.asset(
                                            'asset/tmdb.png',
                                            // width: 20,
                                            // height: 20,
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 8),
                                          alignment: Alignment.center,
                                          child: Text(
                                            snapshot.data!.voteAverage
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.amberAccent),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          //  color: Colors.amberAccent,
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(
                              left: 20, top: 20, right: 5),
                          width: _width,
                          height: _height * 0.05,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 75, 97, 108),
                                    border: Border.all(color: Colors.white30),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                // color: Colors.blueGrey,
                                margin: const EdgeInsets.only(left: 7, top: 5),
                                padding: const EdgeInsets.only(
                                  left: 5,
                                  right: 5,
                                ),
                                child: Text(
                                  snapshot.data!.genres[index].name.toString(),
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              );
                            },
                            itemCount: snapshot.data!.genres.length,
                          ),
                        ),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        Container(
                          //  color: Colors.amberAccent,
                          //  width: _width * 0.35,
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(top: 10, left: 18),
                          child: const Text(
                            'Networks',
                            style: TextStyle(
                                color: Color.fromARGB(255, 131, 175, 195),
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          //  color: Colors.amberAccent,
                          alignment: Alignment.topLeft,
                          margin:
                              const EdgeInsets.only(left: 40, top: 5, right: 5),
                          width: _width,
                          height: _height * 0.05,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 75, 97, 108),
                                    border: Border.all(color: Colors.white30),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                // color: Colors.blueGrey,
                                margin: const EdgeInsets.only(left: 7, top: 5),
                                padding: const EdgeInsets.only(
                                  left: 5,
                                  right: 5,
                                ),
                                child: Text(
                                  snapshot.data!.networks[index].name
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              );
                            },
                            itemCount: snapshot.data!.networks.length,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              margin: const EdgeInsets.only(left: 10),
                              child: const Text(
                                'TV show Info',
                                style: TextStyle(
                                    fontSize: 19,
                                    color: Color.fromARGB(255, 219, 106, 106)),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 1.5,
                              width: _width * 0.6,
                              color: Colors.white38,
                              margin:
                                  const EdgeInsets.only(left: 2.0, right: 2.0),
                            ),
                          ],
                        ),
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
                          margin: const EdgeInsets.only(
                              top: 13, left: 30, right: 10),
                          child: Text(
                            snapshot.data!.overview.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        info('Original Name',
                            snapshot.data!.originalName.toString(), _width),
                        info('Original Language',
                            snapshot.data!.originalLanguage.toString(), _width),
                        // info(
                        //     'Release Date',
                        //     aaa(snapshot.data!.firstAirDate.toString()),
                        //     _width),
                        // info(
                        //     'RunTime',
                        //     durationToString(snapshot.data!.runtime as int),
                        //     _width),
                        info(
                            'Status', snapshot.data!.status.toString(), _width),
                        info(
                            'Total Episodes',
                            snapshot.data!.numberOfEpisodes.toString(),
                            //  getAmounts(snapshot.data!.revenue!.toDouble()),
                            _width),
                        info('Seasons',
                            snapshot.data!.numberOfSeasons.toString(), _width),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
// ***************************************  Cast *********************************
                          //  color: Colors.amberAccent,
                          //  width: _width * 0.35,
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(
                              top: 10, left: 18, bottom: 5),
                          child: const Text(
                            'Cast',
                            style: TextStyle(
                                color: Color.fromARGB(255, 131, 175, 195),
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        Container(
                          height: _height * 0.30,
                          alignment: Alignment.center,
                          child: FutureBuilder(
                            future: castD,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return ListView.builder(
                                    itemCount: 5,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        // height: _height * 0.25,
                                        width: _width * 0.33, // 0.30
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        //color: Colors.grey,
                                        decoration: BoxDecoration(
                                            color: Colors.black12,
                                            border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 27, 225, 225)),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 65, 65, 65),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  topRight: Radius.circular(12),
                                                ),
                                              ),
                                              width: _width * 0.33,
                                              height: _height * 0.18,
                                            ),
                                            Container(
                                              color: const Color.fromARGB(
                                                  255, 65, 65, 65),
                                              alignment: Alignment.center,
                                              margin: const EdgeInsets.only(
                                                  top: 10, left: 5, right: 5),
                                            ),
                                            Container(
                                              color: const Color.fromARGB(
                                                  255, 65, 65, 65),
                                              margin: const EdgeInsets.only(
                                                top: 10,
                                                left: 5,
                                                right: 5,
                                                // bottom: 5
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              }
                              return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      //   height: _height * 0.33,
                                      width: _width * 0.33,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      // color: Colors.grey,
                                      decoration: BoxDecoration(
                                          color: Colors.black12,
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 27, 225, 225)),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return PersonDetail(
                                              id: snapshot.data![index]['id']
                                                  as int,
                                              name: snapshot.data![index]
                                                  ['name'] as String,
                                            );
                                          }));
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              //  color: Colors.amberAccent,
                                              // width: _width * 0.35,
                                              // height: _height * 0.20,
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  topRight: Radius.circular(12),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      'https://image.tmdb.org/t/p/w200' +
                                                          snapshot.data![index][
                                                                  'profile_path']
                                                              .toString(),
                                                  placeholder: (context, url) {
                                                    return Center(
                                                        child: Container(
                                                      width: _width * 0.33,
                                                      height: _height * 0.18,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 65, 65, 65),
                                                    ));
                                                  },
                                                  errorWidget:
                                                      (context, url, error) {
                                                    return const Icon(
                                                      Icons.person,
                                                      color: Colors.cyan,
                                                      size: 50,
                                                    );
                                                  },
                                                  width: _width * 0.33,
                                                  height: _height * 0.18,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              margin: const EdgeInsets.only(
                                                  top: 10, left: 5, right: 5),
                                              child: Text(
                                                snapshot.data![index]['name']
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                top: 10,
                                                left: 5,
                                                right: 5,
                                                // bottom: 5
                                              ),
                                              child: Text(
                                                snapshot.data![index]
                                                        ['character']
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white60,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }

  Row info(String title, String value, double _width) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          //  color: Colors.amberAccent,
          width: _width * 0.35,
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(top: 20, left: 18),
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
          margin: const EdgeInsets.only(top: 20, left: 18),
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
