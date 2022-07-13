import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/core/abstarct/constant/core_common_contant.dart';
import 'package:flutter_core/core/presentation/abstract/bloc/core_bloc_builder.dart';
import 'package:flutter_core/core/presentation/abstract/bloc/core_state.dart';
import 'package:provider/provider.dart';
import 'package:test_task/feature/presentation/cubit/task_cubit.dart';
import 'package:test_task/feature/presentation/cubit/task_state.dart';

class SearchTaskScreen extends StatefulWidget {
  const SearchTaskScreen({Key key}) : super(key: key);

  @override
  State<SearchTaskScreen> createState() => _SearchTaskScreenState();
}

class _SearchTaskScreenState extends State<SearchTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios_rounded,
                  color: Colors.black)),
          title: const Text('Seach'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                cursorColor: Colors.black,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.15),
                  hintText: 'Design team meeting',
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8)),
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 12, top: 12),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (val) {
                  context.read<TaskCubit>().filterTutorials(val);
                },
              ),
            ),
          ),
        ),
        body: CoreUpgradeBlocBuilder<TaskCubit, CoreState>(
            listener: (context, state) {},
            buildWhen: (previous, current) => current is SearchTaskState,
            builder: (_, state) {
              if (state is SearchTaskState) {
                if (state.isLoading) {
                  return const Scaffold(
                      body: Center(child: CupertinoActivityIndicator()));
                }

                if (state.taskModel.tasks.isEmpty) {
                  return const Center(child: Text('No Data'));
                }

                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Flexible(
                        child: Scrollbar(
                          child: ListView.separated(
                              itemBuilder: (context, index) => ListTile(
                                  title: Text(
                                      state.taskModel.tasks[index].title ??
                                          CoreConstant.empty)),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 5),
                              itemCount: state.taskModel.tasks.length),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            }));
  }
}
