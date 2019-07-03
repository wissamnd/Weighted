
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../logic/actions.dart';
import '../logic/States/redux_state.dart';
import '../screens/history_page.dart';
import '../screens/profile_page.dart';
import '../screens/statistics_page.dart';
import '../screens/weight_entry_dialog.dart';
import '../screens/graph_page.dart';
class MainPageViewModel {
  final double defaultWeight;
  final bool hasEntryBeenAdded;
  final String unit;
  
  final Function() openAddEntryDialog;
  final Function() acceptEntryAddedCallback;

  MainPageViewModel({
    this.openAddEntryDialog,
    this.defaultWeight,
    this.hasEntryBeenAdded,
    this.acceptEntryAddedCallback,
    this.unit,
    
  });
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;
  


  @override
  State<MainPage> createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage>

    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    
  }

  int _cIndex = 0;

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }
  final List<Widget> _children = [StatisticsPage(),HistoryPage(),ProfilePage()];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<ReduxState, MainPageViewModel>(
      converter: (cache) {
        return new MainPageViewModel(
          // if the the entries are empty ? assign the default weight to 60 else get the wieght
          defaultWeight: cache.state.entries.isEmpty
              ? 60.0
              : cache.state.entries.first.weight,
          hasEntryBeenAdded: cache.state.mainPageState.hasEntryBeenAdded,
          acceptEntryAddedCallback: () =>
              cache.dispatch(new AcceptEntryAddedAction()),
          openAddEntryDialog: () {
            cache.dispatch(new OpenAddEntryDialog());
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) {
                return new WeightEntryDialog();
              },
              fullscreenDialog: true,
            ));
          },
          unit: cache.state.unit,
        );
      },
      onInit: (store) {
        store.dispatch(new GetSavedWeightNote());
       
      },
      builder: (context, viewModel) {
        if (viewModel.hasEntryBeenAdded) {
          viewModel.acceptEntryAddedCallback();
        }
        return new Scaffold(
          body: _children[_cIndex],

          floatingActionButton: (_cIndex != 2)?new FloatingActionButton(
            onPressed: () => viewModel.openAddEntryDialog(),
            tooltip: 'Add new weight entry',
            child: new Icon(Icons.add),

          ):null,
          bottomNavigationBar: BottomNavigationBar (
            currentIndex: _cIndex,
            type: BottomNavigationBarType.shifting ,
            onTap: (index){
              _incrementTab(index);
            },
            iconSize: 30,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard,color: Colors.grey[600],),
                  title: new Text('Home',style: TextStyle(color: Theme.of(context).textTheme.body1.color),)
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.album,color: Colors.grey[600],),
                  title: new Text('Records',style: TextStyle(color: Theme.of(context).textTheme.body1.color),)
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings,color: Colors.grey[600],),
                title: new Text('Settings',style: TextStyle(color: Theme.of(context).textTheme.body1.color),)
              ),
            ],
          ),
        );
      },
    );
  }
}
