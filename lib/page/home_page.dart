import 'package:flutter/material.dart';
import 'package:my_photo/page/search_result_page.dart';
import 'package:my_photo/providers.dart';

class HomePage extends StatelessWidget{

  static const routeName = '/';

  final _searchTermController = TextEditingController();

  HomePage({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox( //박스의 최대 크기, 최소 크기 정할 수 있어
          constraints: const BoxConstraints(
            minWidth: 240,
            maxWidth: 600,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _searchTermController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0 ),
                ElevatedButton(
                    onPressed: (){
                      final searchTerm = _searchTermController.text.trim(); //trim() 공백 제거
                      Navigator.pushNamed(context, SearchResultPage.routeName, arguments: searchTerm);
                      analyticsService().search(searchTerm);
                      _searchTermController.text = ''; //다시 검색하기 위해서 초기화
                    },
                    child: const Text("검색")
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}