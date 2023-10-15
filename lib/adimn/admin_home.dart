import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:groundfresh/adimn/admincontroller.dart';
import 'package:groundfresh/adimn/all_products.dart';
import 'package:groundfresh/adimn/all_seller.dart';
import 'package:groundfresh/adimn/all_user.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/widget_common/exit_dialog.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  var navscren = [AllProductAdmin(), AllSeller(), AllBuyer()];
  var bottomnav = [
    const BottomNavigationBarItem(icon: Icon(Icons.home)),
    const BottomNavigationBarItem(icon: Icon(Icons.archive)),
    const BottomNavigationBarItem(icon: Icon(Icons.assignment))
  ];

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Adminconroller());
    return Scaffold(
        body: WillPopScope(
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
                  rippleColor: Color(0xFF083663),
                  gap: 8,
                  activeColor: whiteColor,
                  iconSize: 24,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Color(0xFF083663),
                  color: Color(0xFF083663),
                  tabBorderRadius: 10,
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      text: 'Products',
                    ),
                    GButton(
                      icon: Icons.person,
                      text: 'Seller',
                    ),
                    GButton(
                      icon: Icons.person,
                      text: 'Buyer',
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
    ));
  }
}
