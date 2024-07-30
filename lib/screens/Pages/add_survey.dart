import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../Service_Auth/service_file.dart';

class add_survey extends StatefulWidget {
  const add_survey({super.key});

  @override
  State<add_survey> createState() => _add_surveyState();
}

class _add_surveyState extends State<add_survey> {
  double? _deviceHeight, _deviceWidth;
  String? _survey_id, _respondantID, _respondantName, _surveyDate, _condauctedBY;
  String? _startTime, _EndTime, _score, _status, _scorePercentage, _TotalScore;
  final GlobalKey <FormState> _formKey = GlobalKey<FormState>();

  Authentication_service? _Authentication_service;

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
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text(
          'Kambascco',
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 45,
              color: Colors.white
          ),
        ),
        centerTitle: true, // This centers the title

        flexibleSpace: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.2),
          child: Container(),
        ),
      ),

      body: SafeArea(
        child: Container(
          height:  _deviceHeight!,
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _titleWidget(),
                  _SurveyFormWiget(),
                  _addSurveyButton()

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleWidget(){
    return const Text(
      "Add Survey",
      style: TextStyle(
        fontSize: 42,
        color:  Colors.grey,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _SurveyFormWiget(){
    return Container(

      height: _deviceHeight! * 0.6,
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: _respondantIDTextField()),
                  const SizedBox(width: 10), // Add a space between the two text fields
                  Expanded(child: _firstTextField()),
                ],
              ),
              const SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: _SurveyIDTextField()),
                  const SizedBox(width: 10), // Add a space between the two text fields
                  Expanded(child: _dateTextField()),
                ],
              ),
              const SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: _startTimeTextField()),
                  const SizedBox(width: 10), // Add a space between the two text fields
                  Expanded(child:_endTimeTextField()),
                ],
              ),
              const SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: _ScoreTextField()),
                  const SizedBox(width: 10), // Add a space between the two text fields
                  Expanded(child:_statusTextField()),
                ],
              ),
              const SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: _scorePercentageField()),
                  const SizedBox(width: 10), // Add a space between the two text fields
                  Expanded(child:_totalScoreField()),
                ],
              ),
              const SizedBox(height: 26),
              // Add more rows as needed
            ],
          ),
        ),
      ),
    );
  }

  Widget _addSurveyButton(){
    return MaterialButton(
        onPressed:_AdaSurvey,
        minWidth: _deviceWidth! * 0.9,
        height: _deviceHeight! * 0.06,
        color: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // adjust the value as needed
        ),
        child: const Text("Add Survey",
          style: TextStyle(color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
        )
    );
  }
  Widget _firstTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Name",
        labelText: "Full Name",
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
      validator: (_value) => _value!.length > 0 ? null : "Please enter the  full name",
      onSaved: (_value) {
        setState(() {
          _respondantName = _value;
        });
      },
    );
  }
  Widget _respondantIDTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "ID",
        labelText: "respondentID",
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
          return 'Please enter the id';
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
          _respondantID = _value;
        });
      },
    );
  }

  Widget _SurveyIDTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "SurveyID",
        labelText: "SurveyID",
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
          return 'Please enter the survey id';
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
          _survey_id = _value;
        });
      },
    );
  }

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  Widget _dateTextField() {
    return TextFormField(
      controller: _dateController,
      decoration: InputDecoration(
        hintText: "Date",
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
            _surveyDate = formattedDate;
            _dateController.text = formattedDate;
          });
        }
      },
      // ...
    );
  }

  Widget _startTimeTextField() {
    return TextFormField(
      controller: _startTimeController,
      decoration: InputDecoration(
        hintText: "Start Time",
        labelText: "Start Time",
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
      onTap: () async {
        FocusScope.of(context).requestFocus(new FocusNode());
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          _startTime = pickedTime.format(context);
          _startTimeController.text = pickedTime.format(context);
        }
      },
      // ...
    );
  }

  Widget _endTimeTextField() {
    return TextFormField(
      controller: _endTimeController,
      decoration: InputDecoration(
        hintText: "End Time",
        labelText: "End Time",
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
      onTap: () async {
        FocusScope.of(context).requestFocus(new FocusNode());
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          _EndTime = pickedTime.format(context);
          _endTimeController.text = pickedTime.format(context);
        }
      },
      // ...
    );
  }
  Widget _ScoreTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Score",
        labelText: "Score",
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
          return 'Please enter your Score';
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
          _score = _value;
        });
      },
    );
  }

  Widget _statusTextField() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: "Status",
        labelText: "Status",
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
      items: <String>['Passed', 'Failed'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _status = newValue;
        });
      },
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please select you status';
        }
        return null;
      },
      onSaved: (String? value) {
        setState(() {
          _status = value;
        });
      },
    );
  }
  Widget _scorePercentageField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Score Percentage",
        labelText: "Score Percentage",
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
          return 'Please enter the score percentage';
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
          _scorePercentage = _value;
        });
      },
    );
  }

  Widget _totalScoreField() {
    return TextFormField(
      decoration:  InputDecoration(
        hintText: "Total Score",
        labelText: "Total Score",
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
          return 'Please enter the total score';
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
          _TotalScore = _value;
        });
      },
    );
  }


  _AdaSurvey() async{
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
     bool results = await _Authentication_service!.take_Survey(
          respondent_id: _respondantID!,
          respondent_name: _respondantName!,
          survey_id: _survey_id!,
          date:  _surveyDate!,
          start_time: _startTime!,
          end_time:_EndTime!,
          score: _score!,
          status: _status!,
          total_score: _TotalScore!,
          score_percentage: _scorePercentage!
      );
      print("validated");
      if(results){
        Navigator.popAndPushNamed(context, 'survey');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Survey added successfully"),
        ),
      );
    }
  }
}