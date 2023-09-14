import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_info/api_service.dart';
import 'package:movie_info/model/movie.dart';
import 'package:movie_info/provider/fake.dart';
import 'package:movie_info/screens/movie_page.dart';
import 'package:movie_info/screens/search_page.dart';
import 'package:movie_info/screens/tv_paage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var trending;
  var nowPlaying;
  var upComing;
  var popular;
  var topRated;
  var trendingTV;
  var netflix;
  var disney;
  var amazon;
  var todayTV;
  var onTV;
  var popularTV;
  var ratedTV;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setState(() {
    trending = APIService().getTrendingMovie();
    nowPlaying = APIService().getNowPlayingMovie();
    upComing = APIService().getUpcomingMovie();
    popular = APIService().getPopularMovie();
    topRated = APIService().getTopRatedMovies();
    trendingTV = APIService().getTrendingTV();
    netflix = APIService().getNetflixTV();
    disney = APIService().getDisneyTV();
    amazon = APIService().getAmazonTV();
    todayTV = APIService().getTodayTV();
    onTV = APIService().getOnTV();
    popularTV = APIService().getPopularTV();
    ratedTV = APIService().getTopRatedTV();

    //  });
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height - kToolbarHeight;
    final _width = MediaQuery.of(context).size.width;
    //  final wwww = fake().moviess;
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 27, 35, 39), //(255, 36, 47, 53)
      appBar: AppBar(
        title: const Text('Just Movie'),
        backgroundColor: Colors.black26,
        centerTitle: true,
        elevation: 3,
        actions: [
          IconButton(
              onPressed: (() {
                Navigator.push(context, MaterialPageRoute(builder: (contex) {
                  return const SearchScreen();
                }));
              }),
              icon: const Icon(Icons.search)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'UpComming',
            //   style: TextStyle(
            //       fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            FutureBuilder(
              future: trending,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: Container(
                    alignment: Alignment.center,
                    // padding: const EdgeInsets.only(top: 15, bottom: 15),
                    // foregroundDecoration: const BoxDecoration(
                    //   borderRadius: BorderRadius.all(
                    //     Radius.circular(10),
                    //   ),
                    // color: Colors.amberAccent,
                    // ),
                    //  width: _width * 0.9,
                    height: _height * 0.35,
                    child: Container(
                      alignment: Alignment.center,
                      // margin: const EdgeInsets.only(top: 5, bottom: 5),
                      foregroundDecoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Color.fromARGB(255, 65, 65, 65),
                      ),
                      width: _width * 0.8,
                      height: _height * 0.28,
                    ),
                  ));
                }
                List aaa = snapshot.data as List;
                // print(aaa);

                // print(snapshot.data.toString());
                return Container(
                  //  color: Colors.blueAccent,
                  //  margin: EdgeInsets.symmetric(horizontal: 50),
                  alignment: Alignment.center,
                  //  width: _width,
                  height: _height * 0.35,
                  child: CarouselSlider.builder(
                    //  disableGesture: true,
                    itemCount: aaa.length,
                    itemBuilder: ((context, index, realIndex) {
                      // print(
                      //   aaa[index]['backdrop_path'].toString(),
                      // );
                      //  print(aaa[index]['original_title']);
                      return InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: ((context) {
                            return MoviePage(id: aaa[index]['id']);
                          })));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: <Widget>[
                              ClipRRect(
                                clipBehavior: Clip.hardEdge,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: 'https://image.tmdb.org/t/p/w500/' +
                                      aaa[index]['backdrop_path'].toString(),
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) {
                                    return Center(
                                        child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        color: Color.fromARGB(255, 65, 65, 65),
                                      ),
                                      width: _width * 0.8,
                                      height: _height * 0.25,
                                      // color:
                                      //     const Color.fromARGB(255, 65, 65, 65),
                                    ));
                                  },
                                  // fadeInDuration: Duration(milliseconds: 2000),
                                  errorWidget: (context, url, error) {
                                    return const Icon(Icons.error);
                                  },
                                ),
                                // child: Image.network(
                                //   snapshot.data['results'][1]['backdrop_path']
                                //       .toString(),
                                // ),
                              ),
                              Container(
                                // decoration: BoxDecoration(
                                //     color: Colors.black.withOpacity(0.7),
                                //     boxShadow: const [
                                //       BoxShadow(
                                //           blurRadius: 2,
                                //           spreadRadius: 0.7,
                                //           color:
                                //               Color.fromARGB(255, 63, 64, 65))
                                //     ],
                                //     borderRadius: BorderRadius.circular(6)),
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                // color: Colors.black.withOpacity(0.7),
                                margin: const EdgeInsets.only(
                                  bottom: 15,
                                  left: 14,
                                ),
                                child: Text(
                                  aaa[index]['title'].toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: 'muli',
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    options: CarouselOptions(
                        autoPlayInterval: const Duration(seconds: 5),
                        // clipBehavior: Clip.antiAlias,
                        // reverse: true,
                        autoPlay: true,
                        enableInfiniteScroll: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.9),
                  ),
                );
              },
            ),
            // const SizedBox(
            //   height: 15,
            // ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Text(
                'Now Playing',
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            movieList(_height, nowPlaying, _width),
            const SizedBox(
              height: 10,
            ),
            // const SizedBox(
            //   height: 12,
            // ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Text(
                'Upcoming',
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            movieList(_height, upComing, _width),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Text(
                'Popular',
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            movieList(_height, popular, _width),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Text(
                'Top Rated',
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            movieList(_height, topRated, _width),
            const SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    'Trending',
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    'TV Show',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TvList(_height, trendingTV, _width),
            const SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    'Netflix',
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    'TV Show',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TvList(_height, netflix, _width),
            const SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    'Disney+',
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    'TV Show',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TvList(_height, disney, _width),
            const SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    'Amazon',
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    'TV Show',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TvList(_height, amazon, _width),
            const SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    'Airing Today',
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    'TV Show',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TvList(_height, todayTV, _width),
            const SizedBox(
              height: 10,
            ),

            // Row(
            //   children: [
            //     Container(
            //       margin: const EdgeInsets.only(left: 10),
            //       child: const Text(
            //         'On TV',
            //         style: TextStyle(
            //             fontSize: 21,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.white),
            //       ),
            //     ),
            //     Container(
            //       margin: const EdgeInsets.only(left: 10),
            //       child: const Text(
            //         'TV Show',
            //         style: TextStyle(
            //             fontSize: 14,
            //             fontWeight: FontWeight.w400,
            //             color: Colors.white),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // TvList(_height, onTV, _width),
            // // const SizedBox(
            // //   height: 10,
            // // ),

            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    'Popular',
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    'TV Show',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TvList(_height, popularTV, _width),
            const SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    'Top Rated',
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Text(
                    'TV Show',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TvList(_height, ratedTV, _width),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

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
                  // alignment: Alignment.center,
                  // // foregroundDecoration: const BoxDecoration(
                  // //   borderRadius:
                  // //       BorderRadiusDirectional.all(Radius.circular(15)),
                  // // ),
                  // width: _width * 0.31,
                  // height: _height * 0.23,
                  // //  height: _height * 0.30,
                  // margin: const EdgeInsets.symmetric(horizontal: 5),
                  // //  color: const Color.fromARGB(255, 65, 65, 65),
                  // decoration: const BoxDecoration(
                  //   // border: Border.all(color: Colors.amberAccent),
                  //   borderRadius:
                  //       BorderRadiusDirectional.all(Radius.circular(12)),
                  //   color: Color.fromARGB(255, 233, 34, 34),
                  // ),
                  child: Column(
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(top: 5, left: 7, right: 7),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 65, 65, 65),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                        ),
                        // color: Colors.amberAccent,

                        // padding: EdgeInsets.symmetric(horizontal: 5),
                        // margin: EdgeInsets.symmetric(horizontal: 5),
                        width: _width * 0.31,
                        height: _height * 0.23,
                      ),
                      //  Spacer(flex: 6),
                      Container(
                        margin: const EdgeInsets.only(left: 7, right: 7),
                        width: _width * 0.31,
                        height: _height * 0.02,
                        //    color: Colors.black38,
                        decoration: const BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12))),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                );
              }));
        }
        List wwww = snapshot.data;
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: wwww.length,
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return MoviePage(id: wwww[index]['id']);
                  })));
                },
                child: Container(
                  // foregroundDecoration: const BoxDecoration(
                  //   borderRadius:
                  //       BorderRadiusDirectional.all(Radius.circular(15)),
                  // ),
                  //  width: _width * 0.31,
                  //  height: _height * 0.30,
                  //  margin: const EdgeInsets.symmetric(horizontal: 5),
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
                          imageUrl: 'https://image.tmdb.org/t/p/w200' +
                              wwww[index]['poster_path'].toString(),
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
                          wwww[index]['title'].toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
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

//  ****************************** TV SHOW  **********************************************8

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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: ((context, index) {
                return Container(
                  // alignment: Alignment.center,
                  // foregroundDecoration: const BoxDecoration(
                  //   borderRadius:
                  //       BorderRadiusDirectional.all(Radius.circular(15)),
                  // ),
                  // width: _width * 0.31,
                  // //  height: _height * 0.30,
                  // margin: const EdgeInsets.symmetric(horizontal: 5),
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.amberAccent),
                  //   borderRadius:
                  //       BorderRadiusDirectional.all(Radius.circular(20)),
                  //   // color: Colors.black45,
                  // ),
                  child: Column(
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(top: 5, left: 7, right: 7),
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
                        height: _height * 0.23,
                      ),
                      //  Spacer(flex: 6),
                      Container(
                        margin: const EdgeInsets.only(left: 7, right: 7),
                        width: _width * 0.31,
                        height: _height * 0.02,
                        //    color: Colors.black38,
                        decoration: const BoxDecoration(
                            color: Colors.black54,
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

        List wwww = snapshot.data;
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return TVpage(id: wwww[index]['id']);
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

                          imageUrl: 'https://image.tmdb.org/t/p/w200' +
                              wwww[index]['poster_path'].toString(),
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
                          wwww[index]['name'].toString(),
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
