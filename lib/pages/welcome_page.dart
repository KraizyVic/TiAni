import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiani/functionality/app_logic.dart';
import 'package:tiani/pages/main_page.dart';
import 'package:tiani/services/anime_service.dart';
import 'package:tiani/utilities/mods.dart';

import '../models/anime_model.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late Future<List<AnimeModel>> animes;
  @override
  void initState() {
    // TODO: implement initState
    animes = AnimeService().getAllAnimes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder: (context, data, child) => Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: Stack(
          children: [
            Image.asset(
              data.currentPic,
              fit: BoxFit.cover,
              height: double.maxFinite,
              width: double.maxFinite,
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Theme.of(context).canvasColor,
                  Theme.of(context).canvasColor.withOpacity(0.3)
                ],
              )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TiAni",
                      style: TextStyle(fontSize: 40),
                    ),
                    Text(
                      "Home of Anime",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                SizedBox(
                  width: 50,
                ),
                CircularProgressIndicator(
                  color: data.tertiaryColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
