class AllOrderModel {
  int? id;
  int? quantity;
  int? price;
  Null? discount;
  Null? vAT;
  String? orderDateAndTime;
  User? user;
  Payment? payment;
  OrderStatus? orderStatus;

  AllOrderModel(
      {this.id,
        this.quantity,
        this.price,
        this.discount,
        this.vAT,
        this.orderDateAndTime,
        this.user,
        this.payment,
        this.orderStatus});

  AllOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    price = json['price'];
    discount = json['discount'];
    vAT = json['VAT'];
    orderDateAndTime = json['order_date_and_time'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    payment =
    json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
    orderStatus = json['order_status'] != null
        ? new OrderStatus.fromJson(json['order_status'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['VAT'] = this.vAT;
    data['order_date_and_time'] = this.orderDateAndTime;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.payment != null) {
      data['payment'] = this.payment!.toJson();
    }
    if (this.orderStatus != null) {
      data['order_status'] = this.orderStatus!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;

  User({this.id, this.name});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Payment {
  int? paymentStatus;

  Payment({this.paymentStatus});

  Payment.fromJson(Map<String, dynamic> json) {
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_status'] = this.paymentStatus;
    return data;
  }
}

class OrderStatus {
  User? orderStatusCategory;

  OrderStatus({this.orderStatusCategory});

  OrderStatus.fromJson(Map<String, dynamic> json) {
    orderStatusCategory = json['order_status_category'] != null
        ? new User.fromJson(json['order_status_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderStatusCategory != null) {
      data['order_status_category'] = this.orderStatusCategory!.toJson();
    }
    return data;
  }
}
