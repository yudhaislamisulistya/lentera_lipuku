class GroupChatModel {
  String code;
  String name;
  String create_at;
  String updated_at;

  GroupChatModel(this.code, this.name, this.create_at, this.updated_at);

  GroupChatModel.fromSnapshot(dynamic snapshot)
      : code = snapshot.value["code"],
        name = snapshot.value["name"],
        create_at = snapshot.value["create_at"],
        updated_at = snapshot.value["updated_at"];

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "create_at": create_at,
        "updated_at": updated_at,
      };
}
