import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movica/cubit/nowPlayingMovieCubit.dart';
import 'package:movica/cubit/nowPlayingMovieState.dart';
import 'package:movica/cubit/trendingMoviesCubit.dart';
import 'package:movica/models/trendingMoviesModel.dart';
import 'package:movica/views/categoryWidget.dart';
import 'package:movica/views/videoWidget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../cubit/detailCubit.dart';
import '../cubit/personCubit.dart';
import '../cubit/personState.dart';
import '../cubit/trendingMovieState.dart';
import '../models/movieModel.dart';
import '../models/personModel.dart';
import '../text.dart';
import 'detail.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  bool loadingList1 = true;
  bool loadingList2 = true;
  bool loadingList3 = true;
  bool loadingList4 = true;
  List<MovieModel> trendingMovies = [];
  List<MovieModel> nowPlayingMovie = [];
  List<PersonModel> persons = [];
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<trendingMovieCubit>(context).getList();
    BlocProvider.of<nowPlayingMovieCubit>(context).getList();
    BlocProvider.of<personCubit>(context).getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: Icon(
          Icons.menu,
          color: Colors.deepPurpleAccent,
        ),
        actions: [
          Icon(
            Icons.search,
            color: Colors.deepPurpleAccent,
          )
        ],
        title: Image.asset(
          'images/movica.png',
          height: 55,
        ),
      ),
      body: Stack(
        children: [
          VideoWidget(),
          SingleChildScrollView(
            child: BlocListener<nowPlayingMovieCubit, nowPlayingMovieState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state.code == "00") {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.black,
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Success",
                            style: TextStyle(
                                color: Color(0xfffec260), fontSize: 18),
                          ),
                        ],
                      ),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
                  setState(() {
                    nowPlayingMovie = state.nowPlayingMovie;
                    loadingList1 = false;
                  });
                } else {
                  setState(() {
                    loadingList1 = false;
                  });
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.black,
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.message,
                            style: TextStyle(
                                color: Color(0xfffec260), fontSize: 18),
                          ),
                        ],
                      ),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
                }
              },
              child: BlocListener<trendingMovieCubit, trendingMovieState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state.code == "00") {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.black,
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Success",
                              style: TextStyle(
                                  color: Color(0xfffec260), fontSize: 18),
                            ),
                          ],
                        ),
                        duration: Duration(milliseconds: 1000),
                      ),
                    );
                    setState(() {
                      trendingMovies = state.trendingMovie;
                      loadingList2 = false;
                    });
                  } else {
                    setState(() {
                      loadingList2 = false;
                    });
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.black,
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.message,
                              style: TextStyle(
                                  color: Color(0xfffec260), fontSize: 18),
                            ),
                          ],
                        ),
                        duration: Duration(milliseconds: 1000),
                      ),
                    );
                  }
                },
                child: BlocListener<personCubit, personState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state.code == "00") {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.black,
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Success",
                                style: TextStyle(
                                    color: Color(0xfffec260), fontSize: 18),
                              ),
                            ],
                          ),
                          duration: Duration(milliseconds: 1000),
                        ),
                      );
                      setState(() {
                        persons = state.persons;
                        loadingList3 = false;
                      });
                    } else {
                      setState(() {
                        loadingList3 = false;
                      });
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.black,
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.message,
                                style: TextStyle(
                                    color: Color(0xfffec260), fontSize: 18),
                              ),
                            ],
                          ),
                          duration: Duration(milliseconds: 1000),
                        ),
                      );
                    }
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      loadingList1
                          ? Container(
                              height: MediaQuery.of(context).size.height / 3.7,
                              width: MediaQuery.of(context).size.width * 4 / 5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black.withOpacity(0.8),
                              ),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                            )
                          : CarouselSlider.builder(
                              options: CarouselOptions(
                                enableInfiniteScroll: true,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 5),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                pauseAutoPlayOnTouch: true,
                                viewportFraction: 0.8,
                                enlargeCenterPage: true,
                              ),
                              itemCount: nowPlayingMovie.length,
                              itemBuilder: (context, index, realIndex) {
                                MovieModel movie = nowPlayingMovie[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDetailScreen(
                                                  movie: movie,
                                                )));
                                  },
                                  child: Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: <Widget>[
                                      ClipRRect(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              3,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/img_not_found.jpg'),
                                              ),
                                            ),
                                          ),
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          gradient: LinearGradient(
                                              colors: [
                                                Colors.black.withOpacity(0.0),
                                                Colors.black.withOpacity(1.0),
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                bottom: 15,
                                                left: 15,
                                              ),
                                              child: Text(
                                                movie.title!.toUpperCase(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  fontFamily: 'muli',
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      loadingList2
                          ? Container(
                              height: 330,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black.withOpacity(0.8),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: modified_text(
                                      text: 'Trending Movies',
                                      size: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.deepPurpleAccent,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  modified_text(
                                    text: 'Trending Movies',
                                    size: 17,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                      height: 280,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: trendingMovies.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) => Description(
                                                //               name: trending[index]['title'],
                                                //               bannerurl:
                                                //                   'https://image.tmdb.org/t/p/w500' +
                                                //                       trending[index]
                                                //                           ['backdrop_path'],
                                                //               posterurl:
                                                //                   'https://image.tmdb.org/t/p/w500' +
                                                //                       trending[index]
                                                //                           ['poster_path'],
                                                //               description: trending[index]
                                                //                   ['overview'],
                                                //               vote: trending[index]
                                                //                       ['vote_average']
                                                //                   .toString(),
                                                //               launch_on: trending[index]
                                                //                   ['release_date'],
                                                //             )));
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MovieDetailScreen(
                                                      movie:
                                                          trendingMovies[index],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5),
                                                child: Container(
                                                  width: 140,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          image: DecorationImage(
                                                              image: NetworkImage('https://image.tmdb.org/t/p/w500' +
                                                                  trendingMovies[
                                                                          index]
                                                                      .posterPath
                                                                      .toString()),
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                        height: 200,
                                                      ),
                                                      SizedBox(height: 5),
                                                      Container(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5),
                                                          child: modified_text(
                                                            size: 13,
                                                            text:
                                                                trendingMovies[
                                                                        index]
                                                                    .title
                                                                    .toString(),
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              (trendingMovies[index]
                                                                          .voteAverage!
                                                                          .toDouble() *
                                                                      0.5)
                                                                  .toStringAsFixed(
                                                                      1),
                                                              style: TextStyle(
                                                                  fontSize: 10),
                                                            ),
                                                            RatingBar.builder(
                                                              itemSize: 15.0,
                                                              initialRating: trendingMovies[
                                                                          index]
                                                                      .voteAverage!
                                                                      .toDouble() *
                                                                  0.5,
                                                              minRating: 1,
                                                              direction: Axis
                                                                  .horizontal,
                                                              allowHalfRating:
                                                                  true,
                                                              itemCount: 5,
                                                              itemPadding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          2.0),
                                                              itemBuilder:
                                                                  (context,
                                                                          _) =>
                                                                      Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .amber,
                                                              ),
                                                              onRatingUpdate:
                                                                  (rating) {
                                                                print(rating);
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }))
                                ],
                              ),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      BuildWidgetCategory(),
                      SizedBox(
                        height: 10,
                      ),
                      loadingList3
                          ? Container(
                              height: 180,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black.withOpacity(0.8),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: modified_text(
                                      text: 'Trending Persons On This Week',
                                      size: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.deepPurpleAccent,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    modified_text(
                                      text: 'Trending Persons On This Week',
                                      size: 17,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 140,
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: persons.length,
                                        separatorBuilder: (context, index) =>
                                            VerticalDivider(
                                          color: Colors.transparent,
                                          width: 5,
                                        ),
                                        itemBuilder: (context, index) {
                                          PersonModel person = persons[index];
                                          return Column(
                                            children: <Widget>[
                                              person.profilePath.toString() ==
                                                      'null'
                                                  ? CircleAvatar(
                                                      radius: 45,
                                                      backgroundImage:
                                                          AssetImage(
                                                        'images/img_not_found.jpg',
                                                      ),
                                                    )
                                                  : CircleAvatar(
                                                      radius: 45,
                                                      backgroundImage:
                                                          NetworkImage(
                                                        'https://image.tmdb.org/t/p/w200' +
                                                            person.profilePath
                                                                .toString(),
                                                      ),
                                                    ),
                                              Container(
                                                child: Center(
                                                  child: modified_text(
                                                    text:
                                                        person.name.toString(),
                                                    size: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Center(
                                                  child: modified_text(
                                                    text: person
                                                        .knownForDepartment
                                                        .toString(),
                                                    size: 10,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage(String image, int index, String title) => Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Image.network(
              "http://image.tmdb.org/t/p/w500${image}",
              fit: BoxFit.fill,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Text(title),
              ),
            ],
          ),
        ],
      );
}
