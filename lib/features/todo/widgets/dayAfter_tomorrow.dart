import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/common/utils/constants.dart';
import 'package:riverpod_todo/common/widgets/expanstion_tile.dart';
import 'package:riverpod_todo/features/todo/controllers/todo_provider.dart';
import 'package:riverpod_todo/features/todo/controllers/xpansion_provider.dart';
import 'package:riverpod_todo/features/todo/pages/update_task.dart';
import 'package:riverpod_todo/features/todo/widgets/todo_tile.dart';

class DayAfterTomorrow extends ConsumerWidget {
  const DayAfterTomorrow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);
    var color = ref.read(todoStateProvider.notifier).getRandomColor();
    String dayAfter = ref.read(todoStateProvider.notifier).getDayAfter();
    var tomorrowTasks = todos.where((element) => element.date!.contains(dayAfter));

    return XpansionTile(
        text: DateTime.now().add(const Duration(days: 2)).toString().substring(5,10),
        text2: "Day After tomorrow tasks",
        onExpansionChanged: (bool expanded) {
          ref.read(xpansionStateProvider.notifier).setStart(!expanded);
        },
        trailing: Padding(
          padding: EdgeInsets.only(right: 12.0.w),
          child: ref.watch(xpansionStateProvider)
              ? const Icon(AntDesign.circledown, color: AppConst.kLight)
              : const Icon(AntDesign.closecircleo, color: AppConst.kBlueLight),
        ),
        children: [
          for(final todo in tomorrowTasks)
            TodoTile(
              color: color,
              title: todo.title,
              description: todo.desc,
              start: todo.startTime,
              end: todo.endTime,
              delete: (){
                ref.read(todoStateProvider.notifier).deleteTodo(todo.id ?? 0);
              },
              editWidget: GestureDetector(
                onTap: () {
                  titles = todo.title.toString();
                  descs = todo.desc.toString();
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) =>  UpdateTask(id: todo.id??0,)
                      )
                  );
                },
                child: const Icon(MaterialCommunityIcons.circle_edit_outline),
              ),
              switcher: const SizedBox.shrink(),
            )
        ]);
  }
}
