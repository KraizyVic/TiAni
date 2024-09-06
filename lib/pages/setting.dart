import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiani/functionality/app_logic.dart';
import 'package:tiani/functionality/data.dart';
import 'package:tiani/utilities/preference_items.dart';

import '../utilities/appearance_tiles.dart';
import '../utilities/settings_tiles.dart';

class Appearance extends StatefulWidget {
  const Appearance({super.key});

  @override
  State<Appearance> createState() => _AppearanceState();
}

class _AppearanceState extends State<Appearance> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder: (context, data, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Appearance",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Theme",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Dark"),
                        Radio(
                          activeColor: data.tertiaryColor,
                          value: 1,
                          groupValue: data.groupvalue,
                          onChanged: (value)=>data.changeTheme(value!),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Light"),
                        Radio(
                          activeColor: data.tertiaryColor,
                          value: 2,
                          groupValue: data.groupvalue,
                          onChanged: (value)=>data.changeTheme(value!),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "Colors",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: colors.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 8, childAspectRatio: 1),
                      itemBuilder: (context, index) {
                        return ColorTile(
                          color: colors[index],
                        );
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "Background picture",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: backgroundImages.length,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1, childAspectRatio: 1 / 1.6),
                      itemBuilder: (context, index) {
                        return BackgroundImage(
                          image: backgroundImages[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Preference extends StatefulWidget {
  const Preference({super.key});

  @override
  State<Preference> createState() => _PreferenceState();
}

class _PreferenceState extends State<Preference> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder: (context, data, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Preference",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: SingleChildScrollView(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Layout",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Grid"),
                          Radio(
                            activeColor: data.tertiaryColor,
                            value: 1,
                            groupValue: data.preferrenceGroupValue,
                            onChanged: (value) => data.changelayout(value!),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("List"),
                          Radio(
                            activeColor: data.tertiaryColor,
                            value: 2,
                            groupValue: data.preferrenceGroupValue,
                            onChanged: (value) => data.changelayout(value!),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Details",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    PreferenceSwitch(
                      switchName: "Show cast",
                      switchValue: data.showCast,
                      onChanged:(value)=>data.showCast = value,
                    ),
                    PreferenceSwitch(
                      switchName: "Show related",
                      switchValue: data.showRelated,
                      onChanged: (value)=>data.showRelated = value,
                    ),
                    PreferenceSwitch(
                      switchName: "Glass-morphic buttons",
                      switchValue: data.enableGlassMorphism,
                      onChanged: (value)=>data.enableGlassMorphism = value,
                    ),
                    PreferenceSwitch(
                      switchName: "Show background pic in main page",
                      switchValue: data.backgroundPicInMainPage,
                      onChanged: (value)=>data.backgroundPicInMainPage = value,
                    ),
                    PreferenceSwitch(
                        switchName: "Preview home tiles",
                        switchValue: data.enablePreview,
                        onChanged: (value) {
                          setState(() {
                            data.enablePreview = value;
                          });
                        }
                    ),
                    PreferenceSwitch(
                      switchName: "Show appbar in home page",
                      switchValue: data.showAppBar,
                      onChanged: (value) {
                        setState(() {
                          data.showAppBar = value;
                        });
                      }
                    ),
                    Text(
                      "Filter content",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    PreferenceSwitch(
                      switchName: "Filter out adult content",
                      switchValue: data.showNsfwContent,
                      onChanged: (value){},
                    ),
                    PreferenceButton(
                        buttonName: "Check updates", icon: Icons.download,
                    ),
                    PreferenceButton(
                      buttonName: "Clear data", icon: Icons.delete_forever,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Terms",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Center(
              child: Text("Something something something ..."),
            ),
          ),
        )
      ],
    );
  }
}

class About extends StatelessWidget {
  const About({super.key});
  void onEnter() {
    print("Pressed");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder:(context,data,child)=> Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About app",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                margin: EdgeInsets.only(right: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SettingsTiles(
                      buttonName: "App name",
                      autofocus: false,
                      onEnter: () {},
                      action: Text("Tiani"),
                    ),
                    SettingsTiles(
                      buttonName: "Version",
                      autofocus: false,
                      onEnter: () {},
                      action: Text("1.0.0"),
                    ),
                    SettingsTiles(
                      buttonName: "Release date",
                      autofocus: false,
                      onEnter: () {},
                      action: Text("6 / Aug / 2024"),
                    ),
                    SettingsTiles(
                        buttonName: "Status",
                        autofocus: false,
                        onEnter: () {},
                        action: Text("Active")),
                    SettingsTiles(
                      buttonName: "Acounts",
                      autofocus: false,
                      onEnter: () {},
                      action: Text("${data.accounnts.length}"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Contact",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Center(
              child: Text("kraizyvic@gmail.com"),
            ),
          ),
        )
      ],
    );
  }
}
