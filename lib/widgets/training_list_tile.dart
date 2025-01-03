import 'package:auzmor_task/data/training_data.dart';
import 'package:auzmor_task/utils/text_styles.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../utils/date_time_utils.dart';


/// This is the widget for Listview Tile takes [trainingData]
/// which is of Type [TrainingData] as input

class TrainingListTile extends StatelessWidget {

  TrainingData trainingData;

  TrainingListTile(this.trainingData);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Colors.white,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.only(right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateTimeUtil.formatTrainingDate(trainingData.from, trainingData.to),
                    style: CustomTextStyles.titleTextStyle.copyWith(fontWeight: FontWeight.bold),),
                  SizedBox(height: 12,),
                  Text(DateTimeUtil.eventTime(), style: CustomTextStyles.subTitleTextStyle.copyWith(fontSize: 10),),
                  SizedBox(height: 12,),
                  Text(trainingData.location, style: CustomTextStyles.subTitleTextStyle.copyWith(fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height*0.1,
            child: const DottedLine(
              dashLength: 1,
              direction: Axis.vertical,
              lineThickness: 0.5,
              dashGapLength: 1,
            ),
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trainingData.tag == TrainingTag.Early_Bird ? "Early Bird" : "Filling Fast",
                          style: TextStyle(color: Colors.red, fontSize: 10),
                        ),
                        SizedBox(height: 8,),
                        Text(trainingData.name, style: CustomTextStyles.titleTextStyle.copyWith(color: Colors.black),),
                        SizedBox(height: 8,),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                                child: Image.network(trainingData.trainerPic, height: 40, width: 40,)
                            ),
                            SizedBox(width: 12,),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(trainingData.trainerName, style: CustomTextStyles.titleTextStyle.copyWith(color: Colors.black),),
                                SizedBox(height: 4,),
                                Text(trainingData.trainerDesignation, style: CustomTextStyles.subTitleTextStyle.copyWith(color: Colors.black),),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          print("I was clicked");
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          color: Colors.red,
                          child: Text("Enroll", style: CustomTextStyles.subHeadingTextStyle,),
                        ),
                      ),
                    ),
                  )
                ],
              )
          )

        ],
      ),
    );
  }
}
