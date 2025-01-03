import 'package:auzmor_task/data/training_data.dart';
import 'package:auzmor_task/utils/date_time_utils.dart';
import 'package:auzmor_task/utils/text_styles.dart';
import 'package:flutter/material.dart';

/// This is the widget for Carousel Slider element takes [trainingData]
/// which is of Type [TrainingData] as input
class TrainingImageTile extends StatelessWidget {

  TrainingData trainingData;

  TrainingImageTile(this.trainingData);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              trainingData.background),
          fit: BoxFit.fill,
        ),
      ),
      padding: EdgeInsets.all(16),
      alignment: Alignment.centerLeft,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Positioned.fill(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black12,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(trainingData.name, style: CustomTextStyles.headingTextStyle,),
                SizedBox(height: 4,),
                Text("${trainingData.location} - ${DateTimeUtil.formatTrainingDateForSlider(trainingData.from, trainingData.to)}",
                  style: CustomTextStyles.subTitleTextStyle.copyWith(color: Colors.white60),),
                SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text("\$875", style: CustomTextStyles.headingTextStyle,)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("View Details", style: CustomTextStyles.subTitleTextStyle.copyWith(color: Colors.white60),),
                        Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 12,)
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
