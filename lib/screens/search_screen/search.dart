import 'package:flutter/material.dart';
import 'package:joy_homes/screens/screen_constants.dart';
import 'package:joy_homes/theme.dart';

final List<String> imgList = [
  'https://cdn.pixabay.com/photo/2016/11/18/17/46/house-1836070_1280.jpg',
  'https://cdn.pixabay.com/photo/2016/11/18/17/20/living-room-1835923_1280.jpg',
  'https://cdn.pixabay.com/photo/2015/10/20/18/57/furniture-998265_1280.jpg',
  'https://cdn.pixabay.com/photo/2017/08/27/10/16/interior-2685521_1280.jpg',
  'https://cdn.pixabay.com/photo/2016/12/30/07/59/kitchen-1940174_1280.jpg',
  'https://cdn.pixabay.com/photo/2016/12/30/07/59/kitchen-1940174_1280.jpg',
  'https://cdn.pixabay.com/photo/2016/12/30/07/59/kitchen-1940174_1280.jpg',
  'https://cdn.pixabay.com/photo/2016/12/30/07/59/kitchen-1940174_1280.jpg',
  'https://cdn.pixabay.com/photo/2016/12/30/07/59/kitchen-1940174_1280.jpg',
  'https://cdn.pixabay.com/photo/2016/12/30/07/59/kitchen-1940174_1280.jpg',
  'https://cdn.pixabay.com/photo/2016/12/30/07/59/kitchen-1940174_1280.jpg',
  'https://cdn.pixabay.com/photo/2016/12/30/07/59/kitchen-1940174_1280.jpg',
  'https://cdn.pixabay.com/photo/2014/07/10/17/17/bedroom-389254_1280.jpg'
];

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          preferredSize1: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.secondary.withOpacity(0.4),
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              'Search',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          height: 60),
      body: SearchScreenDetails(),
    );
  }
}

class SearchScreenDetails extends StatefulWidget {
  const SearchScreenDetails({super.key});

  @override
  State<SearchScreenDetails> createState() => _SearchScreenDetailsState();
}

class _SearchScreenDetailsState extends State<SearchScreenDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 47,
                margin: const EdgeInsets.only(
                    left: 25, top: 30, bottom: 30, right: 0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.secondary,
                    width: 0.6,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  style:
                      const TextStyle(fontSize: 16, color: AppColors.textColor),
                  cursorColor: AppColors.primary,
                  cursorHeight: 20,
                  cursorWidth: 1,
                  decoration: InputDecoration(
                      prefix: const SizedBox(
                        width: 20,
                      ),
                      hintText: '2 bedroom apartment?',
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon:
                            const Icon(Icons.search, color: AppColors.primary),
                        onPressed: () {},
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                iconSize: 40,
                icon: const Icon(Icons.more_vert,
                    color: Color.fromARGB(255, 115, 57, 16)),
                onPressed: () {},
              ),
            )
          ],
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: imgList.length,
              // ignore: non_constant_identifier_names
              itemBuilder: (BuildContext, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: NetworkImage(imgList[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
