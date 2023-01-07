import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/business_logic/characters_cubit.dart';
import 'package:rick_and_morty/business_logic/global_cubit/global_cubit.dart';
import 'package:rick_and_morty/constants/colors.dart';
import 'package:rick_and_morty/presentation/widgets/character_item.dart';

import '../../data/models/character.dart';
import 'episodes_screen.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late CharactersCubit cubit;
  late GlobalCubit globalCubit;
  late List<Character> allCharacters;
  late List<Character> searchCharacters;
  late ScrollController _controller;
  late TextEditingController _textEditingController;
  late int page;
  incrementPage() {
    page++;
  }

  @override
  void initState() {
    super.initState();
    cubit = CharactersCubit.get(context);
    globalCubit =GlobalCubit.get(context);
    _controller = ScrollController();
    _controller.addListener(_myScrollListener);
    _textEditingController = TextEditingController();
    page = 1;
    allCharacters = cubit.getAllCharacters(page);
    searchCharacters = cubit.searchedCharacters;

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        return Scaffold(
          appBar: cubit.isSearch && globalCubit.currentIndex ==0  ? buildSearchAppBar() : buildAppBar(),
          body: globalCubit.currentIndex ==0 ? buildBlocWidget() : EpisodesScreen() ,
          floatingActionButton: Visibility(
            visible: globalCubit.currentIndex ==0,
            child: FloatingActionButton(
              child: Icon(
                Icons.arrow_circle_up,
                color: myYellow,
              ),
              backgroundColor: myBlue,
              onPressed: () {
                _controller.jumpTo(0);
              },
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: globalCubit.currentIndex,
            onTap: (index){globalCubit.changeIndex(index);},
            iconSize: 35,
            backgroundColor: myBlue,
            unselectedFontSize: 16,
            unselectedItemColor: myGrey,
            selectedItemColor: myYellow,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.person),label:'Characters'),
              BottomNavigationBarItem(icon: Icon(Icons.movie),label:'Episodes' ),
            ],
          ),
        );
      },
    );

  }

  AppBar buildSearchAppBar() {
    return AppBar(
      toolbarHeight: 100,
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                cubit.isSearch = false;
                _textEditingController.clear();
                cubit.searchedCharacters=[];
              });
            },
            icon: Icon(
              Icons.close,
              color: myYellow,
            ))
      ],
      title: BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
          return TextFormField(
            maxLength: 20,
            controller: _textEditingController,
            cursorColor: myYellow,
            maxLines: 1,
            textInputAction: TextInputAction.search,
            validator: (searched){
              if(searched!.length<=2 ){{
                return 'Type more than two characters';
              }}else {
                return '';
              }
            },
            decoration: InputDecoration(
                labelText: 'Search Character',
                labelStyle: TextStyle(color: myYellow, fontSize: 20),
                prefixIcon: Icon(
                  Icons.search,
                  color: myYellow,
                ),
                errorStyle: TextStyle(color: myYellow,fontSize: 16),
                border: InputBorder.none),
            style: TextStyle(
                color: myYellow,
                fontStyle: FontStyle.normal,
                decoration: TextDecoration.none,
                fontSize: 20),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (searched) {
              if (searched.length >= 3) {
                cubit.isSearch = true;
                cubit.searchedName = searched;
                cubit.searchCharacter();
              } else if(searched.length ==0) {
                cubit.isSearch =false;
                cubit.searchedCharacters = [];
              }
            },
          );
        },
      ),
      backgroundColor: myBlue,
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title:  Text(
        globalCubit.titles.elementAt(globalCubit.currentIndex),
        style: TextStyle(color: myYellow),
      ),
      centerTitle: true,
      backgroundColor: myBlue,
      actions: [
        Visibility(
          visible: GlobalCubit.get(context).currentIndex ==0,
          child: IconButton(
              onPressed: () {
                setState(() {
                  cubit.isSearch = !cubit.isSearch;
                });
              },
              icon: Icon(Icons.search)),
        )
      ],
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
          if (state is CharacterLoaded) {
            allCharacters = state.characters;
            return buildLoadedListWidgets();
          } else if (state is SearchLoaded) {
            searchCharacters = state.characters;
            return buildLoadedListWidgets();
          } else {
            return showLoadingIndicator();
          }
        });
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      controller: _controller,
      child: Container(
        color: myBlue,
        child: Column(
          children: [
            cubit.isSearch &&
                cubit.searchedCharacters.length == 0
                ? buildNoResultsContainer()
                : buildCharactersList(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Visibility(
                  visible: allCharacters.length != 826 && !cubit.isSearch,
                  child: showLoadingIndicator()),
            )
          ],
        ),
      ),
    );
  }

  Container buildNoResultsContainer() {
    return Container(
        padding: EdgeInsets.all(15),
        height: 200 ,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search,color: myYellow,size: 60,),
            Text('No results Found',style: TextStyle(fontSize:25,color: myYellow, ),textAlign: TextAlign.center,),
            Visibility(visible: _textEditingController.text.length<=2,child: Text('Try to Type more than two characters',style: TextStyle(fontSize:16,color: myYellow, ),textAlign: TextAlign.center,)),
            Visibility(visible: _textEditingController.text.length>=2,child: Text('But i am sure the creators is working on this (${_textEditingController.text}) character',style: TextStyle(fontSize:12,color: myYellow, ),textAlign: TextAlign.center,)),
          ],
        )
    );
  }


  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount:
      cubit.isSearch ? searchCharacters.length : allCharacters.length,
      itemBuilder: (context, index) {
        return CharacterItem(
          character:
          cubit.isSearch ? searchCharacters[index] : allCharacters[index],
        );
      },
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: myYellow,
      ),
    );
  }

  _myScrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent-1 &&
        !_controller.position.outOfRange &&
        !cubit.isSearch ) {
      incrementPage();
      allCharacters =
          BlocProvider.of<CharactersCubit>(context).getAllCharacters(page);
    }
  }
}
