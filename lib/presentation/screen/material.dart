import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:test_maha_dev/model/user_response_model.dart';
import 'package:test_maha_dev/presentation/provider/material_provider.dart';

class MaterialScreen extends StatelessWidget {
  static const routeName = "/material-screen";
  const MaterialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Barang"),
        actions: [
          InkWell(
            onTap: () => showFormData(context: context),
            child: Icon(Icons.add),
          ),
          SizedBox(width: 24,)
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Consumer<MaterialProvider>(
          builder: (context, provider, _) {

            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (provider.data.isEmpty) {
              return const Center(
                child: Text("Data Kosong"),
              );
            }

            return ListView.separated(
                itemBuilder: (context, index) {
                  User user = provider.data[index];
                  return Container(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundImage: (user.avatar?.isNotEmpty ?? false)
                                ? Image.network(user.avatar!).image
                                : null,
                            backgroundColor: (user.avatar?.isNotEmpty ?? false) ? null : Colors.grey,
                          ),
                          const SizedBox(width: 14,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${user.firstName} ${(user.lastName?.isNotEmpty ?? false) ? user.lastName : ""}"),
                              const SizedBox(height: 5,),
                              Text("Stock : ${user.stock}")
                            ],
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () => showFormData(context: context, isUpdate: true, user: user),
                            child: const Icon(Icons.edit),
                          ),
                          const SizedBox(width: 5,),
                          InkWell(
                            onTap: () => provider.deleteUser(user.id.toString()),
                            child: const Icon(
                                Icons.delete, color: Colors.redAccent),
                          )
                        ]
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: provider.data.length
            );
          },
        ),
      ),
    );
  }

  showFormData({required BuildContext context, bool isUpdate = false, User? user}) {
    showModalBottomSheet(
        // isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12)),
        ),
        context: context,
        builder: (BuildContext currentContext) {

          MaterialProvider materialProvider = context.read<MaterialProvider>();

          if (isUpdate && user != null) {
            materialProvider
              ..nameController.text = "${user.firstName} ${user.lastName}"
              ..stockController.text = user.stock.toString()
              ..jobController.text = user.job ?? "";
          } else {
            materialProvider
              ..nameController.text = ""
              ..stockController.text = ""
              ..jobController.text = "";
          }

          return ChangeNotifierProvider.value(
              value: materialProvider,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height / 2.4,
                    maxHeight: MediaQuery.of(context).size.height - kToolbarHeight),
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height / 2.4,
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 24),
                    child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(isUpdate ? "Update Data" : "Tambah Data", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                            SizedBox(height: 10,),
                            TextFormField(
                              controller: materialProvider.nameController,
                              decoration: InputDecoration(
                                  hintText: "Nama",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(12)))
                              ),
                            ),
                            SizedBox(height: 10,),
                            TextFormField(
                              controller: materialProvider.jobController,
                              decoration: InputDecoration(
                                  hintText: "Pekerjaan",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(12)))
                              ),
                            ),
                            SizedBox(height: 10,),
                            TextFormField(
                              controller: materialProvider.stockController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                  hintText: "Stock",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(12)))
                              ),
                            ),
                            SizedBox(height: 10,),
                            SizedBox(
                              height: 54,
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (isUpdate && user != null) {
                                    bool isSuccess = await materialProvider.updateUser(user.id.toString() ?? "");
                                    if (isSuccess) {
                                      if (context.mounted) {
                                        AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.success,
                                            title: "Success",
                                            desc: "Berhasil diubah",
                                            btnOkOnPress: () {
                                              Navigator.of(context).pop();
                                            }
                                        ).show();
                                      }
                                    }
                                    return;
                                  }

                                  bool isSuccess = await materialProvider.createUser();
                                  if (isSuccess) {
                                    if (context.mounted) {
                                      AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.success,
                                          title: "Success",
                                          desc: "Berhasil ditambah",
                                          btnOkOnPress: () {
                                            Navigator.of(context).pop();
                                          }
                                      ).show();
                                    }
                                  }
                                  return;

                                },
                                style: ButtonStyle(
                                    textStyle: MaterialStateProperty.all<TextStyle>(
                                        const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          // side:
                                          // BorderSide(color: borderSideColor, style: borderStyle)
                                        ))),
                                child: Center(child: Text(isUpdate ? "Update" : "Simpan")),
                              ),
                            )
                          ],
                        )
                    ),
                  ),
                ),
              )
          );
        });
  }
}
