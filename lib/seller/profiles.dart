import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/consts/loding_indicator.dart';
import 'package:groundfresh/views/controllers/firestore_services.dart';

class Profiles extends StatelessWidget {
  const Profiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Profile".text.color(darkFontGrey).make(),
        elevation: 0,
        backgroundColor: scaffoldColor,
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: lodingIndicator(),
              );
            } else {
              var data = snapshot.data!.docs[0];
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.purpleAccent,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: "${data["name"]}".text.make(),
                          subtitle: "${data["email"]}".text.make(),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
