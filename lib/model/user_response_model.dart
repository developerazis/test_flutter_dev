class UserResponse {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<User>? data;

  UserResponse(
      {this.page,
        this.perPage,
        this.total,
        this.totalPages,
        this.data,
      });

  UserResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['data'] != null) {
      data = <User>[];
      json['data'].asMap().forEach((index,val) {
        data!.add(User.fromJson(val, stock: index % 2 == 0 ? 10 : 0));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['per_page'] = perPage;
    data['total'] = total;
    data['total_pages'] = totalPages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? email;
  String? name;
  String? firstName;
  String? lastName;
  String? avatar;
  String? job;
  String? createdDate;
  late int stock;

  User({this.id, this.email, this.firstName, this.lastName, this.avatar, this.stock = 0});

  User.fromJson(Map<String, dynamic> json, {this.stock = 0}) {
    id = json['id'] is String ? int.parse(json['id']) : json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
    name = json['name'];
    job = json['job'];
    createdDate = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['avatar'] = avatar;
    data['name'] = name;
    data['job'] = job;
    data['createdAt'] = createdDate;
    return data;
  }
}
