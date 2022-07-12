import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movica/cubit/castCubit.dart';
import 'package:movica/cubit/genreCubit.dart';
import 'package:movica/cubit/getVideoCubit.dart';
import 'package:movica/cubit/movieByGenreCubit.dart';
import 'package:movica/cubit/nowPlayingMovieCubit.dart';
import 'package:movica/cubit/trendingMoviesCubit.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/detailCubit.dart';
import 'cubit/getImageCubit.dart';
import 'cubit/personCubit.dart';
import 'views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<trendingMovieCubit>(create: (_) => trendingMovieCubit()),
        BlocProvider<nowPlayingMovieCubit>(
            create: (_) => nowPlayingMovieCubit()),
        BlocProvider<genreCubit>(create: (_) => genreCubit()),
        BlocProvider<movieByGenreCubit>(create: (_) => movieByGenreCubit()),
        BlocProvider<personCubit>(create: (_) => personCubit()),
        BlocProvider<detailCubit>(create: (_) => detailCubit()),
        BlocProvider<getVideoCubit>(create: (_) => getVideoCubit()),
        BlocProvider<castCubit>(create: (_) => castCubit()),
        BlocProvider<getImageCubit>(create: (_) => getImageCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<trendingMovieCubit>(context).getList();
    BlocProvider.of<nowPlayingMovieCubit>(context).getList();
    BlocProvider.of<personCubit>(context).getList();
    _controller = VideoPlayerController.asset('assets/logovedio.mp4');

    _controller.initialize().then((_) => setState(() {}));
    _controller.setVolume(0.0);
    _controller.setPlaybackSpeed(0.5);
    _playVideo();
  }

  void _playVideo() async {
    _controller.play();
    await Future.delayed(const Duration(seconds: 4));
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const home()),
        (route) => false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: Lottie.asset(
                    'assets/loadingani.json',
                    width: 60,
                    height: 60,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
