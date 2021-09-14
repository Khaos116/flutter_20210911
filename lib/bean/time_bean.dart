import 'package:dart_json_mapper/dart_json_mapper.dart' show JsonMapper, jsonSerializable, JsonProperty;

////QZOutputJson={'s':'o','t':1631339067,'ip':'103.109.71.37','pos':'---','rand':'7jBwIVnTkm27cPIMHeY2dw=='};
@jsonSerializable
class TimeBean {
  @JsonProperty(name: 't')
  int time = 0;

  String ip = "";

  TimeBean(this.time, this.ip);

  @override
  String toString() {
    return JsonMapper.toJson(this);
  }
}
