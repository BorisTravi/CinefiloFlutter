import 'package:flutter/material.dart';
import 'package:movie_app/common/MediaProvides.dart';
import 'package:movie_app/models/Cast.dart';

class CastController extends StatefulWidget {
final MediaProvider provider;
final int mediaId; 
CastController(this.provider, this.mediaId);
@override
_CastControllerState createState()=> _CastControllerState();
}
class _CastControllerState extends State<CastController> {
  @override
  void initState(){
    super.initState();
    loadCast();
  }

  final  List<Cast> _casts = new List<Cast>();
  void loadCast()async{
  var  result = await widget.provider.fetchCast(widget.mediaId);
    setState(() {   
    _casts.addAll(result);
    });
  }
Widget _builderCast(BuildContext ctx, int index){
  var cast = _casts[index];
 return Padding(padding: const EdgeInsets.only(right : 16.0),
    child: Column(children: <Widget>[
      CircleAvatar(
        backgroundImage:new NetworkImage(
         cast.getCastUrl()
      ),
      radius: 40.0,
      ),
      Padding(padding: const EdgeInsets.only(top: 8.0),
      child:  Text(cast.name),
      )
    ],
  ),
 );
}

@override
 Widget build(BuildContext context) {
   return new Column(
   children: <Widget>[
      SizedBox.fromSize(
         size:  const Size.fromHeight(180),
         child: ListView.builder(itemCount:_casts.length,
         scrollDirection: Axis.horizontal,
         padding: const EdgeInsets.only(top: 12.0, left: 20.0),
         itemBuilder: _builderCast,
         )
      )
   ],
   );
  }
}