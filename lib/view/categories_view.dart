import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_app_flutter/controller/fetch_photo_api.dart';
import 'package:wallpaper_app_flutter/model/categore_model.dart';
import 'package:wallpaper_app_flutter/model/data.dart';
import 'package:wallpaper_app_flutter/model/photo_model.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;
  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  TextEditingController searchController = new TextEditingController();
  final FetchPhotoApi _fetchPhotoApi = FetchPhotoApi();
  List<CategorieModel> category = [];
  List<CategorieModel> colors = [];
  bool moreCategory = false;

  Photos photos = Photos();
  Future<List<Photos>> _future;
  List<Photos> photoList = [];
  int page = 1;
  int _index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    category = getCategories();
    colors = getColorWorld();

    resultData(page);
  }

  Future<void> resultData(page) async {
    _future = _fetchPhotoApi.getBestOfTheMonth(page);
    // _future = _fetchPhotoApi.getSearchPhoto(searchController.text, page);
    photoList = _fetchPhotoApi.photoList;
    return photoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // backgroundColor: Color(0xffDDE7EF),
      body: SafeArea(
        child: CustomScrollView(
          controller: widget.scrollController,
          physics: ClampingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(0xffEEF3F5),
                      borderRadius: BorderRadius.circular(15),
                      // border: Border.all(color: Colors.grey[500], width: 0.5),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            cursorHeight: 20,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.search,
                            onSubmitted: (value) {
                              print(searchController.text);

                              resultData(page);
                              setState(() {});
                            },
                            cursorColor: Colors.black,
                            controller: searchController,
                            decoration: InputDecoration(
                                hintText: "search wallpapers ...",
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              print(searchController.text);

                              resultData(page);
                              setState(() {});
                              // getSearchWallpaper(searchController.text);
                            },
                            child: Container(child: Icon(Icons.search)))
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Best of the month',
                  style: TextStyle(
                      fontSize: 25,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child:

                  /// Popular Collections
                  Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: SizedBox(
                    height: 250,
                    // width: 400,
                    child: FutureBuilder(
                      future: _future,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return PageView.builder(
                            itemCount: photoList.length,
                            controller: PageController(viewportFraction: 0.7),
                            onPageChanged: (int index) =>
                                setState(() => _index = index),
                            itemBuilder: (context, index) {
                              return Transform.scale(
                                scale: index == _index ? 1 : 0.85,
                                transformHitTests: true,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    imageUrl: photoList[index].src.landscape,
                                    fit: BoxFit.cover,
                                    // height: 300,
                                    width: 200,
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(child: Text('Loading..'));
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Color World',
                  style: TextStyle(
                      fontSize: 25,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 120,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl: colors[index].imgUrl,
                              // height: 100,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 8),
                          child: Container(
                            // height: 100,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                colors[index].categorieName,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: colors.length,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categorise',
                      style: TextStyle(
                          fontSize: 25,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            moreCategory = true;
                          });
                        },
                        child: Text(
                          'More...',
                          style:
                              TextStyle(color: Color(0xff3F64F5), fontSize: 17),
                        ))
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              sliver: SliverStaggeredGrid.countBuilder(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: category[index].imgUrl,
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.5,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              category[index].categorieName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                itemCount: moreCategory ? category.length : 6,
              ),
            ),
          ],
        ),

        ///
        // SingleChildScrollView(
        //   child: Column(
        //     children: [
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           SizedBox(height: 30),
        //           Container(
        //             height: 60,
        //             decoration: BoxDecoration(
        //               color: Color(0xffEEF3F5),
        //               borderRadius: BorderRadius.circular(15),
        //               // border: Border.all(color: Colors.grey[500], width: 0.5),
        //             ),
        //             margin: EdgeInsets.symmetric(horizontal: 24),
        //             padding: EdgeInsets.symmetric(horizontal: 24),
        //             child: Row(
        //               children: [
        //                 Expanded(
        //                   child: TextField(
        //                     cursorHeight: 20,
        //                     keyboardType: TextInputType.text,
        //                     textInputAction: TextInputAction.search,
        //                     onSubmitted: (value) {
        //                       print(searchController.text);
        //
        //                       resultData(page);
        //                       setState(() {});
        //                     },
        //                     cursorColor: Colors.black,
        //                     controller: searchController,
        //                     decoration: InputDecoration(
        //                         hintText: "search wallpapers ...",
        //                         hintStyle: TextStyle(
        //                           fontSize: 18,
        //                         ),
        //                         border: InputBorder.none),
        //                   ),
        //                 ),
        //                 InkWell(
        //                     onTap: () {
        //                       print(searchController.text);
        //
        //                       resultData(page);
        //                       setState(() {});
        //                       // getSearchWallpaper(searchController.text);
        //                     },
        //                     child: Container(child: Icon(Icons.search)))
        //               ],
        //             ),
        //           ),
        //           SizedBox(height: 10),
        //           // searchController.text != ''
        //           //     ? Row(
        //           //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           //         children: [
        //           //           Container(
        //           //             height: 50,
        //           //             decoration: BoxDecoration(
        //           //               color: Colors.black12.withOpacity(0.05),
        //           //               borderRadius: BorderRadius.circular(25),
        //           //             ),
        //           //             child: Padding(
        //           //               padding:
        //           //                   const EdgeInsets.symmetric(horizontal: 15),
        //           //               child: Row(
        //           //                 mainAxisAlignment:
        //           //                     MainAxisAlignment.spaceEvenly,
        //           //                 children: [
        //           //                   Text(
        //           //                     'Orientation',
        //           //                     style: TextStyle(
        //           //                         fontSize: 17, color: Colors.black),
        //           //                   ),
        //           //                   SizedBox(width: 10),
        //           //                   Image.asset(
        //           //                     'images/screenRotation.png',
        //           //                     height: 25,
        //           //                   ),
        //           //                 ],
        //           //               ),
        //           //             ),
        //           //           ),
        //           //           InkWell(
        //           //             onTap: () {},
        //           //             child: Container(
        //           //               height: 50,
        //           //               // width: 150,
        //           //               decoration: BoxDecoration(
        //           //                 color: Colors.black12.withOpacity(0.05),
        //           //                 borderRadius: BorderRadius.circular(25),
        //           //               ),
        //           //               child: Padding(
        //           //                 padding: const EdgeInsets.symmetric(
        //           //                     horizontal: 15),
        //           //                 child: Row(
        //           //                   mainAxisAlignment:
        //           //                       MainAxisAlignment.spaceEvenly,
        //           //                   children: [
        //           //                     Text(
        //           //                       'Color',
        //           //                       style: TextStyle(
        //           //                           fontSize: 17, color: Colors.black),
        //           //                     ),
        //           //                     SizedBox(width: 10),
        //           //                     Icon(Icons.colorize),
        //           //                   ],
        //           //                 ),
        //           //               ),
        //           //             ),
        //           //           ),
        //           //         ],
        //           //       )
        //           //     : SizedBox(),
        //         ],
        //       ),
        //       // SizedBox(height: 5),
        //       // Divider(
        //       //   height: 5,
        //       //   color: Colors.black,
        //       // ),
        //       SizedBox(height: 15),
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Padding(
        //             padding: const EdgeInsets.all(15.0),
        //             child: Text(
        //               'Best of the month',
        //               style: TextStyle(
        //                   fontSize: 25,
        //                   letterSpacing: 0.8,
        //                   fontWeight: FontWeight.bold),
        //             ),
        //           ),
        //
        /// Popular Collections
        //           Padding(
        //             padding: const EdgeInsets.symmetric(vertical: 15),
        //             child: Center(
        //               child: SizedBox(
        //                   height: 250,
        //                   // width: 400,
        //                   child: FutureBuilder(
        //                     future: _future,
        //                     builder: (context, snapshot) {
        //                       if (snapshot.hasData) {
        //                         return PageView.builder(
        //                           itemCount: photoList.length,
        //                           controller:
        //                               PageController(viewportFraction: 0.7),
        //                           onPageChanged: (int index) =>
        //                               setState(() => _index = index),
        //                           itemBuilder: (context, index) {
        //                             return Transform.scale(
        //                               scale: index == _index ? 1 : 0.85,
        //                               transformHitTests: true,
        //                               child: ClipRRect(
        //                                 borderRadius: BorderRadius.circular(20),
        //                                 child: CachedNetworkImage(
        //                                   imageUrl:
        //                                       photoList[index].src.landscape,
        //                                   fit: BoxFit.cover,
        //                                   // height: 300,
        //                                   width: 200,
        //                                 ),
        //                               ),
        //                             );
        //                           },
        //                         );
        //                       } else {
        //                         return Center(child: Text('Loading..'));
        //                       }
        //                     },
        //                   )
        //
        ///
        //                   ///""""""""""""""""""""""""""""""""
        //                   // ListView.builder(
        //                   //     scrollDirection: Axis.horizontal,
        //                   //     shrinkWrap: true,
        //                   //     itemCount: 20,
        //                   //     itemBuilder: (context, index) {
        //                   //       return Stack(
        //                   //         children: [
        //                   //           Padding(
        //                   //             padding: const EdgeInsets.all(8.0),
        //                   //             child: Container(
        //                   //                 height: 100,
        //                   //                 width: 100,
        //                   //                 child: Image(
        //                   //                   image:
        //                   //                       AssetImage('images/pexelsPhoto.jpeg'),
        //                   //                   fit: BoxFit.cover,
        //                   //                 )),
        //                   //           ),
        //                   //           Padding(
        //                   //             padding: const EdgeInsets.all(8.0),
        //                   //             child: Container(
        //                   //               height: 100,
        //                   //               width: 100,
        //                   //               color: Colors.black12,
        //                   //               child: Center(
        //                   //                   child: Text(
        //                   //                 'Dark',
        //                   //                 style: TextStyle(
        //                   //                     fontSize: 20, color: Colors.white),
        //                   //               )),
        //                   //             ),
        //                   //           ),
        //                   //         ],
        //                   //       );
        //                   //     }),
        //
        ///
        ///====================
        //                   // FutureBuilder(
        //                   //   future: _future,
        //                   //   builder: (context, snapshot) {
        //                   //     if (snapshot.hasData) {
        //                   //       return
        //                   //
        //                   //       ///+++++++++++++++++++++++
        //                   //       //   ListView.builder(
        //                   //       //   itemCount: 20,
        //                   //       //   itemBuilder: (context, index) {
        //                   //       //     return Text(index.toString());
        //                   //       //   },
        //                   //       // );
        //                   //       ///++++++++++++++++++++
        //                   //       //     CustomScrollView(
        //                   //       //   // physics: ClampingScrollPhysics(),
        //                   //       //   slivers: <Widget>[
        //                   //       //     SliverGrid(
        //                   //       //       gridDelegate:
        //                   //       //           SliverGridDelegateWithFixedCrossAxisCount(
        //                   //       //         crossAxisCount: 2,
        //                   //       //         mainAxisExtent: 400,
        //                   //       //         mainAxisSpacing: 5,
        //                   //       //         crossAxisSpacing: 5,
        //                   //       //       ),
        //                   //       //       delegate: SliverChildBuilderDelegate(
        //                   //       //         ((context, index) {
        //                   //       //           return Stack(
        //                   //       //             children: [
        //                   //       //               GestureDetector(
        //                   //       //                 onTap: () {
        //                   //       //                   Navigator.pushNamed(
        //                   //       //                       context, FullScreenImage.id,
        //                   //       //                       arguments:
        //                   //       //                           photoList[index]);
        //                   //       //                 },
        //                   //       //                 child: ClipRRect(
        //                   //       //                   borderRadius:
        //                   //       //                       BorderRadius.circular(10),
        //                   //       //                   child: CachedNetworkImage(
        //                   //       //                     imageUrl: photoList[index]
        //                   //       //                         .src
        //                   //       //                         .portrait,
        //                   //       //                     fit: BoxFit.cover,
        //                   //       //                     height: 400,
        //                   //       //                     placeholder: (context, url) =>
        //                   //       //                         Center(
        //                   //       //                             child:
        //                   //       //                                 CircularProgressIndicator()),
        //                   //       //                     errorWidget:
        //                   //       //                         (context, url, error) =>
        //                   //       //                             Icon(Icons.error),
        //                   //       //                   ),
        //                   //       //                 ),
        //                   //       //               ),
        //                   //       //               // index == photoList.length - 1
        //                   //       //               //     ? Positioned(
        //                   //       //               //         bottom: 0,
        //                   //       //               //         child: ClipRRect(
        //                   //       //               //           borderRadius: BorderRadius.circular(20),
        //                   //       //               //           child: FlatButton(
        //                   //       //               //             onPressed: () {
        //                   //       //               //               setState(() {
        //                   //       //               //                 page++;
        //                   //       //               //                 resultData(page);
        //                   //       //               //               });
        //                   //       //               //               print(page);
        //                   //       //               //             },
        //                   //       //               //             child: Text(
        //                   //       //               //               'More...',
        //                   //       //               //               style: TextStyle(fontSize: 20),
        //                   //       //               //             ),
        //                   //       //               //             color: Colors.grey.withOpacity(0.7),
        //                   //       //               //           ),
        //                   //       //               //         ),
        //                   //       //               //       )
        //                   //       //               //     : Divider(height: 0),
        //                   //       //
        //                   //       //               // index == photoList.length - 1
        //                   //       //               //     ? Padding(
        //                   //       //               //         padding: const EdgeInsets.all(8.0),
        //                   //       //               //         child: GestureDetector(
        //                   //       //               //           onTap: () {
        //                   //       //               //             setState(() {
        //                   //       //               //               page++;
        //                   //       //               //               resultData(page);
        //                   //       //               //             });
        //                   //       //               //           },
        //                   //       //               //           child: Container(
        //                   //       //               //             child: Center(child: Text('More...')),
        //                   //       //               //             color: Colors.cyan,
        //                   //       //               //             width: 100,
        //                   //       //               //             height: 30,
        //                   //       //               //           ),
        //                   //       //               //         ),
        //                   //       //               //       )
        //                   //       //               //     : Divider(height: 0),
        //                   //       //             ],
        //                   //       //           );
        //                   //       //         }),
        //                   //       //         childCount: photoList.length,
        //                   //       //       ),
        //                   //       //     ),
        //                   //       //     SliverList(
        //                   //       //       delegate: SliverChildBuilderDelegate(
        //                   //       //         (context, index) {
        //                   //       //           return Padding(
        //                   //       //             padding: const EdgeInsets.all(10.0),
        //                   //       //             child: Center(
        //                   //       //                 child: TextButton(
        //                   //       //               onPressed: () async {
        //                   //       //                 page++;
        //                   //       //                 await resultData(page);
        //                   //       //                 setState(() {});
        //                   //       //               },
        //                   //       //               child: Row(
        //                   //       //                 mainAxisAlignment:
        //                   //       //                     MainAxisAlignment.center,
        //                   //       //                 children: [
        //                   //       //                   Text(
        //                   //       //                     'More Data ...',
        //                   //       //                     style:
        //                   //       //                         TextStyle(fontSize: 25),
        //                   //       //                   ),
        //                   //       //                   // CircularProgressIndicator(),
        //                   //       //                 ],
        //                   //       //               ),
        //                   //       //             )),
        //                   //       //           );
        //                   //       //         },
        //                   //       //         childCount: 1,
        //                   //       //       ),
        //                   //       //     ),
        //                   //       //   ],
        //                   //       //   // StaggeredGridView.countBuilder(
        //                   //       //   //   crossAxisCount: 2,
        //                   //       //   //   itemCount: photoList.length + 1,
        //                   //       //   //   physics: ClampingScrollPhysics(),
        //                   //       //   //   controller: widget.scrollController,
        //                   //       //   //   itemBuilder: (context, index) {
        //                   //       //   //     // print(photoList[index].src.portrait);
        //                   //       //   //     // height = double.parse(photos.height.toString());
        //                   //       //   //
        //                   //       //   //     if (index == photoList.length) {
        //                   //       //   //       //show loading indicator at last index
        //                   //       //   //       return FlatButton(
        //                   //       //   //         onPressed: () {
        //                   //       //   //           setState(() {
        //                   //       //   //             page++;
        //                   //       //   //             resultData(page);
        //                   //       //   //           });
        //                   //       //   //           print(page);
        //                   //       //   //         },
        //                   //       //   //         child: Text(
        //                   //       //   //           'More...',
        //                   //       //   //           style: TextStyle(fontSize: 20),
        //                   //       //   //         ),
        //                   //       //   //         color: Colors.grey.withOpacity(0.7),
        //                   //       //   //       );
        //                   //       //   //     }
        //                   //       //   //
        //                   //       //   //     return Stack(
        //                   //       //   //       children: [
        //                   //       //   //         GestureDetector(
        //                   //       //   //           onTap: () {
        //                   //       //   //             Navigator.pushNamed(context, FullScreenImage.id,
        //                   //       //   //                 arguments: photoList[index]);
        //                   //       //   //           },
        //                   //       //   //           child: ClipRRect(
        //                   //       //   //             borderRadius: BorderRadius.circular(10),
        //                   //       //   //             child: CachedNetworkImage(
        //                   //       //   //               imageUrl: photoList[index].src.portrait,
        //                   //       //   //               fit: BoxFit.cover,
        //                   //       //   //               height: 400,
        //                   //       //   //               // color: Colors.black54,
        //                   //       //   //               // height: index == photoList.length - 1 ? 400 : 400,
        //                   //       //   //               //     double.parse(photoList[index].height.toString()) / 50,
        //                   //       //   //               // width:
        //                   //       //   //               //     double.parse(photoList[index].width.toString()) / 50,
        //                   //       //   //               placeholder: (context, url) =>
        //                   //       //   //                   Center(child: CircularProgressIndicator()),
        //                   //       //   //               errorWidget: (context, url, error) =>
        //                   //       //   //                   Icon(Icons.error),
        //                   //       //   //             ),
        //                   //       //   //           ),
        //                   //       //   //         ),
        //                   //       //   //         // index == photoList.length - 1
        //                   //       //   //         //     ? Positioned(
        //                   //       //   //         //         bottom: 0,
        //                   //       //   //         //         child: ClipRRect(
        //                   //       //   //         //           borderRadius: BorderRadius.circular(20),
        //                   //       //   //         //           child: FlatButton(
        //                   //       //   //         //             onPressed: () {
        //                   //       //   //         //               setState(() {
        //                   //       //   //         //                 page++;
        //                   //       //   //         //                 resultData(page);
        //                   //       //   //         //               });
        //                   //       //   //         //               print(page);
        //                   //       //   //         //             },
        //                   //       //   //         //             child: Text(
        //                   //       //   //         //               'More...',
        //                   //       //   //         //               style: TextStyle(fontSize: 20),
        //                   //       //   //         //             ),
        //                   //       //   //         //             color: Colors.grey.withOpacity(0.7),
        //                   //       //   //         //           ),
        //                   //       //   //         //         ),
        //                   //       //   //         //       )
        //                   //       //   //         //     : Divider(height: 0),
        //                   //       //   //
        //                   //       //   //         // index == photoList.length - 1
        //                   //       //   //         //     ? Padding(
        //                   //       //   //         //         padding: const EdgeInsets.all(8.0),
        //                   //       //   //         //         child: GestureDetector(
        //                   //       //   //         //           onTap: () {
        //                   //       //   //         //             setState(() {
        //                   //       //   //         //               page++;
        //                   //       //   //         //               resultData(page);
        //                   //       //   //         //             });
        //                   //       //   //         //           },
        //                   //       //   //         //           child: Container(
        //                   //       //   //         //             child: Center(child: Text('More...')),
        //                   //       //   //         //             color: Colors.cyan,
        //                   //       //   //         //             width: 100,
        //                   //       //   //         //             height: 30,
        //                   //       //   //         //           ),
        //                   //       //   //         //         ),
        //                   //       //   //         //       )
        //                   //       //   //         //     : Divider(height: 0),
        //                   //       //   //       ],
        //                   //       //   //     );
        //                   //       //   //   },
        //                   //       //   //   staggeredTileBuilder: (index) => StaggeredTile.extent(1, 400),
        //                   //       //   //   mainAxisSpacing: 8,
        //                   //       //   //   crossAxisSpacing: 8,
        //                   //       //   //   padding: EdgeInsets.all(8),
        //                   //       //   // ),
        //                   //       // );
        //                   //       ///++++++++++++++++++++++++++++++++++
        //                   //     } else if (snapshot.hasError) {
        //                   //       return Center(child: Text(snapshot.error));
        //                   //     } else {
        //                   //       return Center(child: CircularProgressIndicator());
        //                   //     }
        //                   //   },
        //                   // ),
        ///====================
        //                   ),
        //             ),
        //           ),
        //
        //           ///
        //           Padding(
        //             padding: const EdgeInsets.all(15.0),
        //             child: Text(
        //               'Categorise',
        //               style: TextStyle(
        //                   fontSize: 25,
        //                   letterSpacing: 0.8,
        //                   fontWeight: FontWeight.bold),
        //             ),
        //           ),
        //           Container(
        //             height: MediaQuery.of(context).size.height * 0.5,
        //             // color: Colors.deepOrangeAccent,
        //             child: ListView.builder(
        //               shrinkWrap: true,
        //               itemCount: category.length,
        //               itemBuilder: (context, index) {
        //                 print(category.length);
        //                 return Stack(
        //                   children: [
        //                     Padding(
        //                       padding: const EdgeInsets.all(15),
        //                       child: ClipRRect(
        //                         borderRadius: BorderRadius.circular(15),
        //                         child: CachedNetworkImage(
        //                           imageUrl: category[index].imgUrl,
        //                           height: 70,
        //                           width: MediaQuery.of(context).size.width,
        //                           fit: BoxFit.cover,
        //                         ),
        //                       ),
        //                     ),
        //                     Padding(
        //                       padding: const EdgeInsets.all(15.0),
        //                       child: Container(
        //                         height: 70,
        //                         width: MediaQuery.of(context).size.width,
        //                         decoration: BoxDecoration(
        //                           color: Colors.black26,
        //                           borderRadius: BorderRadius.circular(15),
        //                         ),
        //                         child: Center(
        //                           child: Text(
        //                             category[index].categorieName,
        //                             style: TextStyle(
        //                                 color: Colors.white, fontSize: 30),
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                   ],
        //                 );
        //               },
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
        ///
      ),
    );
  }
}
