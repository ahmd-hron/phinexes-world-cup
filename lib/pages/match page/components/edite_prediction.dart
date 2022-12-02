import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:world_cup/models/match.dart';
import 'package:world_cup/utility/size_config.dart';

class EditePredict extends StatefulWidget {
  final Match match;
  const EditePredict({super.key, required this.match});

  @override
  State<EditePredict> createState() => _EditePredictState();
}

class _EditePredictState extends State<EditePredict> {
  final homeTeamController = TextEditingController();
  final awayTeamController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void initState() {
    if (widget.match.hasPredicted) {
      homeTeamController.text =
          widget.match.myPredict!.homeScorePredict.toString();
      awayTeamController.text =
          widget.match.myPredict!.awayScorePredict.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    homeTeamController.dispose();
    awayTeamController.dispose();
    super.dispose();
  }

  _submitForm() {
    bool valid = _formKey.currentState!.validate();
    if (valid) {
      setState(() {
        loading = true;
      });
      widget.match
          .sendPrediction(int.parse(homeTeamController.text),
              int.parse(awayTeamController.text))
          .then((value) {
        if (value == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(milliseconds: 1000),
              content: Container(
                color: Colors.white.withOpacity(0.005),
                height: 25,
                child: Text(value ? 'Success' : 'Failed :('),
              ),
            ),
          );
        }
        if (mounted) {
          setState(() {
            loading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.08),
      elevation: 4,
      margin: const EdgeInsets.only(top: 10, right: 15, left: 15),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: getPercentScreenHeight(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.green),
                  ),
                  width: getPercentScreenWidth(25),
                  child: TextFormField(
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    controller: homeTeamController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Text(
                          widget.match.homeTeam!.nameCode!,
                          style: const TextStyle(color: Colors.black),
                        )),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                    textInputAction: TextInputAction.next,
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value here';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    }),
                  ),
                ),
                Container(
                  height: getPercentScreenHeight(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.green),
                  ),
                  width: getPercentScreenWidth(25),
                  child: TextFormField(
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    controller: awayTeamController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      label: Text(widget.match.awayTeam!.nameCode!,
                          style: const TextStyle(color: Colors.black)),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                    textInputAction: TextInputAction.next,
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a value here';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    }),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator())
                    : IconButton(
                        onPressed: _submitForm,
                        icon: const Icon(Icons.check),
                      ),
                if (!loading)
                  IconButton(
                    onPressed: widget.match.cancel,
                    icon: const Icon(Icons.cancel_outlined),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
