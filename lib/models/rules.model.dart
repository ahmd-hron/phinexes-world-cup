class Rules {
  List<String>? rules;

  Rules({this.rules});

  Rules.fromJson(json) {
    rules = [];
    List<dynamic> data = json['rules'];
    data.forEach((element) {
      String rule = element.toString();
      rules!.add(rule);
    });
  }
}
