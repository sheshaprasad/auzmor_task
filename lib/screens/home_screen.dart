import 'dart:collection';
import 'dart:math';

import 'package:auzmor_task/utils/assets.dart';
import 'package:auzmor_task/utils/text_styles.dart';
import 'package:auzmor_task/widgets/image_tile.dart';
import 'package:auzmor_task/widgets/training_list_tile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/training_data.dart';
import '../widgets/filter_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  /// Repo List that holds the data for the listview
  List<TrainingData> trainingDataListRepo = [];
  /// Display list which will contain the data from Repo list based on query (i.e filter)
  List<TrainingData> trainingDataList = [];
  /// UI Notifier for list view update
  ValueNotifier<bool> notifyList = ValueNotifier(false);
  /// Carousel Controller
  CarouselController carouselController = CarouselController();


  ///Loading Training Data to Repo [trainingDataListRepo] and cloning it to Display list [trainingDataList]
  getData(){
    trainingDataListRepo = generateRandomTrainingData(numData: Random().nextInt(20));
    trainingDataList.addAll(trainingDataListRepo);
  }
  @override
  void initState() {
    super.initState();
    getData();
  }

  ///Filtering based on location selected by user
  ///Clearing the Display List and querying the Repo list with selected filters
  ///Data from [locationList] [trainingList] [trainerList] are all combined
  ///Notifying the listener [notifyList] so the UI gets updated
  filterApply(){
    trainingDataList.clear();

    if(locationList.isEmpty && trainingList.isEmpty && trainerList.isEmpty){
      trainingDataList.addAll(trainingDataListRepo);
      notifyList.value = !notifyList.value;
      return;
    }

    if(locationList.isNotEmpty){
      for(String val in locationList) {
        mergeList(trainingDataListRepo.where((element) =>
            element.location.contains(val)).toList());
      }
    }
    if(trainingList.isNotEmpty){
      for(String val in trainingList) {
        mergeList(trainingDataListRepo.where((element) =>
            element.name.contains(val)).toList());
      }
    }
    if(trainerList.isNotEmpty){
      for(String val in trainerList) {
        mergeList(trainingDataListRepo.where((element) =>
            element.trainerName.contains(val)).toList());
      }
    }
    notifyList.value = !notifyList.value;
  }

  ///Used to merge the list from filter to ensure that there are no duplicate data
  mergeList(List<TrainingData> list){
    for(TrainingData data in list){
      if(!trainingDataList.contains(data)){
        trainingDataList.add(data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white.withOpacity(0.9),
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: size.height * 0.45,
                  floating: false,
                  backgroundColor: Colors.red,
                  forceElevated: innerBoxIsScrolled,
                  pinned: true,
                  actions: [
                    InkWell(
                      onTap: (){
                        trainingDataListRepo.clear();
                        trainingDataList.clear();
                        getData();
                        setState(()=>{});
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 12),
                          child: Icon(Icons.menu, color: Colors.white,)
                      ),
                    )
                  ],
                  title: Text("Training"),
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.all( 8),
                    background: Container(
                      child: Stack(
                        children: [
                          Positioned(
                            top: size.height * 0.06,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(12),
                              color: Colors.red,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Text("Highlights", style: CustomTextStyles.subHeadingTextStyle),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                              top: size.height*0.25,
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(12),
                                color: Colors.white,
                                alignment: Alignment.bottomLeft,
                              )
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      carouselController.previousPage();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 8),
                                        color: Colors.grey,
                                        child: const RotatedBox(
                                          quarterTurns: 2,
                                            child: Icon(Icons.play_arrow_rounded, color: Colors.white,)
                                        )
                                    ),
                                  ),
                                  Expanded(
                                    child: CarouselSlider(
                                      carouselController: carouselController,
                                      options: CarouselOptions(
                                        autoPlay: true,
                                        aspectRatio: 3,
                                        enlargeCenterPage: true,
                                      ),
                                      items: trainingDataList.map((trainingData) => TrainingImageTile(trainingData)).toList(),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      carouselController.nextPage();
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(left: 8),
                                        color: Colors.grey,
                                        child: Icon(Icons.play_arrow_rounded, color: Colors.white,)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size(size.width, kToolbarHeight),
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: (){
                          openFilter();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black87, width: 0.5),
                              borderRadius: BorderRadius.all(Radius.circular(8.0))
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(Assets.filterIcon, height: 14, width: 14, color: Colors.grey,),
                              SizedBox(width: 4,),
                              Text("Filter", style: TextStyle(fontSize: 12, color: Colors.grey),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Container(
              padding: EdgeInsets.all(24),
              child: ValueListenableBuilder(
                valueListenable: notifyList,
                builder: (_, nl, __) {
                  return ListView.builder(
                    itemCount: trainingDataList.length,
                      itemBuilder: (cts, ind){
                        return SizedBox(
                            child: TrainingListTile(trainingDataList[ind]));
                      }
                  );
                }
              )
            )
          ),
        ),
    );
  }

  List<String> locationList = [], trainingList = [], trainerList = [];

  ///Filter Bottom Sheet
  openFilter(){

    List<String> locationListTemp = [], trainingListTemp = [], trainerListTemp = [];

    locationListTemp.addAll(locationList);
    trainingListTemp.addAll(trainingList);
    trainerListTemp.addAll(trainerList);

    ValueNotifier<int> selected = ValueNotifier(1);
    showModalBottomSheet(
      context: context,
      //elevates modal bottom screen
      elevation: 10,
      isScrollControlled: true,
      // gives rounded corner to modal bottom screen
      backgroundColor: Colors.white.withOpacity(0.98),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        // UDE : SizedBox instead of Container for whitespaces

        ///To check if the data in the filter is already selected by user
        checkExists(val){
          if(selected.value == 1){
            return locationListTemp.contains(val);
          }else if(selected.value == 2){
            return trainingListTemp.contains(val);
          }else{
            return trainerListTemp.contains(val);
          }
        }

        /// To remove the selected value from filter query
        removeSelected(val){
          if(selected.value == 1){
            locationListTemp.remove(val);
          }else if(selected.value == 2){
            trainingListTemp.remove(val);
          }else{
            trainerListTemp.remove(val);
          }
        }

        /// To add the selected value to filter for query
        addSelected(val){
          if(selected.value == 1){
            locationListTemp.add(val);
          }else if(selected.value == 2){
            trainingListTemp.add(val);
          }else{
            trainerListTemp.add(val);
          }
        }

        return Container(
          child: ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(24),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(child: Text("Sort and Filter", style: CustomTextStyles.headingTextStyle.copyWith(color: Colors.black, fontWeight: FontWeight.bold),)),
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close), color: Colors.black,
                      )
                    ],
                  ),
                ),
                Divider(height: 0, thickness: 1.5,),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: ValueListenableBuilder(
                        valueListenable: selected,
                        builder: (_, sel, __){
                          ///Search text Notifier
                          ValueNotifier<bool> searchNotify = ValueNotifier(false);

                          ///There are two lists to display the filter list for selected type
                          ///[itemsRepo] list contains all the data [items] contains only the display if a search is performed
                          List<String> itemsRepo = [], items = [];

                          ///the below performs a query of the [trainingDataListRepo] for unique types
                          if(sel == 0){
                            itemsRepo = [];
                          }else if(sel == 1){
                            Set<TrainingData> uniqueObjects = HashSet<TrainingData>.from(trainingDataListRepo);
                            itemsRepo = uniqueObjects.map((e) => e.location).toSet().toList();
                          }else if(sel == 2){
                            Set<TrainingData> uniqueObjects = HashSet<TrainingData>.from(trainingDataListRepo);
                            itemsRepo = uniqueObjects.map((e) => e.name).toSet().toList();
                          }else if(sel == 3){
                            Set<TrainingData> uniqueObjects = HashSet<TrainingData>.from(trainingDataListRepo);
                            itemsRepo = uniqueObjects.map((e) => e.trainerName).toSet().toList();
                          }
                          items.addAll(itemsRepo);

                          sel as int;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TitleWidget(
                                        "Sort by", (val){
                                      selected.value = val;
                                    },
                                        0,
                                        sel
                                    ),
                                    TitleWidget(
                                        "Location", (val){
                                      selected.value = val;
                                    },
                                        1,
                                        sel
                                    ),
                                    TitleWidget(
                                        "Training Name", (val){
                                      selected.value = val;
                                    },
                                        2,
                                        sel
                                    ),
                                    TitleWidget(
                                        "Trainer", (val){
                                      selected.value = val;
                                    },
                                        3,
                                        sel
                                    ),
                                  ],
                                ),
                              ),
                              VerticalDivider(),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CupertinoSearchTextField(
                                        placeholder: "Search",
                                        onTap: (){
                                          selected.value = sel;
                                        },
                                        onChanged: (val){
                                          if(val.isEmpty){
                                            items.clear();
                                            items.addAll(itemsRepo);
                                          }else{
                                            items = itemsRepo.where((element) => element.toLowerCase().contains(val.toLowerCase())).toList();
                                          }
                                          searchNotify.value = !searchNotify.value;
                                        },
                                      ),
                                      SizedBox(height: 12,),
                                      itemsRepo.isEmpty ? Center(child: Text("No Data")) : ValueListenableBuilder(
                                          valueListenable: searchNotify,
                                          builder: (_, sn, __) {
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: items.length,
                                              itemBuilder: (ctx, ind){
                                                bool selected = checkExists(items[ind]);
                                                ValueNotifier<bool> checkNotify = ValueNotifier(selected);
                                                return InkWell(
                                                  onTap: (){
                                                    ///Adding and removing the filter values
                                                    if(!selected){
                                                      addSelected(items[ind]);
                                                    }else{
                                                      removeSelected(items[ind]);
                                                    }
                                                    selected = !selected;
                                                    checkNotify.value = selected;
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.symmetric(vertical: 8),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          height: 12,
                                                          width: 12,
                                                          child: ValueListenableBuilder(
                                                              valueListenable: checkNotify,
                                                              builder: (_, chNot, __) {
                                                                return Transform.scale(
                                                                  scale: 0.75,
                                                                  child: Checkbox(
                                                                    checkColor: Colors.white,
                                                                    activeColor: Colors.red,
                                                                    value: selected,
                                                                    onChanged: (v){},
                                                                  ),
                                                                );
                                                              }
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(left: 4),
                                                          child: Text("${items[ind]}", style: CustomTextStyles.titleTextStyle,),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                    ),
                  ),
                ),
                Divider(),
                Container(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: (){
                      locationList.clear();
                      trainingList.clear();
                      trainerList.clear();

                      locationList.addAll(locationListTemp);
                      trainingList.addAll(trainingListTemp);
                      trainerList.addAll(trainerListTemp);
                      filterApply();
                      Navigator.pop(context);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 4,
                      color: Colors.red,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Text("Apply Filter", style: CustomTextStyles.titleTextStyle.copyWith(color: Colors.white),),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

}