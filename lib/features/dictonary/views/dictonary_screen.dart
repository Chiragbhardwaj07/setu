import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vasu/shared/constants/app_colors.dart';

import 'package:vasu/features/text_to_speech/utils/utils.dart' as utils;
import 'package:vasu/shared/constants/app_proportions.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  // String _text = '';
  String _img = 'space';
  String _ext = '.png';
  String _path = 'assets/letters/';
  // ignore: unused_field
  int _state = 0;
  // ignore: unused_field
  String _displaytext = 'Press the button and start speaking...';
  String _searchQuery = ''; // Search query variable

  final List<String> dictionaryLetters =
      List.generate(26, (index) => String.fromCharCode(index + 65));
  final List<String> numbers =
      List.generate(100, (index) => (index + 1).toString());
  final List<String> commonWords = ['hello', 'world', 'flutter', 'dart'];

  int _selectedTabIndex = 0;
  TextEditingController _searchController = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  FocusNode _SearchFocusNode = FocusNode();

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
      _searchQuery = '';
      _searchController.clear();
    });
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              expandedHeight: AppProportions.screenHeight * 0.5,
              titleSpacing: 2,
              floating: false,
              pinned: true,
              title: Text(
                "Dictionary",
                style: Theme.of(context).primaryTextTheme.bodyLarge,
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  '$_path$_img$_ext',
                  fit: BoxFit.contain,
                ),
              ),
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.translate),
                  onPressed: () {},
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      focusNode: _SearchFocusNode,
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).colorScheme.surface,
                        filled: true,
                        labelText: 'Search Your word'.tr,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: Icon(Icons.clear_rounded),
                            onPressed: () {
                              setState(() {
                                _searchQuery = '';
                                _searchController.clear();
                              });
                            },
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              _SearchFocusNode.unfocus();
                              FocusScope.of(context).unfocus();
                            },
                          ),
                        ),
                        border: OutlineInputBorder(),
                        labelStyle: GoogleFonts.mulish(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildTabButton("A to Z", 0),
                        _buildTabButton("0 to 100", 1),
                        _buildTabButton("Common Word", 2),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTabContent(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    return GestureDetector(
      onTap: () => _onTabSelected(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: _selectedTabIndex == index
              ? AppColors.PrimaryColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: _selectedTabIndex == index
                ? Colors.white
                : AppColors.PrimaryColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void translation(String text) async {
    _displaytext = '';
    String speechStr = text.toLowerCase();

    List<String> strArray = speechStr.split(" ");
    for (String content in strArray) {
      if (utils.words.contains(content)) {
        String file = content;
        int idx = utils.words.indexOf(content);
        int duration = int.parse(utils.words.elementAt(idx + 1));
        setState(() {
          _state += 1;
          _displaytext += content;
          _path = 'assets/ISL_Gifs/';
          _img = file;
          _ext = '.gif';
        });
        await Future.delayed(Duration(milliseconds: duration));
      } else {
        for (var i = 0; i < content.length; i++) {
          if (utils.letters.contains(content[i])) {
            String char = content[i];
            setState(() {
              _state += 1;
              _displaytext += char;
              _path = 'assets/letters/';
              _img = char;
              _ext = '.png';
            });
            await Future.delayed(const Duration(milliseconds: 1500));
          }
        }
      }
      setState(() {
        _state += 1;
        _displaytext += " ";
        _path = 'assets/letters/';
        _img = 'space';
        _ext = '.png';
      });
      await Future.delayed(const Duration(milliseconds: 1000));
    }
  }

  Widget _buildTabContent() {
    if (_selectedTabIndex == 0) {
      return _buildAToZGrid();
    } else if (_selectedTabIndex == 1) {
      return _buildZeroToHundredGrid();
    } else {
      return _buildCommonWordsList();
    }
  }

  Widget _buildAToZGrid() {
    final filteredLetters = dictionaryLetters
        .where((letter) =>
            letter.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: filteredLetters.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        final letter = filteredLetters[index];
        return _buildGridTile(letter);
      },
    );
  }

  Widget _buildZeroToHundredGrid() {
    final filteredNumbers =
        numbers.where((number) => number.contains(_searchQuery)).toList();

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: filteredNumbers.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        final number = filteredNumbers[index];
        return _buildGridTile(number);
      },
    );
  }

  Widget _buildCommonWordsList() {
    final filteredWords = commonWords
        .where(
            (word) => word.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Column(
      children: filteredWords
          .map((word) => GestureDetector(
                onTap: () {
                  translation(word);
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: ListTile(title: Text(word)),
              ))
          .toList(),
    );
  }

  Widget _buildGridTile(String text) {
    return GestureDetector(
      onTap: () {
        translation(text);
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
        ),
      ),
    );
  }
}
