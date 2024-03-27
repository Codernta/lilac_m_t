import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lilac_mt/controller/home/home_provider.dart';
import 'package:lilac_mt/controller/profile/profile_provider.dart';
import 'package:lilac_mt/repository/app_constants.dart';
import 'package:lilac_mt/utilities/extensions.dart';
import 'package:lilac_mt/utilities/text_styles.dart';
import 'package:lilac_mt/view/profile/profile_page.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeProvider>(context, listen: false)
          .initialiseVideoData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 80,
        leading: Builder(builder: (scaffoldContext) {
          return GestureDetector(
            onTap: () => Scaffold.of(scaffoldContext).openDrawer(),
            child: const Padding(
              padding:  EdgeInsets.all(13.0),
              child: Icon(Icons.menu,color: Colors.grey,size: 40,),
            ),
          );
        }),
        actions: [
          IconButton(
            onPressed: () => Get.to(()=> const ProfilePage()),
            icon: Image.asset('assets/images/profile_image.jpg'),
          )
        ],
      ),
      drawer: Consumer(
        builder: (context, ProfileProvider profileProvider, child) {
          return Drawer(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () => Get.to(()=> const ProfilePage()),
                        child: DrawerHeader(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      profileProvider.name.isEmpty
                                          ? 'Name'
                                          : profileProvider.name,
                                      style: primaryStyle,
                                    ),
                                  ),
                                  Text(
                                    profileProvider.dob.isEmpty
                                        ? 'DOB'
                                        : profileProvider.dob,
                                    style: primaryStyle,
                                  ),
                                  SizedBox(
                                    width: 175,
                                    child: Text(
                                      profileProvider.email.isEmpty
                                          ? 'Email'
                                          : profileProvider.email,
                                      style: primaryStyle,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/profile_image.jpg',
                                      height: 70),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 8.0,
                    ),
                    child: GestureDetector(
                      onTap: () => profileProvider.logoutUser(context),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Logout',
                            style: primaryStyle,
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.power_settings_new_rounded)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      body: Consumer(
        builder: (context, HomeProvider homeProvider, child) => SafeArea(
          child: Center(
            child: Column(
              children: [
                AppConstants.availableVideos.isEmpty
                    ?  Center(child: Text("Something error occured!",style: primaryStyle,))
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                    height: 233,
                                    color: Colors.black,
                                    width: double.infinity,
                                    child: Stack(
                                      children: [
                                        AspectRatio(
                                          aspectRatio: homeProvider
                                              .videoPlayerController
                                              .value
                                              .aspectRatio,
                                          child: VideoPlayer(
                                            homeProvider.videoPlayerController,
                                            key: homeProvider.urlKey,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            height: 40,
                                            margin: const EdgeInsets.only(
                                                bottom: 16),
                                            padding: EdgeInsets.only(
                                              left: homeProvider
                                                      .videoPlayerController
                                                      .value
                                                      .isPlaying
                                                  ? 24
                                                  : 32,
                                              right: 16,
                                            ),
                                            alignment: Alignment.bottomCenter,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      homeProvider
                                                              .videoPlayerController
                                                              .value
                                                              .isPlaying
                                                          ? homeProvider
                                                              .videoPlayerController
                                                              .pause()
                                                          : homeProvider
                                                              .videoPlayerController
                                                              .play();
                                                    });
                                                  },
                                                  child: homeProvider
                                                          .videoPlayerController
                                                          .value
                                                          .isPlaying
                                                      ? const Icon(
                                                          Icons.pause,
                                                          color: Colors.white,
                                                        )
                                                      : Image.asset(
                                                          'assets/icons/ic_play.png'),
                                                ),
                                                const SizedBox(
                                                  width: 17.5,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  VideoProgressIndicator(
                                                                homeProvider
                                                                    .videoPlayerController,
                                                                allowScrubbing:
                                                                    true,
                                                                colors:
                                                                    const VideoProgressColors(
                                                                  playedColor:
                                                                      Color(
                                                                          0xff57EE9D),
                                                                  backgroundColor:
                                                                      Color(
                                                                          0xff525252),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 13.5,
                                                            ),
                                                            TweenAnimationBuilder<
                                                                Duration>(
                                                              tween: Tween(
                                                                  begin: homeProvider
                                                                      .videoPlayerController
                                                                      .value
                                                                      .duration,
                                                                  end: Duration
                                                                      .zero),
                                                              duration: homeProvider
                                                                  .videoPlayerController
                                                                  .value
                                                                  .duration,
                                                              builder: (context,
                                                                  value,
                                                                  child) {
                                                                return Text(
                                                                  '${homeProvider.videoPlayerController.value.position.toMinutesSeconds()} /${homeProvider.videoPlayerController.value.duration.toMinutesSeconds()}',
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 11.2,
                                                      ),
                                                      Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              homeProvider
                                                                  .videoPlayerController
                                                                  .seekTo(Duration(
                                                                      seconds: homeProvider
                                                                              .videoPlayerController
                                                                              .value
                                                                              .position
                                                                              .inSeconds -
                                                                          4));
                                                            },
                                                            child: Image.asset(
                                                                'assets/icons/ic_prev.png'),
                                                          ),
                                                          const SizedBox(
                                                            width: 19.78,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              homeProvider
                                                                  .videoPlayerController
                                                                  .seekTo(Duration(
                                                                      seconds: homeProvider
                                                                              .videoPlayerController
                                                                              .value
                                                                              .position
                                                                              .inSeconds +
                                                                          4));
                                                            },
                                                            child: Image.asset(
                                                                'assets/icons/ic_next.png'),
                                                          ),
                                                          const SizedBox(
                                                            width: 19.68,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                homeProvider
                                                                    .videoPlayerController
                                                                    .setVolume(
                                                                        homeProvider.videoPlayerController.value.volume ==
                                                                                1.0
                                                                            ? 0
                                                                            : 1.0);
                                                              });
                                                            },
                                                            child: homeProvider
                                                                        .videoPlayerController
                                                                        .value
                                                                        .volume ==
                                                                    1.0
                                                                ? Image.asset(
                                                                    'assets/icons/ic_sound.png')
                                                                : const Icon(
                                                                    Icons
                                                                        .music_off,
                                                                    color: Colors
                                                                        .red,
                                                                    size: 12,
                                                                  ),
                                                          ),
                                                          const Spacer(),
                                                          Image.asset(
                                                              'assets/icons/ic_settings.png'),
                                                          const SizedBox(
                                                            width: 15.24,
                                                          ),
                                                          Image.asset(
                                                              'assets/icons/ic_fullscreen.png'),
                                                          const SizedBox(
                                                            width: 1,
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                    ),
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if ((homeProvider.index - 1) >= 0) {
                                        homeProvider.playPrevVideo(context);
                                      }
                                    },
                                    child: Container(
                                      height: 43,
                                      width: 43,
                                      decoration: BoxDecoration(
                                        color: (homeProvider.index) == 0
                                            ? Colors.grey
                                            : AppConstants.isDarkMode
                                                ? Colors.black
                                                : Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const Icon(
                                          Icons.arrow_back_ios_new,
                                          size: 16),
                                    ),
                                  ),
                                  if (AppConstants
                                      .availableVideos[homeProvider.index]
                                      .isDownloaded)
                                    GestureDetector(
                                      onTap: () {
                                        //to do
                                        homeProvider.delete(context);
                                        // _delete();
                                      },
                                      child: Container(
                                        height: 43,
                                        width: 140,
                                        decoration: BoxDecoration(
                                          color: AppConstants.isDarkMode
                                              ? Colors.black
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child:  Row(
                                          // ignore: prefer_const_literals_to_create_immutables
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children:  [
                                            const Icon(Icons.remove_circle),
                                            const SizedBox(width: 5),
                                            Text(
                                              "Remove",
                                              style:primaryStyle,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  else
                                    homeProvider.downloadLoader
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              //to do
                                              homeProvider.download(context);
                                              // _download();
                                            },
                                            child: Container(
                                              height: 43,
                                              width: 140,
                                              decoration: BoxDecoration(
                                                color: AppConstants.isDarkMode
                                                    ? Colors.black
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Row(
                                                // ignore: prefer_const_literals_to_create_immutables
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                      'assets/icons/ic_down.png'),
                                                  const SizedBox(width: 12),
                                                  Text(
                                                    "Download",
                                                    style: TextStyle(
                                                      fontFamily: 'Comfortaa',
                                                        color: AppConstants
                                                                .isDarkMode
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontSize: 16),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                  GestureDetector(
                                    onTap: () {
                                      //to do
                                      if ((homeProvider.index) <
                                          (AppConstants.availableVideos.length -
                                              1)) {
                                        homeProvider.playNextVideo(context);
                                      }
                                    },
                                    child: Container(
                                      height: 43,
                                      width: 43,
                                      decoration: BoxDecoration(
                                        color: homeProvider.index >=
                                                (AppConstants.availableVideos
                                                        .length -
                                                    1)
                                            ? Colors.grey
                                            : AppConstants.isDarkMode
                                                ? Colors.black
                                                : Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const Icon(Icons.arrow_forward_ios,
                                          size: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (AppConstants.availableVideos[homeProvider.index]
                                    .isDownloaded ==
                                false)
                              Container(
                                padding: const EdgeInsets.only(top: 50),
                                child: StreamBuilder(
                                    stream: homeProvider.downloadStatus,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(
                                              snapshot.error.toString(),
                                              textAlign: TextAlign.center,
                                              style: primaryStyle,
                                            ),
                                          ),
                                        );
                                      }
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.active:
                                          return Center(
                                            child: Text(
                                              "Downloading... ${snapshot.data}",
                                              style:
                                                  primaryStyle,
                                            ),
                                          );
                                          break;
                                        default:
                                          return Container();
                                      }
                                    }),
                              ),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
