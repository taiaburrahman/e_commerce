import 'package:get/get.dart';
import 'package:groundfresh/consts/consts.dart';
import 'package:groundfresh/consts/loding_indicator.dart';
import 'package:groundfresh/seller/controller/pontroller.dart';
import 'package:groundfresh/widget_common/customTextField.dart';
import 'package:groundfresh/widget_common/ourButton.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({super.key});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  var controller = Get.put(PController());
  void unitchange(value) {
    setState(() {
      controller.unitvalue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: scaffoldColor,
        title: "Add to product".text.color(darkFontGrey).make(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customTextFeild(
                hint: "Product name",
                isPass: false,
                title: "Product Name",
                controller: controller.pnamecontroller),
            10.heightBox,
            customTextFeild(
              controller: controller.ppricecontroller,
              keyboardType: TextInputType.number,
              hint: "Price",
              isPass: false,
              title: "Price",
            ),
            10.heightBox,
            Row(
              children: [
                Radio(
                    activeColor: greencolor,
                    value: "Kg",
                    groupValue: controller.unitvalue,
                    onChanged: unitchange),
                "Kg".text.color(greencolor).make(),
                8.widthBox,
                Radio(
                    activeColor: greencolor,
                    value: "Pieces",
                    groupValue: controller.unitvalue,
                    onChanged: unitchange),
                "Pieces".text.color(greencolor).make(),
                8.widthBox,
                Radio(
                    activeColor: greencolor,
                    value: "Gram",
                    groupValue: controller.unitvalue,
                    onChanged: unitchange),
                "Gram".text.color(greencolor).make(),
              ],
            ),
            10.heightBox,
            customTextFeild(
              controller: controller.unitcontroller,
              keyboardType: TextInputType.number,
              hint: "Unit",
              isPass: false,
              title: "Unit",
            ),
            10.heightBox,
            customTextFeild(
              controller: controller.pdescontoller,
              hint: "Description",
              isPass: false,
              title: "Description",
            ),
            10.heightBox,
            customTextFeild(
              controller: controller.pquantitycontroller,
              keyboardType: TextInputType.number,
              hint: "Quantity",
              isPass: false,
              title: "Quantity",
            ),
            10.heightBox,
            "Choose product Category".text.color(darkFontGrey).make(),
            10.heightBox,
            DropdownButton<String>(
              dropdownColor: whiteColor,
              isExpanded: true,
              iconEnabledColor: Colors.white,
              focusColor: greencolor,
              items: controller.options.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(
                    dropDownStringItem,
                    style: const TextStyle(
                      color: darkFontGrey,
                      fontFamily: semibold,
                      fontSize: 14,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (newValueSelected) {
                setState(() {
                  controller.currentItemSelected = newValueSelected!;
                  controller.categorylistt = newValueSelected;
                });
              },
              value: controller.currentItemSelected,
            )
                .box
                .padding(const EdgeInsets.symmetric(
                  horizontal: 5,
                ))
                .rounded
                .color(grey)
                .make(),
            10.heightBox,
            "Choose product image".text.color(darkFontGrey).make(),
            10.heightBox,
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                    3,
                    (index) => InkWell(
                          onTap: () {
                            controller.pikImg(
                              index,
                              context,
                            );
                          },
                          child: controller.pImgList[index] != null
                              ? Image.file(
                                  controller.pImgList[index],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ).onTap(() {
                                  controller.pikImg(index, context);
                                })
                              : productImg(lable: "${index + 1}"),
                        )),
              ),
            )
          ],
        ).box.padding(const EdgeInsets.all(15)).make(),
      ),
      bottomNavigationBar: Obx(
        () => SizedBox(
            width: 50,
            height: 50,
            child: controller.isLoding.value
                ? lodingIndicator()
                : ourButton(
                    color: Colors.purple,
                    textColor: whiteColor,
                    onPress: () async {
                      controller.isLoding(true);
                      await controller.uploadPImgae();
                      await controller.uploadproduct(context);
                      Get.back();
                    },
                    title: "Save")),
      ),
    );
  }

  productImg({lable}) {
    return "$lable"
        .text
        .bold
        .color(fontGrey)
        .makeCentered()
        .box
        .color(grey)
        .size(100, 100)
        .roundedSM
        .make();
  }
}
