//Yeni Araç Al
//Eskiden kullandığım ekranın getiricem
//Tarih seçimlerini getiricem
//Kimden olduğunu getiricem

import 'package:arac_takip/feature/home/model/car_tracking_info_model.dart';
import 'package:arac_takip/feature/home_detail/view/cubit/home_detail_cubit.dart';
import 'package:arac_takip/product/network/product_db_manager.dart';
import 'package:arac_takip/product/widget/custom_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../../product/constant/application_constant.dart';

class HomeDetailView extends StatefulWidget {
  static const routeName = 'detail-route';
  final int? id;
  //final CarTrackingInfo selectedCarTrackingInfo;

  //const HomeDetailView(this.selectedCarTrackingInfo, {Key? key}) : super(key: key);
  const HomeDetailView(this.id, {Key? key}) : super(key: key);

  @override
  _HomeDetailViewState createState() => _HomeDetailViewState();
}

class _HomeDetailViewState extends State<HomeDetailView> {
  final CarTrackingInfo _selectedCarTrackingInfo = CarTrackingInfo(
      id: 1,
      model: 'Clio',
      plate: '34 EZC 373',
      fromdate: DateTime(2022, 6, 10, 9, 0),
      todate: DateTime.now(),
      takenfrom: "Ali Yılmaz",
      givento: "İzzet Gök",
      note: 'DENEME NOTU');
  //Parametre olarak aldığımız logu kullanacağımız değişken
  late final CarTrackingInfo _editableInfo;
  List<bool> isSelected = List.filled(3, false);

  //var dbHelper = DatabaseHelper();

  //TextController ve State İşlemleri
  final _titleController = TextEditingController(); //eventName
  final _contentController = TextEditingController(); //note
  bool? _isNewNote;
  final _titleFocus = FocusNode();
  final _contentFocus = FocusNode();

  //var _editableNote;
  //WillPopScope için bir key gerekiyor
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Önceki ekrandan seçtiğimiz Notu ekranımıza alıyoruz
    _editableInfo = _selectedCarTrackingInfo;
    //Başlık için textController
    //_titleController.text = _editableInfo.eventName ??= '';
    //Detay için textController
    _contentController.text = _editableInfo.note ??= '';
    //Not için seçilmiş arka plan
    //noteColor = _editableInfo.background!;
    //Yeni bir notsa id boş olacaktır. Ona göre kaydet veya update et olacak
    _isNewNote = _editableInfo.id == null ? true : false;
    //Eğer önceden bir feeling eklendiyse onu çek
    if (_editableInfo.model != null) {
      isSelected[carList.indexWhere((element) => element == _editableInfo.model)] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeDetailCubit(widget.id),
      child: WillPopScope(
        onWillPop: _readyToPop,
        key: _globalKey,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  icon: const Icon(Icons.delete),
                  //Eğer yeni bir kayıtsa id null olacak ve buton pasif olacak
                  onPressed: _editableInfo.id == null ? null : null //stateki silme işlemi,
                  ),
            ],
            title: const Text("Calendar Detail Page"),
          ),
          body: ColoredBox(
            color: Colors.white,
            child: Column(
              children: [
                CustomToggleButtons(),
                BlocConsumer<HomeDetailCubit, HomeDetailState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    state.fromdate;
                  },
                  builder: (context, state) {
                    return Column(children: [
                      DateTimePickers(state.fromdate!),
                      DateTimePickers(state.todate!),
                    ]);
                  },
                ),
                Expanded(
                  child: textWidgets(),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await save(_editableInfo)
                        .then((value) => value > 0 ? Navigator.of(context).pop() : print("kaydetme başarısız"));
                  },
                  child: const Text("Kaydet"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//TODO: Burası state management içerisinde olması lazım
  Future<int> save(CarTrackingInfo record) async {
    record.fromdate = DateTime.now();
    record.todate = DateTime.now();
    //record. = feelingList[isSelected.indexOf(true)];
    //record.background = noteColor;
    //Eğer id boşsa insert et doluysa update et
    //Future<int> saveResult = _editableInfo.id == null ? dbHelper.saveCalendarLog(record) : dbHelper.updateCalendarLog(record);
    //return saveResult;
    return 1;
  }

  Ink CustomToggleButtons() {
    return Ink(
      width: MediaQuery.of(context).size.width,
      height: 150,
      color: Colors.white,
      child: GridView.count(
        primary: true,
        //set the number of buttons in a row
        crossAxisCount: 3,
        //set the spacing between the buttons
        crossAxisSpacing: 8,
        //set the spacing between the buttons
        mainAxisSpacing: 3,
        //set the width-to-height ratio of the button,
        childAspectRatio: 1,
        padding: const EdgeInsets.all(12.0),
        //>1 is a horizontal rectangle
        children: List.generate(isSelected.length, (index) {
          return GestureDetector(
            onTap: () {
              //set the toggle logic
              setState(() {
                for (int indexBtn = 0; indexBtn < isSelected.length; indexBtn++) {
                  if (indexBtn == index) {
                    isSelected[indexBtn] = true;
                  } else {
                    isSelected[indexBtn] = false;
                  }
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: isSelected[index] ? Colors.red : Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(isSelected[index] ? '${iconList[index]}.jpg' : '${iconList[index]}.jpg'),
            ),
          );
        }),
      ),
    );
  }

  Future<bool> _readyToPop() async {
    final _popStatus = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: const Text('Warning'),
            content: const Text("Are you sure to go back?"),
            actions: [
              TextButton(
                child: const Text("No"),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              TextButton(
                child: const Text("Yes"),
                onPressed: () {
                  //Navigator.pop(context, true);
                },
              )
            ],
          ); //Şu an her koşulda pop edecek. Buraya kontrol ekleyeceğim
        });

    return _popStatus!;
  }

  Padding textWidgets() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //color: noteColor,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black87),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(hintText: "Baslik"),
              onChanged: (str) => {updateNoteObject()},
              maxLines: null,
              focusNode: _titleFocus,
              controller: _titleController,
              style: const TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
              cursorColor: Colors.blue,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: TextFormField(
                  decoration: const InputDecoration(hintText: "Detay"),
                  onChanged: (str) => {updateNoteObject()},
                  //MaxLines kaç olmalı onun belirlenmesi gerekir
                  maxLines: 20,
                  focusNode: _contentFocus,
                  // line limit extendable later
                  controller: _contentController,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  cursorColor: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateNoteObject() {
    _editableInfo.note = _contentController.text;
  }

  Widget DateTimePickers(DateTime selectedDateTime) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          customDTPicker(selectedDateTime),
          Text(
            selectedDateTime.toString(),
            style: TextStyle(
              color: Colors.green.shade800,
            ),
          ),
        ],
      ),
    );
  }

  Widget customDTPicker(DateTime selectedDateTime) {
    return IconButton(
      style: IconButton.styleFrom(focusColor: Colors.red, backgroundColor: Colors.blue.shade700),
      onPressed: () {
        DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          minTime: DateTime(2022, 1, 1),
          maxTime: DateTime(2100, 1, 1),
          onChanged: (selectedDateTime) {
            print('change $selectedDateTime');
          },
          onConfirm: (selectedDateTime) {
            print('confirm $selectedDateTime');
          },
          currentTime: DateTime.now(),
          locale: LocaleType.tr,
        );
      },
      icon: const Icon(Icons.calendar_month),
      color: Colors.blue,
    );
  }
}
