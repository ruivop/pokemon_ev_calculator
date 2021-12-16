import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_stats_calculator/data/pokemons.dart';
import 'package:pokemon_stats_calculator/generated/l10n.dart';

class PokemonSearchPage extends StatefulWidget {
  final void Function(Species) onSelect;
  const PokemonSearchPage({
    Key? key,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<PokemonSearchPage> createState() => _PokemonSearchPageState();
}

class _PokemonSearchPageState extends State<PokemonSearchPage> {
  List<Species> searchResults = [];
  FocusNode searchFocusNode = FocusNode();
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    searchResults = allSpecies.entries.map((e) => e.value).toList();
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Row(
          children: [
            Expanded(
                child: Container(
              height: 40,
              alignment: Alignment.center,
              child: TextField(
                maxLines: 1,
                autofocus: true,
                focusNode: searchFocusNode,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0.0),
                  border: const OutlineInputBorder(),
                  hintText: S.of(context).pokemonSelectorTitle,
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                ),
                onChanged: (String value) {
                  setState(() {
                    searchResults = allSpecies.entries
                        .where((e) =>
                            e.value.name
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            e.value.number.toString().contains(value) ||
                            (e.value.variantName != null &&
                                e.value.variantName!
                                    .toLowerCase()
                                    .contains(value.toLowerCase())))
                        .map((e) => e.value)
                        .toList();
                  });
                },
              ),
            )),
          ],
        ),
      ),
      body: GestureDetector(
        onTapDown: (_) {
          if (searchFocusNode.hasFocus) searchFocusNode.unfocus();
          //FocusScope.of(context).requestFocus(FocusNode());
        },
        onPanDown: (_) {
          if (searchFocusNode.hasFocus) searchFocusNode.unfocus();
        },
        child: Container(
          color: Colors.transparent,
          child: DraggableScrollbar.semicircle(
            controller: scrollController,
            labelTextBuilder: (offset) {
              final int currentItem = scrollController.hasClients
                  ? (scrollController.offset /
                          scrollController.position.maxScrollExtent *
                          searchResults.length)
                      .floor()
                  : 0;

              return Text("$currentItem");
            },
            labelConstraints:
                const BoxConstraints.tightFor(width: 80.0, height: 30.0),
            child: ListView.separated(
              controller: scrollController,
              itemCount: searchResults.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) => ListTile(
                leading: SizedBox(
                    width: 25,
                    child: Center(child: Text(searchResults[index].number))),
                title: Text(searchResults[index].name),
                subtitle: searchResults[index].variantName == null
                    ? null
                    : Text(searchResults[index].variantName!),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle,
                        color: searchResults[index].getColorType1()),
                    if (searchResults[index].type1 !=
                        searchResults[index].type2)
                      Icon(Icons.circle,
                          color: searchResults[index].getColorType2()),
                  ],
                ),
                onTap: () {
                  widget.onSelect(searchResults[index]);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
