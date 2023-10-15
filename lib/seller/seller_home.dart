import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/seller/controller/homecontroller.dart';
import 'package:groundfresh/seller/orderss.dart';
import 'package:groundfresh/seller/product.dart';
import 'package:groundfresh/seller/profiles.dart';
import 'package:groundfresh/widget_common/exit_dialog.dart';

class SellerHome extends StatefulWidget {
  const SellerHome({super.key});

  @override
  State<SellerHome> createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome> {
  var navscren = [ProductScreenn(), OrdersS(), Profiles()];
  var bottomnav = [
    const BottomNavigationBarItem(icon: Icon(Icons.home)),
    const BottomNavigationBarItem(icon: Icon(Icons.archive)),
    const BottomNavigationBarItem(icon: Icon(Icons.assignment))
  ];
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Homecontrollerr());
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Obx(
          () => Column(
            children: [
              Expanded(
                child: navscren.elementAt(controller.navIndex.value),
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
                  rippleColor: Colors.purple,
                  gap: 8,
                  activeColor: whiteColor,
                  iconSize: 24,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.purple,
                  color: Colors.purple,
                  tabBorderRadius: 10,
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      text: 'Products',
                    ),
                    GButton(
                      icon: Icons.library_books_outlined,
                      text: 'Orders',
                    ),
                    GButton(
                      icon: Icons.person,
                      text: 'Profile',
                    ),
                  ],
                  selectedIndex: controller.navIndex.value,
                  onTabChange: (Value) {
                    controller.navIndex.value = Value;
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
