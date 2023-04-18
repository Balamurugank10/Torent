import 'package:flutter/material.dart';

class O extends StatefulWidget {
  const O({super.key});

  @override
  State<O> createState() => _OState();
}

class _OState extends State<O> with SingleTickerProviderStateMixin {
  late TabController _controller;
  List<String> multipleImages = [];
  @override
  void initState() {
    _controller = TabController(vsync: this, length: 2);

    _controller.addListener(() {
      if (_controller.index == 1) {
        setState(() {
          _controller.index = 0;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: TabBar(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              indicatorColor: Colors.white,
              indicatorWeight: 5,
              tabs: [Tab(text: '1'), Tab(text: '2')],
            ),
          ),
          body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _controller,
              children: [
                Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Text('dnd'),
                      ElevatedButton(
                          onPressed: () {
                            _controller.index = 1;
                          },
                          child: Text('Upload images')),
                      ElevatedButton(
                          onPressed: () {
                            _controller.index = 1;
                          },
                          child: Text('Upload images'))
                    ])),
                Center(child: Text('dk'))
              ]),
        ));
  }
}

// DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text("ToRent"),
//             centerTitle: true,
//             actions: [
//               IconButton(
//                   onPressed: () {},
//                   icon: Icon(
//                     Icons.notifications_none,
//                   )),
//             ],
// bottom:
//     TabBar(indicatorColor: Colors.white, indicatorWeight: 5, tabs: [
//   Tab(text: 'Buyer'),
//   Tab(text: 'Owner'),
// ]),
//leading: Icon(Icons.abc_outlined),
//toolbarHeight: 78,
//leading: ,
