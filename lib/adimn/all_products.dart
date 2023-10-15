import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/consts/loding_indicator.dart';
import 'package:groundfresh/views/controllers/firestore_services.dart';

class AllProductAdmin extends StatelessWidget {
  const AllProductAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "All Product".text.color(darkFontGrey).make(),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: StreamBuilder(
            stream: FirestoreServices.allProductGet(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: lodingIndicator(),
                );
              } else {
                var allproductData = snapshot.data!.docs;
                return SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                        allproductData.length,
                        (index) => ListTile(
                              leading: Image.network(
                                allproductData[index]["p_imgs"][0],
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                              title: "${allproductData[index]["p_name"]}"
                                  .text
                                  .make(),
                              subtitle: "${allproductData[index]["p_price"]}"
                                  .numCurrency
                                  .text
                                  .make(),
                            )),
                  ),
                );
              }
            }),
      ),
    );
  }
}
