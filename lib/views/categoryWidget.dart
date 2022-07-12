import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movica/cubit/genreCubit.dart';
import 'package:movica/cubit/genreState.dart';
import 'package:movica/cubit/movieByGenreCubit.dart';
import 'package:movica/cubit/movieByGenreState.dart';
import 'package:movica/models/genreModel.dart';

import '../models/movieModel.dart';
import '../text.dart';
import 'detail.dart';

class BuildWidgetCategory extends StatefulWidget {
  final int selectedGenre;

  BuildWidgetCategory({this.selectedGenre = 28});
  @override
  BuildWidgetCategoryState createState() => BuildWidgetCategoryState();
}

class BuildWidgetCategoryState extends State<BuildWidgetCategory> {
  int selectedGenre = 28;
  bool loading1 = true, loading2 = true;
  List<GenreModel> genre = [];
  List<MovieModel> catMovie = [];
  @override
  void initState() {
    super.initState();
    selectedGenre = widget.selectedGenre;
    BlocProvider.of<genreCubit>(context).getList();
    BlocProvider.of<movieByGenreCubit>(context).getList(28);
  }

  @override
  Widget build(BuildContext conte) {
    return _buildGenre(context);
  }

  Widget _buildGenre(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<genreCubit, genreState>(
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
                        style:
                            TextStyle(color: Color(0xfffec260), fontSize: 18),
                      ),
                    ],
                  ),
                  duration: Duration(milliseconds: 1000),
                ),
              );
              setState(() {
                genre = state.genre;
                loading1 = false;
              });
            } else {
              setState(() {
                loading1 = false;
              });
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.black,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.message,
                        style:
                            TextStyle(color: Color(0xfffec260), fontSize: 18),
                      ),
                    ],
                  ),
                  duration: Duration(milliseconds: 1000),
                ),
              );
            }
          },
        ),
        BlocListener<movieByGenreCubit, movieByGenreState>(
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
                        style:
                            TextStyle(color: Color(0xfffec260), fontSize: 18),
                      ),
                    ],
                  ),
                  duration: Duration(milliseconds: 1000),
                ),
              );
              setState(() {
                catMovie = state.movieByGenre;
                loading2 = false;
              });
            } else {
              setState(() {
                loading2 = false;
              });
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.black,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.message,
                        style:
                            TextStyle(color: Color(0xfffec260), fontSize: 18),
                      ),
                    ],
                  ),
                  duration: Duration(milliseconds: 1000),
                ),
              );
            }
          },
        ),
      ],
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              loading1
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 45,
                          child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    VerticalDivider(
                              color: Colors.transparent,
                              width: 5,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemCount: genre.length,
                            itemBuilder: (context, index) {
                              GenreModel gen = genre[index];
                              return Column(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        GenreModel gen = genre[index];
                                        selectedGenre = gen.id!;
                                        loading2 = false;
                                        BlocProvider.of<movieByGenreCubit>(
                                                context)
                                            .getList(selectedGenre);
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black45,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(25),
                                        ),
                                        color: (gen.id == selectedGenre)
                                            ? Colors.deepPurpleAccent
                                            : Colors.black45,
                                      ),
                                      child: Text(
                                        gen.name!.toUpperCase(),
                                        style: GoogleFonts.robotoCondensed(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),

                        //
                      ],
                    ),
              loading2
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        height: 280,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withOpacity(0.6),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: CircularProgressIndicator(
                                color: Colors.deepPurpleAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 280,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: catMovie.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDetailScreen(
                                              movie: catMovie[index],
                                            ),
                                          ),
                                        );
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
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Container(
                                          width: 140,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          'https://image.tmdb.org/t/p/w500' +
                                                              catMovie[index]
                                                                  .posterPath
                                                                  .toString()),
                                                      fit: BoxFit.cover),
                                                ),
                                                height: 200,
                                              ),
                                              SizedBox(height: 5),
                                              Container(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: modified_text(
                                                    size: 13,
                                                    text: catMovie[index]
                                                                .title
                                                                .toString()
                                                                .length >
                                                            30
                                                        ? '${catMovie[index].title.toString().substring(0, 30)}..'
                                                        : catMovie[index]
                                                            .title
                                                            .toString(),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      (catMovie[index]
                                                                  .voteAverage!
                                                                  .toDouble() *
                                                              0.5)
                                                          .toStringAsFixed(1),
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                    RatingBar.builder(
                                                      itemSize: 15.0,
                                                      initialRating:
                                                          catMovie[index]
                                                                  .voteAverage!
                                                                  .toDouble() *
                                                              0.5,
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 2.0),
                                                      itemBuilder:
                                                          (context, _) => Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      onRatingUpdate: (rating) {
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
            ],
          ),
        ),
      ),
    );
  }
}

//Container(
//   child: Text(
//     'new playing'.toUpperCase(),
//     style: TextStyle(
//       fontSize: 12,
//       fontWeight: FontWeight.bold,
//       color: Colors.black45,
//       fontFamily: 'muli',
//     ),
//   ),
// ),
// SizedBox(
//   height: 10,
// ),
// BlocBuilder<MovieBloc, MovieState>(
//   builder: (context, state) {
//     if (state is MovieLoading) {
//       return Center();
//     } else if (state is MovieLoaded) {
//       List<Movie> movieList = state.movieList;
//
//       return Container(
//         height: 300,
//         child: ListView.separated(
//           separatorBuilder: (context, index) => VerticalDivider(
//             color: Colors.transparent,
//             width: 15,
//           ),
//           scrollDirection: Axis.horizontal,
//           itemCount: movieList.length,
//           itemBuilder: (context, index) {
//             Movie movie = movieList[index];
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             MovieDetailScreen(movie: movie),
//                       ),
//                     );
//                   },
//                   child: ClipRRect(
//                     child: CachedNetworkImage(
//                       imageUrl:
//                       'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
//                       imageBuilder: (context, imageProvider) {
//                         return Container(
//                           width: 180,
//                           height: 250,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(12),
//                             ),
//                             image: DecorationImage(
//                               image: imageProvider,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         );
//                       },
//                       placeholder: (context, url) => Container(
//                         width: 180,
//                         height: 250,
//                         child: Center(
//                           child: Platform.isAndroid
//                               ? CircularProgressIndicator()
//                               : CupertinoActivityIndicator(),
//                         ),
//                       ),
//                       errorWidget: (context, url, error) => Container(
//                         width: 180,
//                         height: 250,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage(
//                                 'assets/images/img_not_found.jpg'),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   width: 180,
//                   child: Text(
//                     movie.title.toUpperCase(),
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.black45,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'muli',
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 Container(
//                   child: Row(
//                     children: <Widget>[
//                       Icon(
//                         Icons.star,
//                         color: Colors.yellow,
//                         size: 14,
//                       ),
//                       Icon(
//                         Icons.star,
//                         color: Colors.yellow,
//                         size: 14,
//                       ),
//                       Icon(
//                         Icons.star,
//                         color: Colors.yellow,
//                         size: 14,
//                       ),
//                       Icon(
//                         Icons.star,
//                         color: Colors.yellow,
//                         size: 14,
//                       ),
//                       Icon(
//                         Icons.star,
//                         color: Colors.yellow,
//                         size: 14,
//                       ),
//                       Text(
//                         movie.voteAverage,
//                         style: TextStyle(
//                           color: Colors.black45,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       );
//     } else {
//       return Container();
//     }
//   },
// ),
