import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'view/home_view.dart';

class NavBarView extends StatefulWidget {
  static String id = 'HomeView';

  @override
  _NavBarViewState createState() => _NavBarViewState();
}

class _NavBarViewState extends State<NavBarView> {
  ScrollController _scrollController;
  bool _isVisible;
  double _containerMaxHeight = 56,
      _offset,
      _delta = 0,
      _oldOffset = 0,
      padding = 15;

  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollNavBar();
  }

  void scrollNavBar() {
    _isVisible = true;
    _offset = 0;
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          double offset = _scrollController.offset;
          _delta += (offset - _oldOffset);
          if (_delta > _containerMaxHeight + padding) {
            _delta = _containerMaxHeight + padding;
          } else if (_delta < 0) {
            _delta = 0;
          }
          if (_scrollController.position.userScrollDirection ==
              ScrollDirection.reverse) {
            if (_isVisible)
              setState(() {
                _isVisible = false;
              });
          }
          if (_scrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
            if (!_isVisible)
              setState(() {
                _isVisible = true;
              });
          }
          _oldOffset = offset;

          _offset = -_delta;
        });
      });
  }

  final tabs = [
    // Text(
    //   'Home View',
    //   style: TextStyle(fontSize: 50),
    // ),
    HomeView(),
    Text(
      'Video View',
      style: TextStyle(fontSize: 50),
    ),
    Text(
      'Sreash View',
      style: TextStyle(fontSize: 50),
    ),
    Text(
      'Favorite View',
      style: TextStyle(fontSize: 50),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amber,
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: Center(child: tabs[index]),
            ),

            // ListView.builder(
            //   controller: _scrollController,
            //   physics: ClampingScrollPhysics(),
            //   itemCount: 10,
            //   itemBuilder: (context, index) {
            //     return Image(
            //       image: NetworkImage(
            //           'https://images.pexels.com/photos/220118/pexels-photo-220118.jpeg'),
            //     );
            //   },
            // ),
            Positioned(
              bottom: _offset,
              width: constraints.maxWidth,
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      // color: Colors.white,
                      color: _isVisible ? Colors.white : Colors.white38,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset: Offset(
                              2.0, 2.0), // shadow direction: bottom right
                        )
                      ]),
                  width: double.infinity,
                  height: _containerMaxHeight,
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.home_rounded,
                        ),
                        iconSize: index == 0 ? 40 : 35,
                        color: index == 0 ? Colors.black : Colors.grey[600],
                        onPressed: () {
                          setState(() {
                            index = 0;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.video_collection),
                        onPressed: () {
                          setState(() {
                            index = 1;
                          });
                        },
                        iconSize: index == 1 ? 40 : 35,
                        color: index == 1 ? Colors.black : Colors.grey[600],
                      ),
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          setState(() {
                            index = 2;
                          });
                        },
                        iconSize: index == 2 ? 40 : 35,
                        color: index == 2 ? Colors.black : Colors.grey[600],
                      ),
                      IconButton(
                        icon: Icon(Icons.favorite),
                        onPressed: () {
                          setState(() {
                            index = 3;
                          });
                        },
                        iconSize: index == 3 ? 40 : 35,
                        color: index == 3 ? Colors.black : Colors.grey[600],
                      ),

                      // _buildItem(Icons.video_collection_outlined),
                      // _buildItem(Icons.search),
                      // _buildItem(Icons.favorite),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
//   Widget _buildItem(IconData icon) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         IconButton(icon, size: 35),
//       ],
//     );
//   }
// }
