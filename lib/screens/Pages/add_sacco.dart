import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../Service_Auth/service_file.dart';

class SaccolistPage extends StatefulWidget {
  const SaccolistPage({super.key});


  @override
  State<SaccolistPage> createState() => _SaccolistPageState();
}

class _SaccolistPageState extends State<SaccolistPage> {
  Authentication_service? _Authentication_service;
  String? _sacconame, _manager, _district, _lastno , _regDate,_saccorid , _regNO;
  double? _deviceHeight, _deviceWidth;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Authentication_service = GetIt.instance<Authentication_service>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _firstItem2(),
                Expanded(
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: _Authentication_service!.fetchSaccoData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Text("No data found");
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var sacco = snapshot.data![index];
                            return _buildSaccoCard(sacco);
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _firstItem2(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextButton(
          onPressed: () {}, // Add your onPressed methods here
          child: const Text(
            'Sacco',
            style: TextStyle(
              fontSize: 20, // adjust as needed
              fontWeight: FontWeight.bold, // adjust as needed
              color: Colors.blue, // adjust as needed
            ),
          ),
        ),
        Row(
          children: <Widget>[

            TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return _showMaterialModalBottomSheet(); // Replace with your form widget
                  },
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey,
              ),
              child: const Text(
                'Add New Sacco',
                style: TextStyle(
                  fontSize: 20, // adjust as needed
                  fontWeight: FontWeight.bold, // adjust as needed
                  color: Colors.white, // adjust as needed
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }


  Widget _showMaterialModalBottomSheet() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7, // 80% of device height
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _titleWidget(),
              _addSaccoForm(),
              _addSaccoButton(),
              const SizedBox(height: 200.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addSaccoForm() {
    return Container(
      padding: const EdgeInsets.all(16.0), // Add padding if needed
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _sacconameTextField(),
              const SizedBox(height: 32.0),
              _sacco_idTextField(),
              const SizedBox(height: 32.0),
              _managerTextField(),
              const SizedBox(height: 32.0),
              _districtTextField(),
              const SizedBox(height: 32.0),
              _lastNOTextField(),
              const SizedBox(height: 32.0),
              _regNOTextField(),
              const SizedBox(height: 32.0),
              _dateOfRegTextField(),


            ],
          ),
        ),
      ),
    );
  }


  Widget _titleWidget(){
    return const Text(
      "Add Another Sacco",
      style: TextStyle(
        fontSize: 42,
        color:  Colors.grey,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _sacconameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Sacco Name",
        labelText: "Sacco Name",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      validator: (_value) => _value!.length > 0 ? null : "Please enter the name",
      onSaved: (_value) {
        setState(() {
          _sacconame = _value;
        });
      },
    );
  }
  Widget _sacco_idTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Sacco id",
        labelText: "Sacco id",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      validator: (_value) => _value!.length > 0 ? null : "Please enter the id",
      onSaved: (_value) {
        setState(() {
          _saccorid = _value;
        });
      },
    );
  }
  Widget _managerTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Manager Name",
        labelText: "Manager Name",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      validator: (_value) => _value!.length > 0 ? null : "Please enter the name",
      onSaved: (_value) {
        setState(() {
          _manager = _value;
        });
      },
    );
  }

  Widget _districtTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "District",
        labelText: "District",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      validator: (_value) => _value!.length > 0 ? null : "Please enter the  district name",
      onSaved: (_value) {
        setState(() {
          _district = _value;
        });
      },
    );
  }
  Widget _lastNOTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "last Number",
        labelText: "last Number",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onSaved: (_value) {
        setState(() {
          _lastno = _value;
        });
      },
      keyboardType: TextInputType.phone,
      validator: (_value) {
        bool _results = _value!.contains(RegExp(r'^\+?[1-9]\d{1,14}$')); // Validates international phone number
        return _results ? null : "Invalid Number";
      },
    );
  }
  Widget _regNOTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Registration Number",
        labelText: "Registration Number",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onSaved: (_value) {
        setState(() {
          _regNO = _value;
        });
      },
      keyboardType: TextInputType.phone,
      validator: (_value) {
        bool _results = _value!.contains(RegExp(r'^\+?[1-9]\d{1,14}$')); // Validates international phone number
        return _results ? null : "Invalid Number";
      },
    );
  }
  final TextEditingController _dateController = TextEditingController();
  Widget _dateOfRegTextField() {
    return TextFormField(
      controller: _dateController,
      decoration: InputDecoration(
        hintText: " Registration Date",
        labelText: "Registration Date",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        // ...
      ),
      readOnly: true,
      onTap: () async {
        FocusScope.of(context).requestFocus(new FocusNode());
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
          setState(() {
            _regDate = formattedDate;
            _dateController.text = formattedDate;
          });
        }
      },
      // ...
    );
  }

  Widget _addSaccoButton(){
    return MaterialButton(
        onPressed: _addSacco,
        minWidth: _deviceWidth! * 0.9,
        height: _deviceHeight! * 0.06,
        color: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // adjust the value as needed
        ),
        child: const Text("Add Sacco",
          style: TextStyle(color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
        )
    );
  }
  _addSacco()async{
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      bool _results =  await  _Authentication_service!.add_Sacco(
          sacco_name: _sacconame!,
          saccor_id: _saccorid!,
          saccO_manageer_name: _manager!,
          location_district: _district!,
          last_number: _lastno!,
          registration_number: _regNO!,
          registration_date: _regDate!
      );
      if(_results) Navigator.popAndPushNamed(context, 'home');
    }
  }



  Widget _buildSaccoCard(Map<String, dynamic> sacco) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sacco['sacco_name'],
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "Manager: ${sacco['saccO_manageer_name']}",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "Location: ${sacco['location_district']}",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "Registration Number: ${sacco['registration_number']}",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "Registration Date: ${sacco['registration_date']}",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            // Add more details as needed
            // Later, you can add a section to display members
          ],
        ),
      ),
    );
  }
}
