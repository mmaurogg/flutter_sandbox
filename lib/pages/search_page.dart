import 'package:flavoring_flavorizr/pages/search_bar.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(children: [
              /* Container(
                color: Colors.transparent,
                height: 100,
                width: 100,
              ), */

              /* _SearchField(),
              SizedBox(height: 100),
              SizedBox(height: 100, child: Search()), */
              SizedBox(height: 100, child: SearchClass()),
              SizedBox(height: 20),
              SizedBox(height: 100, child: SearchBarItem()),

              /* IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: SearchBarDelegate(''));
                },
              ), */
            ]),
          ),
        ),
      ),
    );
  }
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

  final searchFieldNode = FocusNode();

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
              focusNode: searchFieldNode,
              controller: controller,
              hintText: "Ejemplo sin busqueda interna",
              /*   padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0)), */
              onSubmitted: (value) {
                if (value.length > 0) {
                  print(value);
                  controller.text = value;
                  data = value;
                  _searchController.openView();
                }
              },
              leading: const Icon(Icons.search),
            );
          },
          suggestionsBuilder:
              (BuildContext context, SearchController controller) {
            final keyword = controller.value.text;

            if (keyword != data) {
              _searchController.closeView(keyword);
              data = keyword;
              //FocusScope.of(context). searchFieldNode
              //FocusScope.of(context).autofocus(searchFieldNode);
              //FocusScope.of(context).requestFocus(searchFieldNode);
              //FocusScope.of(context).requestFocus(FocusNode());
            }
            print(_searchController.isOpen);
            print(keyword);
            return getSuggestions(controller);
          }),
    );
  }
}

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
  amber('amber', Colors.amber),
  red1('red', Colors.red),
  orange1('orange', Colors.orange),
  yellow1('yellow', Colors.yellow),
  green1('green', Colors.green),
  blue1('blue', Colors.blue),
  indigo1('indigo', Colors.indigo),
  violet1('violet', Color(0xFF8F00FF)),
  purple1('purple', Colors.purple),
  pink1('pink', Colors.pink),
  silver1('silver', Color(0xFF808080)),
  gold1('gold', Color(0xFFFFD700)),
  beige1('beige', Color(0xFFF5F5DC)),
  brown1('brown', Colors.brown),
  grey1('grey', Colors.grey),
  black1('black', Colors.black),
  white1('white', Colors.white),
  blueAccent1('blueAccent', Colors.blueAccent),
  redAccent1('redAccent', Colors.redAccent),
  deepOrange1('deepOrange', Colors.deepOrange),
  amber1('amber', Colors.amber),
  red2('red', Colors.red),
  orange2('orange', Colors.orange),
  yellow2('yellow', Colors.yellow),
  green2('green', Colors.green),
  blue2('blue', Colors.blue),
  indigo2('indigo', Colors.indigo),
  violet2('violet', Color(0xFF8F00FF)),
  purple2('purple', Colors.purple),
  pink2('pink', Colors.pink),
  silver2('silver', Color(0xFF808080)),
  gold2('gold', Color(0xFFFFD700)),
  beige2('beige', Color(0xFFF5F5DC)),
  brown2('brown', Colors.brown),
  grey2('grey', Colors.grey),
  black2('black', Colors.black),
  white2('white', Colors.white),
  blueAccent2('blueAccent', Colors.blueAccent),
  redAccent2('redAccent', Colors.redAccent),
  deepOrange2('deepOrange', Colors.deepOrange),
  amber2('amber', Colors.amber);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}

class SearchClass extends StatefulWidget {
  const SearchClass({super.key});

  @override
  State<SearchClass> createState() => _SearchClassState();
}

class _SearchClassState extends State<SearchClass> {
  final _textController = TextEditingController();

  late Widget listOptions;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        child:

            /* TextField(
        controller: _textController,
        decoration: InputDecoration(
            label: Row(
              children: [
                //Icon(Icons.search),
                Text("busqueda personalizda"),
              ],
            ),
            border: OutlineInputBorder(),
            prefix: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchBarDelegate(''));
              },
            )),
        onSubmitted: (value) {
          showSearch(context: context, delegate: SearchBarDelegate(value));
        },
      ), */

            SearchBar(
                controller: _textController,
                leading: const Icon(Icons.search),
                onSubmitted: (value) {
                  showSearch(
                      context: context,
                      delegate: SearchBarDelegate(
                        textToSearch: value,
                        onSubmitted: (value) {
                          //llamado al api
                        },
                      )

                      /*  CustomSearchDelegate<String>(
                      searchables: searchables,
                      suggestionOrResult:
                          (List<String> suggestions, String query) =>
                              ListWidget(
                        suggestionsList: searchables,
                        query: query,
                      ),
                      itemMatcher: (String item, String query) =>
                          item.toLowerCase().contains(query.toLowerCase()),
                    ), */
                      );

                  //setState(() {});
                }));
  }
}

class SearchBarDelegate extends SearchDelegate<String> {
  String textToSearch;
  //final ValueChanged? onChanged;
  final ValueChanged onSubmitted;

  SearchBarDelegate({
    required this.textToSearch,
    //this.onChanged,
    required this.onSubmitted,
  });

  @override
  String get searchFieldLabel => query != "" ? query : textToSearch;
/* 
  @override
  // TODO: implement query
  String get query => super.query; */

  // Sobrescribe el método buildActions para agregar acciones a la barra de búsqueda
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          // Lógica para limpiar la barra de búsqueda
          query = '';
          //close(context, '');
        },
      ),
    ];
  }

  // Sobrescribe el método buildLeading para agregar un ícono de vuelta en la barra de búsqueda
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        // Cierra la barra de búsqueda
        close(context, '');
      },
    );
  }

  // Sobrescribe el método buildResults para mostrar los resultados de la búsqueda
  @override
  Widget buildResults(BuildContext context) {
    textToSearch = query;
    onSubmitted(query);
    return buildSugestionOrResult(query);
    //return buildSugestionOrResult;
  }

  // Sobrescribe el método buildSuggestions para mostrar sugerencias mientras se escribe en la barra de búsqueda
  @override
  Widget buildSuggestions(BuildContext context) {
    return buildSugestionOrResult(textToSearch);
    //return buildSugestionOrResult;
  }

  Widget buildSugestionOrResult(String keyword) {
    final filteredList = ColorLabel.values
        .where(
            (ColorLabel color) => color.label.contains(keyword.toLowerCase()))
        .toList();

    return ListView.builder(
      controller: ScrollController(),
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final filteredColor = filteredList[index];
        return ListTile(
          leading: CircleAvatar(backgroundColor: filteredColor.color),
          title: Text(filteredColor.label),
          trailing: IconButton(
            icon: const Icon(Icons.call_missed),
            onPressed: () {
              /* controller.text = filteredColor.label;
                        controller.selection = TextSelection.collapsed(
                            offset: controller.text.length); */
            },
          ),
          onTap: () {
            /* controller.closeView(filteredColor.label);
                      handleSelection(filteredColor); */
          },
        );
      },
    );
  }
}
