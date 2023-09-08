part of '../drive.dart';

class _DriveFabMenu extends StatefulWidget {
  const _DriveFabMenu();

  @override
  State<_DriveFabMenu> createState() => _DriveFabMenuState();
}

class _DriveFabMenuState extends State<_DriveFabMenu> with SingleTickerProviderStateMixin {
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  bool _isFabMenuVisible = false;

  @override
  void initState() {
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    _fabAnimation = _fabController.curvedTweenAnimation(
      begin: 0.0,
      end: 1.0,
    );

    super.initState();
  }

  @override
  void dispose() {
      _fabController.dispose();

      super.dispose();
  }

  void _toggleFabMenu() {
    _isFabMenuVisible = !_isFabMenuVisible;

    if (_isFabMenuVisible) {
      _fabController.forward();
    } else {
      _fabController.reverse();
    }
  }

  void onPress([Function? callback]) {
    _toggleFabMenu();

    callback?.call();
  }


  @override
  Widget build(BuildContext context){
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;
    
    return AnimatedOverlay(
      animation: _fabAnimation, 
      color: Colors.black,
      onPress: _toggleFabMenu,
              child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(right: 26, bottom: 26 + safeAreaBottom),
              child: ExpandedAnimationFab(
                animation: _fabAnimation,
                onPress: _toggleFabMenu,  
                items : [
                  FabItemData(
                    '추가하기',
                    Icons.add,
                    onPress: () => onPress((){
                      showDialog(
                        context: context,
                        builder: (_){
                          return _buildFrom();
                        }
                      );
                      
                    }),
                  )
                ]
              )
        )
    );
  }

  Widget _buildFrom(){
    return const _DriveForm();
  }
}