import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:get/get.dart';
import 'package:groundfresh/views/cart_screen/cart_screen.dart';
import 'package:groundfresh/views/categorise_screen/categorise_screen.dart';
import 'package:groundfresh/views/controllers/home_controller.dart';
import 'package:groundfresh/views/home_screen/home_screen.dart';
import 'package:groundfresh/views/home_screen/componnent/appbar_componnent.dart';
import 'package:groundfresh/views/profile_screen/profile_screen.dart';
import 'package:groundfresh/widget_common/exit_dialog.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var homeAllPage = [
      const HomeScreen(),
      const CartScreen(),
      const CategoriseScreen(),
      const ProfileScreen()
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        appBar: appbar(context),
        body: Obx(
          () => Column(
            children: [
              Expanded(
                child: homeAllPage.elementAt(controller.CurrentNavIndex.value),
              )
            ],
          ),
        ),
        bottomNavigationBar: Obx(
          () => Container(
            decoration: BoxDecoration(
              color: scaffoldColor,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                child: GNav(
                  rippleColor: greencolor,
                  gap: 8,
                  activeColor: whiteColor,
                  iconSize: 24,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.greenAccent,
                  color: greencolor,
                  tabBorderRadius: 10,
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.shopping_cart,
                      text: 'Cart',
                    ),
                    GButton(
                      icon: Icons.apps,
                      text: 'Categorise',
                    ),
                    GButton(
                      icon: Icons.person,
                      text: 'Profile',
                    ),
                  ],
                  selectedIndex: controller.CurrentNavIndex.value,
                  onTabChange: (Value) {
                    controller.CurrentNavIndex.value = Value;
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
