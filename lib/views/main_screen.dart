import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letterboxd_porto_3/controllers/main_screen_controller.dart';
import 'package:letterboxd_porto_3/dimension.dart';
import 'package:letterboxd_porto_3/style.dart';
import 'package:letterboxd_porto_3/views/home_screen.dart';
import 'package:letterboxd_porto_3/views/profile_screen.dart';
import 'package:letterboxd_porto_3/views/under_work.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_drawer_opt.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

class MainScreen extends GetView<MainScreenController> {
  const MainScreen({super.key});
  final List<Widget> screens = const [
    HomeScreen(),
    UnderWorkScreen(),
    UnderWorkScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        return Scaffold(
          drawer: drawerSection(context),
          drawerEdgeDragWidth: 20 + getWidth(context, 5),
          backgroundColor: context.colors.primaryCr,
          body: LazyLoadIndexedStack(
            index: controller.index.value,
            children: screens,
          ),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              highlightColor: Colors.transparent,
              splashColor: context.colors.secondaryCr.withOpacity(0.1),
            ),
            child: BottomNavigationBar(
              currentIndex: controller.index.value,
              onTap: (value) => controller.changeIndex(value),
              backgroundColor: context.colors.primaryCr,
              selectedIconTheme:
                  IconThemeData(color: context.colors.secondaryCr, size: 28),
              unselectedIconTheme: IconThemeData(
                  color: context.colors.whiteCr.withOpacity(0.5), size: 20),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage("assets/icons/home.png")),
                    label: ""),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage("assets/icons/search.png")),
                    label: ""),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage("assets/icons/notif.png")),
                    label: ""),
                BottomNavigationBarItem(
                    icon: ImageIcon(AssetImage("assets/icons/profile.png")),
                    label: ""),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget drawerSection(BuildContext context) {
    return Container(
      width: 160 + getWidth(context, 20),
      color: context.colors.primaryCr,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: context.colors.whiteCr,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: boldText.copyWith(
                        fontSize: 14, color: context.colors.secondaryCr),
                  ),
                  Text("email@mail.com",style: normalText.copyWith(fontSize: 12, color: Colors.grey),)
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                flex: 10,
                child: Container(
                  height: 24,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: context.colors.accentCr, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "500 Follower",
                    style: normalText.copyWith(
                        fontSize: 10, color: context.colors.whiteCr),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 10,
                child: Container(
                  height: 24,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: context.colors.accentCr, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "500 Following",
                    style: normalText.copyWith(
                        fontSize: 10, color: context.colors.whiteCr),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const CustomDrawerOption(
            isActive: true,
            icon: AssetImage(
              "assets/icons/home.png",
            ),
            text: "Home",
          ),
          const CustomDrawerOption(
            icon: AssetImage(
              "assets/icons/film.png",
            ),
            text: "Films",
          ),
          const CustomDrawerOption(
            icon: AssetImage(
              "assets/icons/diary.png",
            ),
            text: "Diary",
          ),
          const CustomDrawerOption(
            icon: AssetImage(
              "assets/icons/review.png",
            ),
            text: "Review",
          ),
          const CustomDrawerOption(
            icon: AssetImage(
              "assets/icons/watchlist.png",
            ),
            text: "Watchlist",
          ),
          const CustomDrawerOption(
            icon: AssetImage(
              "assets/icons/list.png",
            ),
            text: "list",
          ),
          const CustomDrawerOption(
            icon: AssetImage(
              "assets/icons/like.png",
            ),
            text: "Likes",
          ),
          const SizedBox(
            height: 20,
          ),
          CustomDrawerOption(
            icon: const AssetImage(
              "assets/icons/logout.png",
            ),
            text: "Logout",
            textColor: context.colors.whiteCr,
          ),
        ],
      ),
    );
  }
}