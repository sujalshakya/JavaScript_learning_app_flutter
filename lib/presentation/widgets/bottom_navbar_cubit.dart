import 'package:flutter_bloc/flutter_bloc.dart';

enum BottomNavBarItem { item1, item2, item3, item4 }

class BottomNavBarCubit extends Cubit<BottomNavBarItem> {
  BottomNavBarCubit() : super(BottomNavBarItem.item1);

  void selectItem(BottomNavBarItem item) => emit(item);
}

