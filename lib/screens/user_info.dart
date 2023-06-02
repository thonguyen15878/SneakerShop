import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneakerstore/consts/colors.dart';

import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:sneakerstore/providers/dark_theme_provider.dart';
import 'package:sneakerstore/screens/wishlist.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {

  late ScrollController _scrollController;
  var top = 0.0;
  @override
void initState(){
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {setState(() {
      });
        });
  }
  @override
  Widget build (BuildContext context){
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 4,
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    top = constraints.biggest.height;
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ColorsConsts.starterColor,
                            ColorsConsts.endColor,
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end:  const FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp
                        ),
                      ),
                      child: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        centerTitle: true,
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AnimatedOpacity(
                              duration: Duration(milliseconds: 300),
                              opacity: top <= 110.0 ? 1.0 : 0,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Container(
                                   height: kToolbarHeight / 1.8,
                                    width: kToolbarHeight / 1.8,
                                    decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 1.0,
                                        ),
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            'assets/profile.png'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  const Text(
                                    // 'top.toString()',
                                    'Guest',
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        background: const Image(
                          image: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRz86LYlrR9TkR_BTQeKrEX5tUG5rSICCaR4g&usqp=CAU'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  }
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: userTitle('User Bag')),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Theme.of(context).splashColor,
            child: ListTile(
              onTap: () => Navigator.of(context)
                  .pushNamed(WishlistScreen.routeName),
              title: Text('Wishlist'),
              trailing: Icon(Icons.chevron_right_rounded),

              leading: Icon(Icons.favorite,
              color: Colors.red,),
            ),
          ),
        ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () {},
                          title: Text('Cart'),
                          trailing: Icon(Icons.chevron_right_rounded),

                          leading: Icon(Icons.shopping_cart,
                            color: Colors.lightBlue,),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: userTitle('User Information')),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    userListTile('Full name', 'Anhhh Duyyy' , 0, context),
                    userListTile('Address', 'somewhere on earth' , 0, context),
                    userListTile('Date of birth', '9/9/2999' , 0, context),
                    userListTile('Email', 'daylaAnhDuy@gmail.com' , 0, context),
                    userListTile('Instagram', 'daylaemDuy' , 0, context),
                    userListTile('Phone Number', '9999' , 0, context),
                    userListTile('Shipping address', '' , 0, context),
                    userListTile('joined date', 'date' , 0, context),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: userTitle('user settings'),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    ListTileSwitch(
                      value: themeChange.darkTheme,
                      leading: Icon(Icons.home),
                      onChanged: (value) {
                        setState(() {
                          themeChange.darkTheme = value;
                        });
                      },
                      visualDensity: VisualDensity.comfortable,
                      switchType: SwitchType.cupertino,
                      switchActiveColor: Colors.indigo,
                      title: Text('Dark theme'),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Theme.of(context).splashColor,
                        child: ListTile(
                          onTap: () async {
                            showDialog(context: context, builder: (BuildContext ctx) {
                              return AlertDialog(
                                title: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 6.0),
                                      child: Image.network('https://unsplash.com/photos/G9i_plbfDgk',
                                      height: 20,
                                      width: 20,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Sign out'),
                                    ),
                                  ],
                                ),
                                content: Text('Do you wanna sign out?'),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel')),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'OK',
                                      style: TextStyle(color: Colors.red),
                                    )
                                  )
                                ],
                              );
                            });
                          },
                          title: Text('Log out'),
                          leading: Icon(Icons.exit_to_app_rounded),
                        ),
                      ),
                    )




        ],
                ),
              )
            ],
          ),
          _buildFab(),
        ],
      ),
    );
  }

  Widget _buildFab() {
    final double defaultTopMargin = 200.0 - 4.0;

    final double scaleStart = 160.0;

    final double scaleEnd = scaleStart / 2 ;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down

        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down

        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }

    return Positioned(
      top: top,
      right: 16.0,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          backgroundColor: Colors.purple,
          heroTag: "btn1",
          onPressed: () {},
          child: Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }

List<IconData> _userTileIcons = [
  Icons.face,
  Icons.phone,
  Icons.local_shipping,
  Icons.watch_later,
  Icons.exit_to_app_rounded
];

  Widget userListTile(
String title, String subTitle, int index, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
onTap: () {},
          title: Text(title),
          subtitle: Text(subTitle),
          leading: Icon(_userTileIcons[index]),
        ),
      ),
    );
}
Widget userTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold , fontSize: 23),
    );
}
}