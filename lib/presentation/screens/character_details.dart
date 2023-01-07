import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../data/models/character.dart';
import '../widgets/detail_tile.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);
  final Character character;

  @override
  Widget build(BuildContext context) {
    List episodes = character.episodes
        .map((episode) => episode.toString().substring(
            episode.toString().lastIndexOf('/') + 1, episode.toString().length))
        .toList();
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Scaffold(
      backgroundColor: myBlue,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            pinned: true,
            backgroundColor: myBlue,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  character.name,
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              background: Hero(
                tag: 'img${character.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                  child: Image.network(
                    character.image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                ),
              ),
            ),
            centerTitle: true,
          ),
          //3
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                return Container(
                  color: myBlue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                      ),
                      DetailTile(title: 'Gender', text: character.gender),
                      DetailTile(title: 'Status', text: character.status),
                      DetailTile(title: 'Origin', text: character.originName),
                      DetailTile(
                          title: 'Location', text: character.locationName),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: myYellow,
                        ),
                        child: Theme(
                          data: theme,
                          child: ExpansionTile(
                            title: Text(
                              'Episodes',
                              style: TextStyle(
                                color: myBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            controlAffinity: ListTileControlAffinity.platform,
                            backgroundColor: myYellow,
                            collapsedTextColor: myBlue,
                            collapsedBackgroundColor: myYellow,
                            initiallyExpanded: false,
                            expandedAlignment: Alignment.center,
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.center,
                            textColor: myBlue,
                            children: [
                              GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  childAspectRatio: 4 / 4,
                                  crossAxisSpacing: 1,
                                  mainAxisSpacing: 1,
                                ),
                                primary: true,
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: episodes.length,
                                itemBuilder: (context, index) {
                                  return MaterialButton(
                                    color: myYellow,
                                    onPressed: () {},
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                            child: Text(
                                          'Episode ${episodes[index]}',
                                          style: TextStyle(
                                              color: myGrey,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        )),
                                      ],
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
