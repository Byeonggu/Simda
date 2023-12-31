import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simda/models/UserDto.dart';
import 'package:simda/providers/feed_providers.dart';
import 'models/FeedDto.dart';

class WritePage extends StatefulWidget {
  const WritePage({super.key});

  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  bool _isLoading = false;
  int selected = -1;
  XFile? _image;
  final ImagePicker picker = ImagePicker();
  String _title = '';
  String _content = '';

  final _titleEditController = TextEditingController();
  final _contentEditController = TextEditingController();
  FeedProviders feedProvider = FeedProviders();

  void _showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  void _hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path);
      });
    }
  }

  Future<void> _analyzeImage() async {
    // 가상의 3초 대기 시간을 표현하기 위해 Future.delayed 사용
    _showLoading();
    await Future.delayed(Duration(seconds: 3));
    _hideLoading();

    // 분석 결과에 따라 이미지 선택
    // 이 부분은 실제 분석 결과에 따라서 결과값을 설정해야 합니다.
    // 예시로 selected 변수에 따라 결과값 설정
    if (selected >= 0 && selected <= 4) {
      _showResultAlertDialog(selected);
    }
  }

  void _showResultAlertDialog(int result) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('분석 결과'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/flower$result.png',
              width: 40,
              height: 40,
            ),
            SizedBox(height: 10),
            Text('결과값: $result'),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                SizedBox(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    iconSize: 28,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '글 작성하기',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          showDialog<String>(
                            context: context,
                            builder: (context) => StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return AlertDialog(
                                title: const Text(
                                  '나의 감정은?',
                                  style: TextStyle(),
                                  textAlign: TextAlign.center,
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(height: 2, color: Colors.purple),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selected = 0;
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 5, 5, 5),
                                            width: 65,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(5)),
                                              color: selected == 0
                                                  ? Colors.black12
                                                  : Colors.transparent,
                                            ),
                                            child: const Column(
                                              children: [
                                                Image(
                                                    image: AssetImage(
                                                        'assets/images/flower0.png')),
                                                SizedBox(height: 5),
                                                Text('행복')
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selected = 1;
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 5, 5, 5),
                                            width: 65,
                                            // color: _colors[1],
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(5)),
                                              color: selected == 1
                                                  ? Colors.black12
                                                  : Colors.transparent,
                                            ),
                                            child: const Column(
                                              children: [
                                                Image(
                                                    image: AssetImage(
                                                        'assets/images/flower1.png')),
                                                SizedBox(height: 5),
                                                Text('신남')
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selected = 2;
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 5, 5, 5),
                                            width: 65,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(5)),
                                              color: selected == 2
                                                  ? Colors.black12
                                                  : Colors.transparent,
                                            ),
                                            child: const Column(
                                              children: [
                                                Image(
                                                    image: AssetImage(
                                                        'assets/images/flower2.png')),
                                                SizedBox(height: 5),
                                                Text('평온')
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selected = 3;
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 5, 5, 5),
                                            width: 65,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(5)),
                                              color: selected == 3
                                                  ? Colors.black12
                                                  : Colors.transparent,
                                            ),
                                            child: const Column(
                                              children: [
                                                Image(
                                                    image: AssetImage(
                                                        'assets/images/flower3.png')),
                                                SizedBox(height: 5),
                                                Text('화남')
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selected = 4;
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 5, 5, 5),
                                            width: 65,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(5)),
                                              color: selected == 4
                                                  ? Colors.black12
                                                  : Colors.transparent,
                                            ),
                                            child: const Column(
                                              children: [
                                                Image(
                                                    image: AssetImage(
                                                        'assets/images/flower4.png')),
                                                SizedBox(height: 5),
                                                Text('슬픔')
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 5, 5, 5),
                                          width: 65,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                      ],
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      setState(() {});
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('저장하기'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {});
                                      _analyzeImage();
                                    },
                                    child: const Text('작성완료'),
                                  ),
                                ],
                              );
                            }),
                          );
                        },
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStatePropertyAll(Colors.blue.shade200)),
                        child: const Text(
                          '작성하기',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            Container(height: 2, color: Colors.purple),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleEditController,
                      maxLines: null,
                      style: const TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                      cursorColor: Colors.black12,
                      cursorWidth: 1.0,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        hintText: '제목을 입력하세요',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 0.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 0.0,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (text) {
                        _title = text;
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      height: 1,
                      color: Colors.black54,
                    ),
                    TextField(
                      controller: _contentEditController,
                      maxLines: null,
                      style: const TextStyle(fontSize: 16.0, height: 1.5),
                      cursorColor: Colors.black12,
                      cursorWidth: 1.0,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                        hintText: '내용을 입력하세요',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 0.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 0.0,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (text) {
                        _content = text;
                      },
                    ),
                    _buildImageArea(),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomSheet: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.black12,
                    width: 1,
                  ),
                ),
              ),
              width: double.infinity,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image_outlined),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageArea() {
    return _image != null
        ? Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 60),
      width: 300,
      height: 300,
      child: Stack(
        children: [
          Image.file(File(_image!.path)),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
          if (selected >= 0 && selected <= 4)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 50,
                color: Colors.grey.withOpacity(0.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/flower$selected.png',
                      width: 20,
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    )
        : Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 60),
      width: 300,
      height: 300,
      color: Colors.red,
    );
  }

  @override
  void dispose() {
    _titleEditController.dispose();
    _contentEditController.dispose();
    super.dispose();
  }
}
