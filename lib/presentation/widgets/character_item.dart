import 'package:flutter/material.dart';
import 'package:rick_and_morty/constants/colors.dart';

import '../../constants/strings.dart';
import '../../data/models/character.dart';

class CharacterItem extends StatelessWidget {
  final Character character;
  const CharacterItem({Key? key, required this.character}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.all(4),
      decoration:  BoxDecoration(
        color:myYellow,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap:(){
          Navigator.of(context).pushNamed(characterDetailsScreen,arguments: character);
        },
        child: GridTile(
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            color: Colors.black54,
            alignment: Alignment.center,
            child: Text(
              character.name,
              style:const TextStyle(
                height: 1.3,
                fontSize: 16,
                color: myWhite,
                fontWeight: FontWeight.bold
              ) ,
            overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          child: Container(
            color: myGrey,
            child: character.image.isNotEmpty ?
            Hero(
             tag: 'img${character.id}',
              child: FadeInImage.assetNetwork(
                width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: 'assets/images/loading.gif',
                  image:character.image ),
            ):
                Image.asset('assets/images/placeholder.jpg')
            ,
          ),
        ),
      ),
    );
  }
}
