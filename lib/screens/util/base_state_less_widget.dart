import 'package:final_frontend/screens/util/base_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

abstract class BaseStatelessWidget<T extends BaseModel>
    extends StatelessWidget {
  // 建立baseModel的provider
  // (ChangeNotifierProvider create已寫好)
  T createProvider(BuildContext context);

  // 建立元件, parent為stackView
  Widget onBuild(BuildContext context);

  const BaseStatelessWidget({Key? key}) : super(key: key);

  /// 新增baseModel以外的provider
  List<SingleChildWidget> createProviders(BuildContext context) {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => createProvider(context),
        ),
        ...createProviders(context)
      ],
      builder: (context, _) {
        Widget childView = _buildView(context);

        return childView;
      },
    );
  }

  Widget _buildView(BuildContext context) {
    return
        // ErrorHandlerView<T>(
        //   child: TouchableView<T>(
        //     child: Stack(
        //       children: [
        onBuild(context);
    //         LoadingView<T>(),
    //       ],
    //     ),
    //   ),
    // );
  }
}
