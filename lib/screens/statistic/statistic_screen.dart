import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:room_master_app/common/constant.dart';
import 'package:room_master_app/common/extensions/context.dart';
import 'package:room_master_app/l10n/l10n.dart';
import 'package:room_master_app/navigation/navigation.dart';
import 'package:room_master_app/screens/component/SpacerComponent.dart';
import 'package:room_master_app/screens/component/task_container.dart';
import 'package:room_master_app/screens/component/top_header/primary.dart';

class StatisticScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TaskDetailScreenState();
}

class TaskDetailScreenState extends State<StatisticScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          TopHeader(
              title: context.l10n.task_detail,
              leftAction: () {
                context.go(NavigationPath.home);
              }),
          const SizedBox(height: 20),
          Expanded(
              child: Container(
                  // width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "120 task",
                          style: context.textTheme.titleLarge?.copyWith(
                              fontSize: 32, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          context.l10n.assign_this_month,
                          style: context.textTheme.bodyMedium,
                          textAlign: TextAlign.left,
                        ),
                        SpacerComponent.l(),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: AppConstants.monthsInYear
                                      .map((e) => GestureDetector(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4,
                                                      horizontal: 20),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: e == 'May'
                                                              ? context
                                                                  .appColors
                                                                  .primary
                                                              : Colors
                                                                  .transparent,
                                                          width: 2))),
                                              child: Text(
                                                e,
                                                style: context
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(
                                                        color: e == 'May'
                                                            ? context.appColors
                                                                .primary
                                                            : context.appColors
                                                                .textGray),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              ),
                              SpacerComponent.m(),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      context.l10n.statistic,
                                      style: context.textTheme.titleMedium,
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    value: 'Week',
                                    onChanged: (newValue) {
                                      print(newValue);
                                    },
                                    items: <String>[
                                      'Week',
                                      'Day',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,
                                            style:
                                                context.textTheme.bodyMedium),
                                      );
                                    }).toList(),
                                    alignment: Alignment.centerLeft,
                                  ),
                                ],
                              ),
                              Row(
                                children:
                                    AppConstants.taskInWeeksExample.map((e) {
                                  List listTaskAmount = AppConstants
                                      .taskInWeeksExample
                                      .map((e) => e[e.keys.first])
                                      .toList();
                                  int maxNumber = listTaskAmount.reduce(
                                      (curr, next) =>
                                          curr > next ? curr : next);
                                  int amountTask = e['${e.keys.first}'];
                                  return Expanded(
                                      child: Column(
                                    children: [
                                      Text("$amountTask"),
                                      SpacerComponent.s(),
                                      RotatedBox(
                                        quarterTurns: -1,
                                        child: SizedBox(
                                          width: 180,
                                          child: LinearProgressIndicator(
                                            value: amountTask / maxNumber,
                                            minHeight: 12,
                                            color: context.appColors.primary,
                                            backgroundColor:
                                                context.appColors.bgGrayLight,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ),
                                      SpacerComponent.m(),
                                      Text(e.keys.first),
                                    ],
                                  ));
                                }).toList(),
                              )
                            ],
                          ),
                        ),
                        SpacerComponent.m(),
                        Text(
                          context.l10n.latest_activities,
                          style: context.textTheme.titleMedium,
                        ),
                        ListView.builder(
                          itemBuilder: (context, index) => TaskContainer(
                            context: context,
                            isShadowContainer: false,
                            title: 'Test Title',
                            content: 'Test content',
                            backgroundColor: Colors.blue.shade50,
                            iconBackgroundColor: Colors.blue.shade100,
                            contentColor: Colors.blue.shade500,
                          ),
                          itemCount: 20,
                        )
                      ],
                    ),
                  )))
        ],
      )),
    );
  }
}
