import 'package:auzmor_task/utils/text_styles.dart';
import 'package:flutter/material.dart';


/// This is the widget for Filter BottomSheet's Types display
/// [value] will contain it's own value
/// [selectedValue] will contain the selected Type
/// [title] will be the title of the Type of Filter
/// [select] this is a function call which in turn sends it's [value] to parent when clicked
class TitleWidget extends StatelessWidget {

  int value, selectedValue;
  String title;
  Function(int) select;

  TitleWidget(this.title, this.select, this.value, this.selectedValue);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: InkWell(
        onTap: (){
          select(value);
        },
        child: Container(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: selectedValue == value,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Container(
                  height: double.infinity,
                  width: 5,
                  color: Colors.red,
                ),
              ),
              SizedBox(width: 4,),
              Text(title, style: CustomTextStyles.titleTextStyle.copyWith(color: selectedValue == value ? Colors.black : Colors.black87),),
            ],
          ),
        ),
      ),
    );
  }
}
