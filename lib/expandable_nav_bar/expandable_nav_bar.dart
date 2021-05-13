import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animation/expandable_nav_bar/music.dart';

const _cardColor = Color(0xFF5F40FB);
const _maxHeight = 350.0;
const _minHeight = 70.0;

class ExpandableNavBar extends StatefulWidget {
  @override
  _ExpandableNavBarState createState() => _ExpandableNavBarState();
}

class _ExpandableNavBarState extends State<ExpandableNavBar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool _expanded = false;
  double _currentHeight = _minHeight;
  Music _currentMusic;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final menuWidth = size.width * 0.5;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(
                bottom: _minHeight + 20, left: 20, right: 20),
            itemCount: musics.length,
            itemBuilder: (context, index) {
              final music = musics[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentMusic = music;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        child: Image.network(
                          music.backgroundImage,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(music.singerImage),
                                maxRadius: 30.0,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(music.singer),
                              Text(
                                music.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          GestureDetector(
            onVerticalDragUpdate:  (details) {
                    setState(() {
                      final newHeight = _currentHeight - details.delta.dy;
                      _controller.value = _currentHeight / _maxHeight;
                      _currentHeight = newHeight.clamp(_minHeight, _maxHeight);
                    });
                  },
            onVerticalDragEnd:  (details) {
                    if (_currentHeight < _maxHeight / 1.5) {
                      _controller.reverse();
                      _expanded = false;
                    } else {
                      _expanded = true;
                      _controller.forward(from: _currentHeight / _maxHeight);
                      _currentHeight = _maxHeight;
                    }
                  },
            child: AnimatedBuilder(
                animation: _controller,
                builder: (context, snapshot) {
                  final value =
                      const ElasticInOutCurve(0.7).transform(_controller.value);
                  return Stack(
                    children: [
                      Positioned(
                        height: lerpDouble(_minHeight, _currentHeight, value),
                        left: lerpDouble(
                            size.width / 2 - menuWidth / 2, 0, value),
                        width: lerpDouble(menuWidth, size.width, value),
                        bottom: lerpDouble(40.0, 0.0, value),
                        child: Container(
                            decoration: BoxDecoration(
                                color: _cardColor,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                  bottom: Radius.circular(
                                      lerpDouble(20.0, 0.0, value)),
                                )),
                            child: _expanded
                                ? Opacity(
                                    opacity: _controller.value,
                                    child: _buildExpandedContent())
                                : _buildMenuContent()),
                      ),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget _buildExpandedContent() {
    return _currentMusic == null
        ? const SizedBox()
        : Container(
            color: Colors.red,
            padding: const EdgeInsets.all(20.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    Image.network(
                      _currentMusic.backgroundImage,
                      height: 120,
                      width: 120,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      _currentMusic.singer,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      _currentMusic.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.shuffle),
                        Icon(Icons.pause),
                        Icon(Icons.playlist_add),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }

  Widget _buildMenuContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.sd_card_alert_outlined),
        GestureDetector(
          onTap: () {
            setState(() {
              _expanded = true;
              _currentHeight = _maxHeight;
              _controller.forward(from: 0.0);
            });
          },
          child: CircleAvatar(
            backgroundImage: _currentMusic != null
                ? NetworkImage(_currentMusic.singerImage)
                : null,
            maxRadius: 20.0,
          ),
        ),
        CircleAvatar(
          backgroundImage: NetworkImage(
              "https://i.scdn.co/image/ab6765630000ba8a3b47b54b346c2917f3683aef"),
          radius: 15.0,
        ),
      ],
    );
  }
}
