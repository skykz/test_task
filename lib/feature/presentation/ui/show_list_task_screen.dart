import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/core/abstarct/constant/core_common_contant.dart';
import 'package:flutter_core/core/presentation/abstract/bloc/core_bloc_builder.dart';
import 'package:flutter_core/core/presentation/abstract/bloc/core_state.dart';
import 'package:test_task/feature/presentation/cubit/task_cubit.dart';
import 'package:test_task/feature/presentation/cubit/task_state.dart';
import 'package:test_task/feature/presentation/ui/create_task_screen.dart';
import 'search_task_screen.dart';

class ShowTaskListScreen extends StatefulWidget {
  const ShowTaskListScreen({Key key}) : super(key: key);

  @override
  State<ShowTaskListScreen> createState() => _ShowTaskListScreenState();
}

class _ShowTaskListScreenState extends State<ShowTaskListScreen>
    with SingleTickerProviderStateMixin {
// controller object
  TabController _tabController;
  TaskCubit _taskCubit;
  // List of Tabs

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    _taskCubit = TaskCubit();
    _taskCubit.getTaskList();

    _tabController.addListener(() {
      _taskCubit.tabChanged(_tabController.index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CoreUpgradeBlocBuilder<TaskCubit, CoreState>(
        cubit: _taskCubit,
        listener: (context, state) {},
        buildWhen: (previous, current) => current is TaskState,
        builder: (_, state) {
          if (state is TaskState) {
            if (state.isLoading) {
              return const Scaffold(
                  body: Center(child: CupertinoActivityIndicator()));
            }

            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: const Text('Board'),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    BlocProvider<TaskCubit>.value(
                                        value: _taskCubit,
                                        child: const SearchTaskScreen()))));
                      },
                      icon: const Icon(
                        Icons.search_rounded,
                        color: Colors.grey,
                      ))
                ],
                bottom: TabBar(
                    controller: _tabController,
                    labelColor: Colors.black,
                    isScrollable: true,
                    indicatorColor: Colors.black,
                    onTap: (index) {
                      _taskCubit.tabChanged(index);
                    },
                    tabs: state.status
                        .map((e) => Tab(
                              text: e.name,
                              iconMargin: const EdgeInsets.only(bottom: 10.0),
                            ))
                        .toList()),
              ),
              body: DefaultTabController(
                  initialIndex: 1,
                  length: state.status.length,
                  child: TabBarView(
                    controller: _tabController,
                    children: state.status.map((task) {
                      return Scrollbar(
                        child: ListView.separated(
                            itemBuilder: (context, index) => ListTile(
                                title: Text(
                                    state.taskModel.tasks[index].title ??
                                        CoreConstant.empty)),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 5),
                            itemCount: state.taskModel.tasks.length),
                      );
                    }).toList(),
                  )),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(25),
                child: TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.green.withOpacity(0.9),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                BlocProvider<TaskCubit>.value(
                                    value: _taskCubit,
                                    child: const CreateTaskScreen()))));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Add Task", style: TextStyle(fontSize: 17)),
                  ),
                ),
              ),
            );
          } else {
            return const Text('No Data');
          }
        });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
