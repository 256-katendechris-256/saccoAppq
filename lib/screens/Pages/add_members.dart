import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../Service_Auth/service_file.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({super.key});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  double? _deviceHeight, _deviceWidth;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _fname, _lname,  _gender, _currentSavings, _sharepercentage, _currentsharevalue, _networth ;
  String? _joiningDate, _saccoId, _memberId, _nin, _passbookNo, _village, _parish, _business;

  Authentication_service? _Authentication_service;
  List<String> saccoIds = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSaccoIds();
    _Authentication_service = GetIt.instance<Authentication_service>();
    _sharePercentageController.addListener(() {
      String text = _sharePercentageController.text;

      // If the text does not end with a percentage symbol, append it
      if (text.isNotEmpty && !text.endsWith('%')) {
        _sharePercentageController.text = text + '%';
        _sharePercentageController.selection = TextSelection.fromPosition(TextPosition(offset: _sharePercentageController.text.length - 1));
      }
    });
  }


  Future<void> fetchSaccoIds() async {
    try {
      QuerySnapshot saccoSnapshot = await FirebaseFirestore.instance
          .collection('sacco')
          .get();
      setState(() {
        saccoIds = saccoSnapshot.docs.map((doc) => doc.get('saccor_id') as String).toList();
      });
    } catch (e) {
      print('Error fetching sacco IDs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _firstItem1(),
              const SizedBox(height: 5),
              Expanded(
                child: FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
                  future: _Authentication_service!.fetchMembers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text("No members found"));
                    } else {
                      var membersBySacco = snapshot.data!;
                      return ListView.builder(
                        itemCount: membersBySacco.keys.length,
                        itemBuilder: (context, index) {
                          String saccoId = membersBySacco.keys.elementAt(index);
                          List<Map<String, dynamic>> members =
                          membersBySacco[saccoId]!;
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                dividerColor: Colors.transparent,
                                dividerTheme: const DividerThemeData(
                                  space: 0,
                                  thickness: 0,
                                ),
                              ),
                              child: ExpansionTile(
                                tilePadding: EdgeInsets.all(0), // Remove tile padding
                                title: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text("Sacco ID: $saccoId"),
                                ),
                                collapsedBackgroundColor: Colors.transparent,
                                backgroundColor: Colors.transparent,
                                children: members.map((member) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                      vertical: 5.0,
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        "${member['memberfirstName']} ${member['memberlastName']}",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      subtitle: Text(
                                        "NIN: ${member['nin']}",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
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
    );
  }



  Widget _firstItem1(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextButton(
          onPressed: () {}, // Add your onPressed methods here
          child: const Text(
            'Member List',
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
                'Add New Member',
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
    return Container(
      height: MediaQuery.of(context).size.height * 0.8, // 80% of device height
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _titleWidget(),
            _addSaccoForm(),
            _addSaccoButton(),
          ],
        ),
      ),
    );
  }

  Widget _addSaccoForm() {
    return Container(
      height: _deviceHeight! * 0.6,
      padding: const EdgeInsets.all(16.0), // Add padding if needed
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _saccoIDextField(),
              const SizedBox(height: 16.0),
              _firstTextField(),
              const SizedBox(height: 16.0),
              _lastTextField(),
              const SizedBox(height: 16.0),
              _genderTextField(),
              const SizedBox(height: 16.0),
              _currentSavingsTextField(),
              const SizedBox(height: 16.0),
              _sharepercentagetSavingsTextField(),
              const SizedBox(height: 16.0),
              _currentshareValueTextField(),
              const SizedBox(height: 16.0),
              _NetworthyTextField(),
              const SizedBox(height: 16.0),
              _joiningdatetField(),
              const SizedBox(height: 16.0),
              _memberIDextField(),
              const SizedBox(height: 16.0),
              _ninTextField(),
              const SizedBox(height: 16.0),
              _passbookNoTextField(),
              const SizedBox(height: 16.0),
              _villageTextField(),
              const SizedBox(height: 16.0),
              _parishTextField(),
              const SizedBox(height: 16.0),
              _businessTextField(),
              const SizedBox(height: 16.0),

              const SizedBox(height: 150.0),

            ],
          ),
        ),
      ),
    );
  }


  Widget _titleWidget(){
    return const Text(
      "Add Sacco Member",
      style: TextStyle(
        fontSize: 42,
        color:  Colors.grey,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _firstTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "First Name",
        labelText: "First Name",
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
          _fname = _value;
        });
      },
    );
  }
  Widget _lastTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "last Name",
        labelText: "last Name",
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
          _lname= _value;
        });
      },
    );
  }
  Widget _genderTextField() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: "Gender",
        labelText: "Gender",
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
      items: <String>['Male', 'Female'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _gender = newValue;
        });
      },
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please select a gender';
        }
        return null;
      },
      onSaved: (String? value) {
        setState(() {
          _gender = value;
        });
      },
    );
  }
  Widget _currentSavingsTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Current Savings",
        labelText: "Current Savings",
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
      keyboardType: TextInputType.numberWithOptions(decimal: true), // Set keyboard type to number
      validator: (_value) {
        if (_value == null || _value.isEmpty) {
          return 'Please enter the current savings';
        }
        try {
          double.parse(_value);
        } catch (e) {
          return 'Please enter a valid number';
        }
        return null;
      },
      onSaved: (_value) {
        setState(() {
          _currentSavings = _value;
        });
      },
    );
  }
  // Create a TextEditingController
  final TextEditingController _sharePercentageController = TextEditingController();


  Widget _sharepercentagetSavingsTextField() {
    return TextFormField(
      controller: _sharePercentageController, // Use the controller
      decoration: InputDecoration(
        hintText: "Share Percentage",
        labelText: "Share Percentage",
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
      keyboardType: TextInputType.numberWithOptions(decimal: true), // Set keyboard type to number
      validator: (_value) {
        if (_value == null || _value.isEmpty) {
          return 'Please enter the share percentage';
        }
        try {
          // Remove the percentage symbol before parsing
          double.parse(_value.replaceAll('%', ''));
        } catch (e) {
          return 'Please enter a valid number';
        }
        return null;
      },
      onSaved: (_value) {
        setState(() {
          // Remove the percentage symbol before saving
          _sharepercentage = _value?.replaceAll('%', '');
        });
      },
    );
  }
  Widget _currentshareValueTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Current Share value",
        labelText: "Current Share value",
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
      keyboardType: TextInputType.numberWithOptions(decimal: true), // Set keyboard type to number
      validator: (_value) {
        if (_value == null || _value.isEmpty) {
          return 'Please enter the current share value';
        }
        try {
          double.parse(_value);
        } catch (e) {
          return 'Please enter a valid number';
        }
        return null;
      },
      onSaved: (_value) {
        setState(() {
          _currentsharevalue = _value;
        });
      },
    );
  }

  final TextEditingController _dateController = TextEditingController();


  Widget _joiningdatetField() {
    return TextFormField(
      controller: _dateController,
      decoration: InputDecoration(
        hintText: "Joining Date",
        labelText: "Date",
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
            _joiningDate = formattedDate;
            _dateController.text = formattedDate;
          });
        }
      },
      // ...
    );
  }
  Widget _saccoIDextField() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        hintText: "Select Sacco Id",
        labelText: "Sacco Id",
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
      items: saccoIds.map((saccoId) {
        return DropdownMenuItem(
          value: saccoId,
          child: Text(saccoId),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _saccoId = value as String?;
        });
      },
      validator: (_value) =>
      _value != null ? null : "Please select a Sacco id",
      onSaved: (_value) {
        setState(() {
          _saccoId = _value as String?;
        });
      },
    );
  }
  Widget _memberIDextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "member Id",
        labelText: "member Id",
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
      validator: (_value) => _value!.length > 0 ? null : "Please enter the member id",
      onSaved: (_value) {
        setState(() {
          _memberId= _value;
        });
      },
    );
  }
  Widget _ninTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "NIN",
        labelText: "NIN",
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
      validator: (_value) => _value!.length > 0 ? null : "Please enter the NIN",
      onSaved: (_value) {
        setState(() {
          _nin = _value;
        });
      },
    );
  }

  Widget _passbookNoTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Passbook No",
        labelText: "Passbook No",
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
      validator: (_value) => _value!.length > 0 ? null : "Please enter the Passbook No",
      onSaved: (_value) {
        setState(() {
          _passbookNo = _value;
        });
      },
    );
  }

  Widget _villageTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Village",
        labelText: "Village",
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
      validator: (_value) => _value!.length > 0 ? null : "Please enter the Village",
      onSaved: (_value) {
        setState(() {
          _village = _value;
        });
      },
    );
  }

  Widget _parishTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Parish",
        labelText: "Parish",
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
      validator: (_value) => _value!.length > 0 ? null : "Please enter the Parish",
      onSaved: (_value) {
        setState(() {
          _parish = _value;
        });
      },
    );
  }

  Widget _businessTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Business",
        labelText: "Business",
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
      validator: (_value) => _value!.length > 0 ? null : "Please enter the Business",
      onSaved: (_value) {
        setState(() {
          _business = _value;
        });
      },
    );
  }
  Widget _NetworthyTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Net Worthy",
        labelText: "Net Worthy",
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 2.0),
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
      keyboardType: TextInputType.numberWithOptions(decimal: true), // Set keyboard type to number
      validator: (_value) {
        if (_value == null || _value.isEmpty) {
          return 'Please enter the net worthy';
        }
        try {
          double.parse(_value);
        } catch (e) {
          return 'Please enter a valid number';
        }
        return null;
      },
      onSaved: (_value) {
        setState(() {
          _networth = _value;
        });
      },
    );
  }
  Widget _addSaccoButton(){
    return MaterialButton(
        onPressed: _addmember,
        minWidth: _deviceWidth! * 0.9,
        height: _deviceHeight! * 0.06,
        color: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // adjust the value as needed
        ),
        child: const Text("Add Member",
          style: TextStyle(color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
        )
    );
  }
  _addmember()async{
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
    bool results =  await _Authentication_service!.addMember(
          saccoId: _saccoId!,
          memberfirstName:_fname!,
          memberlastName: _lname!,
          memberId: _memberId!,
          gender: _gender!,
          current_savings: _currentSavings!,
          share_percentage: _sharepercentage!,
          current_share_amount: _currentsharevalue!,
          net_worth: _networth!,
          nin: _nin!,
          village:_village!,
          parish: _parish!,
          date : _joiningDate!,
          business:  _business!,
          passbook_number:  _passbookNo!,
      );
    if(results){
      Navigator.popAndPushNamed(context, 'home');
    }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Member added successfully"),
        ),
      );
    }
  }


}
