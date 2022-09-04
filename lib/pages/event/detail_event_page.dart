import 'package:flutter/material.dart';
import 'package:foxbyte_event/services/color_config.dart';
import 'package:foxbyte_event/utils/helper.dart';
import 'package:foxbyte_event/widgets/k_primary_button.dart';
import 'package:foxbyte_event/widgets/k_text.dart';
import 'package:get/get.dart';

class DetailEventPage extends StatelessWidget {
  const DetailEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.white,
      appBar: Helper.customAppBar(
        title: "Detail Event",
        bgColor: Colors.white,
        textColor: ColorConfig.blackText,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhGXhwIa1o8HpGbvO3aR-PBV9ME4o4wWd9Vw&usqp=CAU",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: KText(
                text: "TRANSFORMAKING: Roadshow Bali FAB Fest 2022",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                isOverflow: false,
                lineHeight: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: KText(
                text:
                    "CAST Foundation bersama Meaningful Design Group menggelar TRANSFORMAKING : Roadshow Bali FAB Fest 2022 yang merupakan acara yang berfokus sebagai forum global dan arena eksperimen bagi para pembuat (makers), inovator, seniman, peneliti, aktivis, insinyur, pengusaha, dan para kreatif untuk terhubung, berkolaborasi bersama menciptakan jalur menuju masa depan bersama dengan menggunakan teknologi sebagai platform untuk mendukung visi masa depan regeneratif planet kita.\n\nAcara ini kami rangkai dalam bentuk sebuah workshop series yaitu TRANSFORMAKING: Roadshow Bali FAB FEST 2022 Workshop Series sebagai sebuah program untuk mengenalkan Bali Fab Fest dengan melibatkan peserta dalam pengenalan lokakarya fabrikasi digital menggunakan teknologi secara kreatif untuk memecahkan suatu masalah dimana pembicara pada workshop ini adalah Bapak Duwi Arsana yang dikenal sebagai seorang digital maker dan youtuber dalam bidang elektronik dengan hampir mencapai 1 juta subscribers.",
                color: ColorConfig.greyText,
                isOverflow: false,
                lineHeight: 1.6,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: ColorConfig.white,
            boxShadow: Helper.getShadow(
              color: ColorConfig.borderLightGrey,
              blurRadius: 4,
              offset: const Offset(0, -4),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KText(
                text: "Ingin tau lokasinya?",
                fontWeight: FontWeight.w600,
                color: ColorConfig.greyText,
              ),
              KPrimaryButton(
                function: () {},
                title: "Buka Maps",
                fontsize: 14,
                width: 120,
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
