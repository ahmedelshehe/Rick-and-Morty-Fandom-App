import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/business_logic/global_cubit/global_cubit.dart';
import 'package:rick_and_morty/constants/strings.dart';
import 'package:rick_and_morty/presentation/widgets/cached_network_image.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../widgets/default_text.dart';

class EpisodesScreen extends StatefulWidget {
  EpisodesScreen({Key? key}) : super(key: key);

  @override
  State<EpisodesScreen> createState() => _EpisodesScreenState();
}

class _EpisodesScreenState extends State<EpisodesScreen> {
  late GlobalCubit cubit;
  int getSeasonNumber(int episode){
    if(episode >=1 && episode <=11){
      return 1;
    }else if(episode > 11 && episode <= 21){
      return 2;
    }else if(episode > 21 && episode <= 31){
      return 3;
    }else if(episode > 31 && episode <= 41){
      return 4;
    }else if(episode > 41 && episode <= 51){
      return 5;
    }else if(episode > 51 && episode <= 61){
      return 6;
    }else {
      return 0;
    }
  }
  @override
  void initState() {
    cubit = GlobalCubit.get(context);
    cubit.getAllEpisodes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(cubit.episodes.length);
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        if (state is EpisodesLoadedState ||
            state is GlobalChangeBottomNavBarState &&
                cubit.episodes.length != 0) {
          return ListView.builder(
            itemBuilder: (context, index) => Container(
              width: 90.w,
              margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: myBlue.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Stack(
                    children:[
                      Container(
                          color: myGrey,
                          child: cubit.episodes.elementAt(index).stillPath != ''
                              ? FadeInImage.assetNetwork(
                              width: double.infinity,
                              height: 30.h,
                              fit: BoxFit.cover,
                              placeholder: 'assets/images/loading.gif',
                              image: imagesBaseURL +
                                  cubit.episodes.elementAt(index).stillPath)
                              : Image.asset('assets/images/placeholder.jpg')),

                      Positioned(
                        top:30.sp,
                        left: 10.sp,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 1.h),
                          decoration: BoxDecoration(
                            color: myBlue.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(5.sp),
                          ),
                          child: Text(
                            'Episode '+cubit.episodes.elementAt(index).episodeNumber.toString(),
                            style: TextStyle(
                                color: myYellow,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 9.sp,
                        left: 5.sp,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 1.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.sp),
                          ),
                          child: Text(
                            'Season ${cubit.episodes.elementAt(index).seasonNumber}',
                            style: TextStyle(
                                color: myYellow,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ] ,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cubit.episodes.elementAt(index).name,
                      style: TextStyle(
                        color: myYellow,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            ),
            itemCount: cubit.episodes.length,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
