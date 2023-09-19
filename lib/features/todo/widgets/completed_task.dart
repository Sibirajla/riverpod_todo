
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/common/models/task_model.dart';
import 'package:riverpod_todo/common/utils/constants.dart';
import 'package:riverpod_todo/features/todo/controllers/todo_provider.dart';
import 'package:riverpod_todo/features/todo/widgets/todo_tile.dart';

class CompletedTask extends ConsumerWidget {
  const CompletedTask({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Task> listData = ref.watch(todoStateProvider);
    List lastMonth = ref.read(todoStateProvider.notifier).last30days();
    var completed = listData.where((element) =>
    element.isCompleted == 1 || lastMonth.contains(element.date!.substring(0,10))).toList();
    dynamic color = ref.read(todoStateProvider.notifier).getRandomColor();
    return ListView.builder(
        itemCount: completed.length,
        itemBuilder: (context, index){
          final data = completed[index];
          return TodoTile(
            delete: (){
              ref.read(todoStateProvider.notifier).deleteTodo(data.id ?? 0);
            },
            editWidget: const SizedBox.shrink(),
            title: data.title,
            color: color,
            description: data.desc,
            start: data.startTime,
            end: data.endTime,
            switcher: const Icon(AntDesign.checkcircle, color: AppConst.kGreen,),
          );

        }
    );
  }
}
