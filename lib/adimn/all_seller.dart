import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groundfresh/adimn/admincontroller.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/consts/loding_indicator.dart';

class AllSeller extends StatelessWidget {
  const AllSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "All Seller".text.color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
          stream: StoreServicess.getAllseller(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: lodingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No product found".text.white.makeCentered();
            } else {
              var datas = snapshot.data!.docs;
              return SingleChildScrollView(
                child: Column(
                  children: List.generate(
                      datas.length,
                      (index) => ListTile(
                            leading: "${index + 1}".text.make(),
                            title: "${datas[index]["name"]}".text.make(),
                            subtitle: "${datas[index]["email"]}".text.make(),
                          )),
                ),
              );
            }
          }),
    );
  }
}
