import 'package:flutter/material.dart';
void main(){
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Simple Interest Calculator App",
        home: SIForm(),
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.indigoAccent,
          accentColor: Colors.indigo,
        ),
      )
  );
}
class SIForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return _SIFormState();
  }

}
class _SIFormState extends State<SIForm>{
  var _currencies=['Rupees','Dollars','Ponds'];
  final _minimumPadding=5.0;
  var _currentItemSlected="Rupees";
  TextEditingController principalController=TextEditingController();
  TextEditingController roiController=TextEditingController();
  TextEditingController termController=TextEditingController();
  var displayResult="";
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle=Theme.of(context).textTheme.title;
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Simple interest Calculator"),
      ),
      body:Container(
        child: ListView(
          children: <Widget>[
            getImageAsset(),
            Padding(
                padding: EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
                child:TextField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: principalController,
                  decoration: InputDecoration(
                    labelText: "Principal",
                    hintText: "Enter principal eg:1234",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    ),


                  ),
                )),
            Padding(
                padding: EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
                child:TextField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: roiController,
                  decoration: InputDecoration(
                    labelText: "Rate of Interest",
                    hintText: "IN percentage",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    ),


                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
              child:Row(
              children: <Widget>[
                Expanded(
                  child:TextField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: termController,
                  decoration: InputDecoration(
                    labelText: "Terms",
                    hintText: "Time in Year",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    ),


                  ),
                )),
               Container(width: _minimumPadding*5,),
               Expanded(
                 child:DropdownButton<String>(
                  items:_currencies.map((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: textStyle,),

                    );
                  }
                  ).toList(),
                   value: _currentItemSlected,
                   onChanged: (String newValueSelected){
                    _onDropDownItemSelected(newValueSelected);

                   },
                ))

              ],
            )),
            Padding(
              padding: EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
              child:Row(
              children: <Widget>[

                Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColorDark,
                      child: Text("Calculate",style: textStyle,),
                      onPressed: (){
                        setState(() {
                          this.displayResult=calculateTotalReturns();
                        });



                      },
                    )),
                Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).accentColor,
                      child: Text("Reset"),
                      onPressed: (){
                        setState(() {
                          _reset();
                        });

                      },
                    )),
              ],
            )),
            Padding(
              padding: EdgeInsets.all(_minimumPadding),
              child:Text(this.displayResult,style: textStyle,),
            )



          ],
        ),
      ),

    );
  }
  Widget getImageAsset(){
    AssetImage assetImage=AssetImage("images/money.png");
    Image image=Image(image: assetImage,width: 125.0,height: 125.0,);
    return Container(child: image, margin: EdgeInsets.all(_minimumPadding*10),);
  }
  void _onDropDownItemSelected(String newValueSelected){
    setState(() {
      this._currentItemSlected=newValueSelected;
    });
  }
  String calculateTotalReturns(){
    double principal=double.parse(principalController.text);
    double roi=double.parse(roiController.text);
    double term=double.parse(termController.text);
    double totalAmountPayable=principal+(principal*roi*term)/100;
    String result="After $term years,your investment will be worth $totalAmountPayable $_currentItemSlected";
    return result;
  }
  void _reset(){
    principalController.text="";
    roiController.text="";
    termController.text="";
    displayResult="";
    _currentItemSlected=_currencies[0];
  }


}