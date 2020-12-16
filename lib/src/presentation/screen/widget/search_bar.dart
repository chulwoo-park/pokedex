import 'package:flutter/widgets.dart';

import '../../resources.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 45.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: R.color.whiteSmoke,
      ),
      padding: EdgeInsets.fromLTRB(18.0, 9.0, 18.0, 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            R.icon.search,
            size: 18.0,
            // color: Color(0xff303943),
          ),
          SizedBox(width: 13),
          Opacity(
            opacity: 0.40,
            child: Text(
              'Search Pokemon, Move, Ability etc',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
