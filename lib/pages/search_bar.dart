import 'package:flutter/material.dart';

class SearchBarItem extends StatefulWidget {
  const SearchBarItem({super.key});

  @override
  State<SearchBarItem> createState() => _SearchBarItemState();
}

class _SearchBarItemState extends State<SearchBarItem> {
  List<String> options = [
    "Flutter",
    "Search",
    "Orange",
    "Build",
    "Flutter",
    "Search",
    "Orange",
    "Build",
  ];

  List<String> response = [];

  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    callEndpint("");
  }

  callEndpint(String query) {
    response = query.isEmpty
        ? options
        : options
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();

    print("endpoint");
  }

  String? query1;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        child: SearchBar(
            //TextField(
            controller: _textController,
            //leading: const Icon(Icons.search),
            //onTap: () {},
            onSubmitted: (value) {
              if (value.length > 0) {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate<String>(
                    textToSearch: value,
                    options: response,
                    onTap: (value) {
                      print('object');
                      callEndpint(value);
                    },
                    optionsBuilder: (List<String> optionsList, String? query) {
                      /* return ListWidget(
                      suggestionsList: options,
                      query: query,
                    ); */

                      return ListView.builder(
                        controller: ScrollController(),
                        itemCount: optionsList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            //leading: CircleAvatar(backgroundColor: filteredColor.color),
                            leading:
                                CircleAvatar(backgroundColor: Colors.blueGrey),
                            //title: Text(filteredColor.label),
                            title: Text(optionsList[index]),
                            trailing: IconButton(
                              icon: const Icon(Icons.call_missed),
                              onPressed: () {},
                            ),
                            onTap: () {},
                          );
                        },
                      );
                    },
                    /*  itemMatcher: (String item, String query) {
                    //return true;
                    return item.toLowerCase().contains(query.toLowerCase()); 
                  }, */
                  ),
                );
              }
            }));
  }
}

class CustomSearchDelegate<T> extends SearchDelegate<List<T>> {
  CustomSearchDelegate({
    required this.textToSearch,
    required this.options,
    required this.optionsBuilder,
    //required this.itemMatcher,
    this.onTap,
  });

  String textToSearch;

  // Items to be searched
  final List<T> options;

  // Widget that needs to be displayed when getting suggestion or result.
  // If you want sepearate widget for suggestion and result, you can add
  // 2 arguments, suggestionWidget and resultWidget to build differently.
  final Widget Function(List<T>, String?) optionsBuilder;

  // Query against which matching will run
  //final bool Function(T item, String query) itemMatcher;

  // Callback when item is tapped
  final ValueChanged? onTap;

  @override
  String get searchFieldLabel => query != "" ? query : textToSearch;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, []);
      },
      icon: Icon(
        //Platform.isAndroid ? Icons.arrow_back :
        Icons.arrow_back_ios,
        size: 22,
      ),
    );
  }

  @override
  buildResults(BuildContext context) {
    //print("Resul");
    textToSearch = query;
    if (onTap != null) onTap!(query);
    //return _buildSuggestionOrResult(query);
    return SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //print("Suggestion");
    if (options.isEmpty) return const SizedBox();
    return _buildSuggestionOrResult(null);
  }

  Widget _buildSuggestionOrResult(String? keyword) {
    //print("object");
    final List<T> suggestionList =
        //
        options;
    /* keyword.isEmpty
        ? options
        : options.where((item) => itemMatcher(item, keyword)).toList();
 */
    if (suggestionList.isEmpty) {
      return Center(child: Text("No hay resultados"));
    }

    return optionsBuilder(suggestionList, keyword);
  }
}

class ListWidget extends StatefulWidget {
  const ListWidget({
    super.key,
    required this.suggestionsList,
    required this.query,
  });

  final List<String> suggestionsList;
  final String query;

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  late List<String> filteredList;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    filterList();
  }

  @override
  void didUpdateWidget(ListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.query != oldWidget.query) {
      filterList();
    }
  }

  void filterList() {
    filteredList = widget.suggestionsList
        .where(
            (item) => item.toLowerCase().contains(widget.query.toLowerCase()))
        .toList();

    if (filteredList.isNotEmpty) {
      if (filteredList.isNotEmpty) {
        WidgetsBinding.instance
            .addPostFrameCallback((_) => scrollToFirstMatch());
      }
    }
  }

  void scrollToFirstMatch() {
    int index = widget.suggestionsList.indexOf(filteredList.first);
    if (index != -1 && scrollController.hasClients) {
      scrollController.animateTo(
        index * 32.0, // Assuming each item has a height of 32
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final String suggestionText = filteredList[index];
        return ListTile(
          title: RichText(
            text: highlightMatch(suggestionText, widget.query),
          ),
          onTap: () {
            // Your onTap functionality here
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }

  TextSpan highlightMatch(String text, String query) {
    if (query.isEmpty || !text.toLowerCase().contains(query.toLowerCase())) {
      return TextSpan(
        text: text,
        style: const TextStyle(color: Colors.black),
      );
    }

    List<TextSpan> spans = [];
    int start = 0;
    int indexOfHighlight = text.toLowerCase().indexOf(query.toLowerCase());

    while (indexOfHighlight != -1) {
      spans.add(TextSpan(
        text: text.substring(start, indexOfHighlight),
        style: const TextStyle(color: Colors.black),
      ));
      spans.add(TextSpan(
        text: text.substring(indexOfHighlight, indexOfHighlight + query.length),
        style: const TextStyle(
            backgroundColor: Colors.yellow, color: Colors.black),
      ));

      start = indexOfHighlight + query.length;
      indexOfHighlight = text.toLowerCase().indexOf(query.toLowerCase(), start);
    }

    spans.add(TextSpan(
      text: text.substring(start),
      style: const TextStyle(color: Colors.black),
    ));
    return TextSpan(children: spans);
  }
}
