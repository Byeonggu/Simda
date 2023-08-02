import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../followers_list.dart';
import 'following_list.dart';
import 'package:simda/profile_edit_page.dart';

import 'main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  // viewModel.user?.kakaoAccount?.profile?.profileImageUrl ?? '');

  String? _nickname = viewModel.user?.kakaoAccount?.profile?.nickname;
  String _bio = "노는게 제일 좋아";
  String? _pickedFile = viewModel.user?.kakaoAccount?.profile?.profileImageUrl;

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width / 4;

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _nickname!,
                    style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(onPressed: () {},
                    icon: const Icon(Icons.menu), iconSize: 28,
                  ),
                ],
              ),
            ),
            Container(height: 2, color: Colors.purple),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _navigateToProfileEditPage(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    constraints: BoxConstraints(
                      minHeight: imageSize,
                      minWidth: imageSize,
                    ),
                    child: _pickedFile == null
                        ? Center(
                            child: Icon(
                              Icons.account_circle,
                              size: imageSize,
                            ),
                          )
                        : Center(
                            child: Container(
                              width: imageSize,
                              height: imageSize,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                image: DecorationImage(
                                  image: FileImage(File(_pickedFile!)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _navigateToFollowingListPage(
                                  context); // 팔로잉 숫자를 누르면 팔로잉 목록 페이지로 이동
                            },
                            child: createColumns('following', 1120),
                          ),
                          GestureDetector(
                            onTap: () {
                              _navigateToFollowersListPage(
                                  context); // 팔로워 숫자를 누르면 팔로워 목록 페이지로 이동
                            },
                            child: createColumns('followers', 12000),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    children: [
                      Text(
                        _nickname!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _navigateToProfileEditPage(context);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                _bio,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              alignment: Alignment.center,
              child: const Image(image: AssetImage('assets/images/promap.PNG')),
            )
          ],
        ),
      ),
    );
  }

  void _navigateToProfileEditPage(BuildContext context) async {
    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileEditPage(
          nickname: _nickname!,
          bio: _bio,
          pickedFile: _pickedFile,
        ),
      ),
    );

    if (updatedData != null) {
      setState(() {
        _nickname = updatedData['nickname'];
        _bio = updatedData['bio'];
        _pickedFile = updatedData['pickedFile'];
      });
    }
  }

  void _navigateToFollowingListPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const FollowingListPage(), // FollowingListPage는 팔로잉 목록을 보여주는 새로운 페이지입니다.
      ),
    );
  }

  void _navigateToFollowersListPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const FollowersListPage(), // FollowersListPage는 팔로워 목록을 보여주는 새로운 페이지입니다.
      ),
    );
  }

  Column createColumns(String title, int count) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$count',
          style: const TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.black45,
                fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }
}
