import 'dart:async';
import 'package:flutter/material.dart';

import '../values/values.dart';

class SearchBar extends StatefulWidget {
  final ValueChanged<String> onSearch;
  final ValueChanged? onClose;
  const SearchBar({Key? key, required this.onSearch,required this.onClose}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  bool showSearch = false;

  void _onChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onSearch(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: showSearch ? screenWidth * 0.7 : 0,
          curve: Curves.easeInSine,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Search user name or id",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
                onChanged: (searchStr) {
                 _onChanged(searchStr);
                }
            ),
          ),
        ),
        const SizedBox(height: 8),
        FloatingActionButton(
          mini: true,
          tooltip: 'Search User',
          backgroundColor: buttonColour,
          onPressed: () {
            setState(() {
              showSearch = !showSearch;
            });
           widget.onClose!(showSearch);
          },
          child: Icon(showSearch ? Icons.clear : Icons.search),
        ),
      ],
    );
  }
}