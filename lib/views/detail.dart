import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movica/cubit/castState.dart';
import 'package:movica/cubit/detailCubit.dart';
import 'package:movica/cubit/getImageCubit.dart';
import 'package:movica/cubit/getVideoCubit.dart';
import 'package:movica/models/movieModel.dart';
import 'package:movica/models/screenModel.dart';
import 'package:movica/views/videoWidget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubit/castCubit.dart';
import '../cubit/detailState.dart';
import '../cubit/getImageState.dart';
import '../cubit/getVideoState.dart';
import '../models/castMode.dart';
import '../models/detailModel.dart';
import '../models/genreModel.dart';
import '../models/personModel.dart';
import '../text.dart';

class MovieDetailScreen extends StatefulWidget {
  MovieModel movie;
  MovieDetailScreen({required this.movie});
  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool loading1 = true;
  bool loading2 = true;
  bool loading3 = true;
  bool loading4 = true;
  DetailModel detail = DetailModel.fromJson({});
  ScreenModel image = ScreenModel.fromJson({});
  List<CastModel> cast = [];
  List<GenreModel> genre = [];
  String video = '';
  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<detailCubit>(context).getList(widget.movie.id!.toInt());
    BlocProvider.of<getImageCubit>(context).getList(widget.movie.id!.toInt());
    BlocProvider.of<castCubit>(context).getList(widget.movie.id!.toInt());
    BlocProvider.of<getVideoCubit>(context).getList(widget.movie.id!.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<detailCubit, detailState>(
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
                  detail = state.detail!;
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
          BlocListener<getImageCubit, getImageState>(
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
                  image = state.image!;
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
          BlocListener<castCubit, castState>(
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
                  cast = state.cast;
                  loading3 = false;
                });
              } else {
                setState(() {
                  loading3 = false;
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
          BlocListener<getVideoCubit, getVideoState>(
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
                  video = state.key;
                  loading4 = false;
                });
              } else {
                setState(() {
                  loading4 = false;
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
        child: Stack(
          children: [
            VideoWidget(),
            SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  ClipPath(
                    child: ClipRRect(
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/original/${detail.backdropPath}',
                        height: MediaQuery.of(context).size.height / 2,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(
                          color: Colors.deepPurpleAccent,
                        ),
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/img_not_found.jpg'),
                            ),
                          ),
                        ),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 120),
                        child: GestureDetector(
                          onTap: () async {
                            final youtubeUrl = Uri.parse(
                                'https://www.youtube.com/embed/${video}');
                            if (!await launchUrl(youtubeUrl))
                              throw 'Could not launch $youtubeUrl';
                          },
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.play_circle_outline,
                                  color: Colors.yellow,
                                  size: 65,
                                ),
                                Text(
                                  widget.movie.originalTitle!.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'muli',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 130,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Overview'.toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: Text(
                                        detail.overview.toString(),
                                        maxLines: 8,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontFamily: 'muli'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),

                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'GENRES'.toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                      overflow: TextOverflow.ellipsis,
                                    ),
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
                                          return Column(
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black45,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(25),
                                                  ),
                                                  color:
                                                      Colors.deepPurpleAccent,
                                                ),
                                                child: Text(
                                                  genre[index]
                                                      .name!
                                                      .toUpperCase(),
                                                  style: GoogleFonts
                                                      .robotoCondensed(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
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
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Release date'.toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'muli',
                                                  fontSize: 15),
                                        ),
                                        Text(
                                          (detail.releaseDate.toString()),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                                color: Colors.yellow[800],
                                                fontSize: 12,
                                                fontFamily: 'muli',
                                              ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'run time'.toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'muli',
                                                  fontSize: 15),
                                        ),
                                        Text(
                                          detail.runtime.toString() + ' min',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                                color: Colors.yellow[800],
                                                fontSize: 12,
                                                fontFamily: 'muli',
                                              ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'budget'.toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'muli',
                                                  fontSize: 15),
                                        ),
                                        Text(
                                          detail.budget.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                                color: Colors.yellow[800],
                                                fontSize: 12,
                                                fontFamily: 'muli',
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Text(
                            //   'Screenshots'.toUpperCase(),
                            //   style: Theme.of(context).textTheme.caption!.copyWith(
                            //         fontWeight: FontWeight.bold,
                            //         fontFamily: 'muli',
                            //       ),
                            // ),
                            // Container(
                            //   height: 155,
                            //   child: ListView.separated(
                            //     separatorBuilder: (context, index) => VerticalDivider(
                            //       color: Colors.transparent,
                            //       width: 5,
                            //     ),
                            //     scrollDirection: Axis.horizontal,
                            //     itemCount: image.backdrops!.length,
                            //     itemBuilder: (context, index) {
                            //       return Container(
                            //         child: Card(
                            //           elevation: 3,
                            //           borderOnForeground: true,
                            //           shape: RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.circular(12),
                            //           ),
                            //           child: ClipRRect(
                            //             borderRadius: BorderRadius.circular(8),
                            //             child: CachedNetworkImage(
                            //               placeholder: (context, url) => Center(
                            //                 child: Platform.isAndroid
                            //                     ? CircularProgressIndicator()
                            //                     : CupertinoActivityIndicator(),
                            //               ),
                            //               imageUrl:
                            //                   'https://image.tmdb.org/t/p/w500${image.backdrops![index].filePath}',
                            //               fit: BoxFit.cover,
                            //             ),
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),
                            SizedBox(height: 5),

                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Casts'.toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'muli',
                                              fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 140,
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: cast.length,
                                        separatorBuilder: (context, index) =>
                                            VerticalDivider(
                                          color: Colors.transparent,
                                          width: 5,
                                        ),
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: <Widget>[
                                              cast[index]
                                                          .profilePath
                                                          .toString() ==
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
                                                            cast[index]
                                                                .profilePath
                                                                .toString(),
                                                      ),
                                                    ),
                                              Container(
                                                child: Center(
                                                  child: modified_text(
                                                    text: cast[index]
                                                        .name
                                                        .toString(),
                                                    size: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Center(
                                                  child: modified_text(
                                                    text: cast[index]
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
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// BlocBuilder<MovieDetailBloc, MovieDetailState>(
// builder: (context, state) {
// if (state is MovieDetailLoading) {
// return Center(
// child: Platform.isAndroid
// ? CircularProgressIndicator()
//     : CupertinoActivityIndicator(),
// );
// } else if (state is MovieDetailLoaded) {
// MovieDetail movieDetail = state.detail;
// return Stack(
// children: <Widget>[
// ClipPath(
// child: ClipRRect(
// child: CachedNetworkImage(
// imageUrl:
// 'https://image.tmdb.org/t/p/original/${movieDetail.backdropPath}',
// height: MediaQuery.of(context).size.height / 2,
// width: double.infinity,
// fit: BoxFit.cover,
// placeholder: (context, url) => Platform.isAndroid
// ? CircularProgressIndicator()
//     : CupertinoActivityIndicator(),
// errorWidget: (context, url, error) => Container(
// decoration: BoxDecoration(
// image: DecorationImage(
// image: AssetImage('assets/images/img_not_found.jpg'),
// ),
// ),
// ),
// ),
// borderRadius: BorderRadius.only(
// bottomLeft: Radius.circular(30),
// bottomRight: Radius.circular(30),
// ),
// ),
// ),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// AppBar(
// backgroundColor: Colors.transparent,
// elevation: 0,
// ),
// Container(
// padding: EdgeInsets.only(top: 120),
// child: GestureDetector(
// onTap: () async {
// final youtubeUrl =
// 'https://www.youtube.com/embed/${movieDetail.trailerId}';
// if (await canLaunch(youtubeUrl)) {
// await launch(youtubeUrl);
// }
// },
// child: Center(
// child: Column(
// children: <Widget>[
// Icon(
// Icons.play_circle_outline,
// color: Colors.yellow,
// size: 65,
// ),
// Text(
// movieDetail.title.toUpperCase(),
// style: TextStyle(
// color: Colors.white,
// fontFamily: 'muli',
// fontSize: 18,
// fontWeight: FontWeight.bold,
// ),
// overflow: TextOverflow.ellipsis,
// ),
// ],
// ),
// ),
// ),
// ),
// SizedBox(
// height: 160,
// ),
// Padding(
// padding: EdgeInsets.symmetric(horizontal: 12),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// Container(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// Text(
// 'Overview'.toUpperCase(),
// style: Theme.of(context)
//     .textTheme
//     .caption
//     .copyWith(
// fontWeight: FontWeight.bold,
// ),
// overflow: TextOverflow.ellipsis,
// ),
// ],
// ),
// ),
// SizedBox(
// height: 5,
// ),
// Container(
// height: 35,
// child: Text(
// movieDetail.overview,
// maxLines: 2,
// overflow: TextOverflow.ellipsis,
// style: TextStyle(fontFamily: 'muli'),
// ),
// ),
// SizedBox(
// height: 10,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: <Widget>[
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// Text(
// 'Release date'.toUpperCase(),
// style: Theme.of(context)
//     .textTheme
//     .caption
//     .copyWith(
// fontWeight: FontWeight.bold,
// fontFamily: 'muli',
// ),
// ),
// Text(
// movieDetail.releaseDate,
// style: Theme.of(context)
//     .textTheme
//     .subtitle2
//     .copyWith(
// color: Colors.yellow[800],
// fontSize: 12,
// fontFamily: 'muli',
// ),
// ),
// ],
// ),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// Text(
// 'run time'.toUpperCase(),
// style: Theme.of(context)
//     .textTheme
//     .caption
//     .copyWith(
// fontWeight: FontWeight.bold,
// fontFamily: 'muli',
// ),
// ),
// Text(
// movieDetail.runtime,
// style: Theme.of(context)
//     .textTheme
//     .subtitle2
//     .copyWith(
// color: Colors.yellow[800],
// fontSize: 12,
// fontFamily: 'muli',
// ),
// ),
// ],
// ),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// Text(
// 'budget'.toUpperCase(),
// style: Theme.of(context)
//     .textTheme
//     .caption
//     .copyWith(
// fontWeight: FontWeight.bold,
// fontFamily: 'muli',
// ),
// ),
// Text(
// movieDetail.budget,
// style: Theme.of(context)
//     .textTheme
//     .subtitle2
//     .copyWith(
// color: Colors.yellow[800],
// fontSize: 12,
// fontFamily: 'muli',
// ),
// ),
// ],
// ),
// ],
// ),
// SizedBox(
// height: 10,
// ),
// Text(
// 'Screenshots'.toUpperCase(),
// style: Theme.of(context).textTheme.caption.copyWith(
// fontWeight: FontWeight.bold,
// fontFamily: 'muli',
// ),
// ),
// Container(
// height: 155,
// child: ListView.separated(
// separatorBuilder: (context, index) =>
// VerticalDivider(
// color: Colors.transparent,
// width: 5,
// ),
// scrollDirection: Axis.horizontal,
// itemCount: movieDetail.movieImage.backdrops.length,
// itemBuilder: (context, index) {
// Screenshot image =
// movieDetail.movieImage.backdrops[index];
// return Container(
// child: Card(
// elevation: 3,
// borderOnForeground: true,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(12),
// ),
// child: ClipRRect(
// borderRadius: BorderRadius.circular(8),
// child: CachedNetworkImage(
// placeholder: (context, url) => Center(
// child: Platform.isAndroid
// ? CircularProgressIndicator()
//     : CupertinoActivityIndicator(),
// ),
// imageUrl:
// 'https://image.tmdb.org/t/p/w500${image.imagePath}',
// fit: BoxFit.cover,
// ),
// ),
// ),
// );
// },
// ),
// ),
// SizedBox(height: 10),
// Text(
// 'Casts'.toUpperCase(),
// style: Theme.of(context).textTheme.caption.copyWith(
// fontWeight: FontWeight.bold,
// fontFamily: 'muli',
// ),
// ),
// Container(
// height: 110,
// child: ListView.separated(
// scrollDirection: Axis.horizontal,
// separatorBuilder: (context, index) =>
// VerticalDivider(
// color: Colors.transparent,
// width: 5,
// ),
// itemCount: movieDetail.castList.length,
// itemBuilder: (context, index) {
// Cast cast = movieDetail.castList[index];
// return Container(
// child: Column(
// children: <Widget>[
// Card(
// shape: RoundedRectangleBorder(
// borderRadius:
// BorderRadius.circular(100),
// ),
// elevation: 3,
// child: ClipRRect(
// child: CachedNetworkImage(
// imageUrl:
// 'https://image.tmdb.org/t/p/w200${cast.profilePath}',
// imageBuilder:
// (context, imageBuilder) {
// return Container(
// width: 80,
// height: 80,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.all(
// Radius.circular(100)),
// image: DecorationImage(
// image: imageBuilder,
// fit: BoxFit.cover,
// ),
// ),
// );
// },
// placeholder: (context, url) =>
// Container(
// width: 80,
// height: 80,
// child: Center(
// child: Platform.isAndroid
// ? CircularProgressIndicator()
//     : CupertinoActivityIndicator(),
// ),
// ),
// errorWidget: (context, url, error) =>
// Container(
// width: 80,
// height: 80,
// decoration: BoxDecoration(
// image: DecorationImage(
// image: AssetImage(
// 'assets/images/img_not_found.jpg'),
// ),
// ),
// ),
// ),
// ),
// ),
// Container(
// child: Center(
// child: Text(
// cast.name.toUpperCase(),
// style: TextStyle(
// color: Colors.black54,
// fontSize: 8,
// fontFamily: 'muli',
// ),
// ),
// ),
// ),
// Container(
// child: Center(
// child: Text(
// cast.character.toUpperCase(),
// style: TextStyle(
// color: Colors.black54,
// fontSize: 8,
// fontFamily: 'muli',
// ),
// ),
// ),
// ),
// ],
// ),
// );
// },
// ),
// ),
// ],
// ),
// ),
// ],
// ),
// ],
// );
// } else {
// return Container();
// }
// },
// );
