import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserRecognitionPage extends StatefulWidget {
  const UserRecognitionPage({super.key});

  @override
  State<UserRecognitionPage> createState() => _UserRecognitionPageState();
}

class _UserRecognitionPageState extends State<UserRecognitionPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 2),
      child: SafeArea(
        child: Scaffold(
          /* bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(20.0),
            child: _CustomButton(
              textButton: "Boton",
              color: Colors.amber,
              disableColor: Colors.amber.withOpacity(0.3),
              padding: EdgeInsets.symmetric(horizontal: 50),
              onPressed: null,
            ),
          ), */
          body: Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            color: Colors.white,
            margin: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ///
                ///
                _SearchField(),

                SizedBox(height: 10),

                SizedBox(height: 200, width: double.infinity, child: Search()),

                /* AppBar(
                  title: Text("Generic"),
                  leading: Icon(Icons.abc),
                  flexibleSpace: SizedBox(
                    height: 20,
                    child: Center(child: Icon(Icons.abc)),
                  ),
                ),
                Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  color: Colors.white,
                  margin: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Container(
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8.0),
                            topLeft: Radius.circular(8.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Card(
                                elevation: 0,
                                color: Colors.lightBlue.withOpacity(0.15),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Icon(
                                        Icons.info,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                              "Desliza hacia un lado para eliminar"),
                                        )),
                                    Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        child: Icon(
                                          Icons.close,
                                          size: 18,
                                        ),
                                        onTap: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            _UsersAvatar(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text("userName"),
                            ),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                return InkWell(
                                  child: Icon(
                                    Icons.close,
                                    size: 18,
                                  ),
                                  onTap: () {
                                    print(constraints);
                                    print(MediaQuery.of(context).size);
                                  },
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
               */
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomButton extends StatelessWidget {
  String? textButton;
  Color? color;
  Color? disableColor;
  EdgeInsetsGeometry? padding;

  final VoidCallback? onPressed;

  _CustomButton({
    super.key,
    this.textButton,
    this.color,
    this.disableColor,
    this.padding,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 50.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          backgroundColor: color,
          disabledBackgroundColor: disableColor,
          disabledForegroundColor: disableColor,
          //padding: padding ?? const EdgeInsets.all(12.0),
        ),
        child: Text(textButton ?? ""),
        onPressed: onPressed,
      ),
    );
  }
}

class _UsersAvatar extends StatefulWidget {
  _UsersAvatar({
    super.key,
  });

  @override
  State<_UsersAvatar> createState() => _UsersAvatarState();
}

class _UsersAvatarState extends State<_UsersAvatar> {
  var list = [0];

  @override
  Widget build(BuildContext context) {
    return _avatarBuilder(list);
  }

  Widget _avatarBuilder(List<int> userList) {
    int totalUsers = userList.length;
    List<int> mapUsers = totalUsers < 5 ? userList : userList.sublist(0, 4);
    int totalMapUsers = mapUsers.length;
    String names = "";

    for (var i = 0; i < totalMapUsers; i++) {
      var user = userList[i];
      names += "userName $i";

      if (totalUsers < 5) {
        if (i != totalMapUsers - 1 && i != totalMapUsers - 2) {
          names += ", ";
        }
        if (i == totalMapUsers - 2) {
          names += " y ";
        }
      } else {
        if (i != totalMapUsers - 1) {
          names += ", ";
        }
        if (i == totalMapUsers - 1) {
          names += " y ${totalUsers - totalMapUsers} más";
        }
      }
    }

    if (totalUsers == 1) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/avatar.jpg',
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "userName",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: mapUsers.map(
                  (index) {
                    double widthavatar = index * (40);

                    return Row(
                      children: [
                        SizedBox(width: widthavatar),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            'assets/avatar.jpg',
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              names,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class User {
  String? name;
  String? avatar;

  User(this.name, this.avatar);
}

class _SearchField extends StatefulWidget {
  const _SearchField({super.key});

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  final SearchController _searchController = SearchController();

  String data = '';

  Color? selectedColorSeed;
  List<ColorLabel> searchHistory = <ColorLabel>[];

  Iterable<Widget> getHistoryList(SearchController controller) {
    return searchHistory.map(
      (ColorLabel color) => ListTile(
        leading: const Icon(Icons.history),
        title: Text(color.label),
        trailing: IconButton(
          icon: const Icon(Icons.call_missed),
          onPressed: () {
            controller.text = color.label;
            controller.selection =
                TextSelection.collapsed(offset: controller.text.length);
          },
        ),
      ),
    );
  }

  Iterable<Widget> getSuggestions(SearchController controller) {
    final String input = controller.value.text;
    return ColorLabel.values
        .where((ColorLabel color) => color.label.contains(input))
        .map(
          (ColorLabel filteredColor) => ListTile(
            leading: CircleAvatar(backgroundColor: filteredColor.color),
            title: Text(filteredColor.label),
            trailing: IconButton(
              icon: const Icon(Icons.call_missed),
              onPressed: () {
                controller.text = filteredColor.label;
                controller.selection =
                    TextSelection.collapsed(offset: controller.text.length);
              },
            ),
            onTap: () {
              controller.closeView(filteredColor.label);
              handleSelection(filteredColor);
            },
          ),
        );
  }

  void handleSelection(ColorLabel selectedColor) {
    setState(() {
      selectedColorSeed = selectedColor.color;
      if (searchHistory.length >= 5) {
        searchHistory.removeLast();
      }
      searchHistory.insert(0, selectedColor);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchAnchor(
          searchController: _searchController,
          //isFullScreen: false,
          builder: (BuildContext context, SearchController controller) {
            return
                //
                SearchBar(
              //TextField(
              controller: controller,
              /*   padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0)), */
              onSubmitted: (value) {
                if (value.length > 0) {
                  print(value);
                  controller.text = value;
                  data = value;
                  controller.openView();
                }
              },
              //onTap: () => controller.openView(),
              /* onChanged: (value) {
                print(value);
                controller.openView();
              }, */
              leading: const Icon(Icons.search),
              /* trailing: <Widget>[
            Tooltip(
              message: 'Change brightness mode',
              child: IconButton(
                isSelected: true,
                onPressed: () {
                  print("Hola Mundo");
                },
                icon: const Icon(Icons.wb_sunny_outlined),
                selectedIcon: const Icon(Icons.brightness_2_outlined),
              ),
            )
          ], */
            );
          },
          suggestionsBuilder:
              (BuildContext context, SearchController controller) {
            final keyword = controller.value.text;
            /* final initKeyword = String.fromCharCodes(keyword.runes);
*/
            if (keyword != data) {
              controller.closeView(keyword);
            }

            print(keyword);
            return getSuggestions(controller);
            /* return List<ListTile>.generate(5, (int index) {
              final String item = 'item $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    controller.closeView(item);
                    //FocusScope.of(context).unfocus();
                  });
                },
              );
            }); */
            /* return [
          Container(color: Colors.amber, child: Center(child: Text("data")))
        ]; */
          }),
    );
  }
}

/* suggestionsBuilder:
              (BuildContext context, SearchController controller) {
            final keyword = controller.value.text;
            print(keyword);
            return List.generate(5, (index) => 'Item $index')
                .where((element) =>
                    element.toLowerCase().contains(keyword.toLowerCase()))
                .map((item) => ListTile(
                      title: Text(item),
                      onTap: () {
                        setState(() {
                          controller.closeView(item);
                          FocusScope.of(context).unfocus();
                        });
                      },
                    ));
          }, */

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final SearchController _searchController = SearchController();

  Color? selectedColorSeed;
  List<ColorLabel> searchHistory = <ColorLabel>[];

  // these will be reused later
  final leading = const Icon(Icons.search);
  final trailing = [
    IconButton(
      icon: const Icon(Icons.keyboard_voice),
      onPressed: () {
        print('Use voice command');
      },
    ),
    IconButton(
      icon: const Icon(Icons.camera_alt),
      onPressed: () {
        print('Use image search');
      },
    ),
  ];

  Iterable<Widget> getHistoryList(SearchController controller) {
    return searchHistory.map(
      (ColorLabel color) => ListTile(
        leading: const Icon(Icons.history),
        title: Text(color.label),
        trailing: IconButton(
          icon: const Icon(Icons.call_missed),
          onPressed: () {
            controller.text = color.label;
            controller.selection =
                TextSelection.collapsed(offset: controller.text.length);
          },
        ),
      ),
    );
  }

  Iterable<Widget> getSuggestions(SearchController controller) {
    final String input = controller.value.text;
    return ColorLabel.values
        .where((ColorLabel color) => color.label.contains(input))
        .map(
          (ColorLabel filteredColor) => ListTile(
            leading: CircleAvatar(backgroundColor: filteredColor.color),
            title: Text(filteredColor.label),
            trailing: IconButton(
              icon: const Icon(Icons.call_missed),
              onPressed: () {
                controller.text = filteredColor.label;
                controller.selection =
                    TextSelection.collapsed(offset: controller.text.length);
              },
            ),
            onTap: () {
              controller.closeView(filteredColor.label);
              handleSelection(filteredColor);
            },
          ),
        );
  }

  void handleSelection(ColorLabel selectedColor) {
    setState(() {
      selectedColorSeed = selectedColor.color;
      if (searchHistory.length >= 5) {
        searchHistory.removeLast();
      }
      searchHistory.insert(0, selectedColor);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SearchAnchor(
          searchController: _searchController,
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              leading: leading,
              trailing: trailing,
              onSubmitted: (value) {
                if (value.length > 0) {
                  print(value);
                  controller.text = value;
                  controller.openView();
                }
              },
            );
          },
          suggestionsBuilder:
              (BuildContext context, SearchController controller) {
            final keyword = controller.value.text;
            print(keyword);
            /* return List.generate(5, (index) => 'Item $index')
                .where((element) =>
                    element.toLowerCase().contains(keyword.toLowerCase()))
                .map((item) => ListTile(
                      title: Text(item),
                      onTap: () {
                        setState(() {
                          controller.closeView(item);
                          FocusScope.of(context).unfocus();
                        });
                      },
                    )); */

            return ColorLabel.values
                .where((ColorLabel color) =>
                    color.label.contains(keyword.toLowerCase()))
                .map(
                  (ColorLabel filteredColor) => ListTile(
                    leading: CircleAvatar(backgroundColor: filteredColor.color),
                    title: Text(filteredColor.label),
                    trailing: IconButton(
                      icon: const Icon(Icons.call_missed),
                      onPressed: () {
                        controller.text = filteredColor.label;
                        controller.selection = TextSelection.collapsed(
                            offset: controller.text.length);
                      },
                    ),
                    onTap: () {
                      controller.closeView(filteredColor.label);
                      handleSelection(filteredColor);
                    },
                  ),
                );
          },
        ),
        Expanded(
          child: Center(
            child: _searchController.text.isEmpty
                ? const Text('No keyword')
                : Text('Keyword: ${_searchController.value.text}'),
          ),
        ),
      ],
    );
  }
}

enum ColorLabel {
  red('red', Colors.red),
  orange('orange', Colors.orange),
  yellow('yellow', Colors.yellow),
  green('green', Colors.green),
  blue('blue', Colors.blue),
  indigo('indigo', Colors.indigo),
  violet('violet', Color(0xFF8F00FF)),
  purple('purple', Colors.purple),
  pink('pink', Colors.pink),
  silver('silver', Color(0xFF808080)),
  gold('gold', Color(0xFFFFD700)),
  beige('beige', Color(0xFFF5F5DC)),
  brown('brown', Colors.brown),
  grey('grey', Colors.grey),
  black('black', Colors.black),
  white('white', Colors.white),
  blueAccent('blueAccent', Colors.blueAccent),
  redAccent('redAccent', Colors.redAccent),
  deepOrange('deepOrange', Colors.deepOrange),
  amber('amber', Colors.amber);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}
