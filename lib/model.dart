class Report {
  String? retCode;
  String? message;
  List<Data>? data;

  Report({this.retCode, this.message, this.data});

  Report.fromJson(Map<String, dynamic> json) {
    retCode = json['retCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['retCode'] = this.retCode;
    data['message'] = this.message;

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? amount;
  int? cid;
  String? pushedDate;
  String? refId;
  String? status;
  String? transactedDate;

  Data(
      {this.amount,
      this.cid,
      this.pushedDate,
      this.refId,
      this.status,
      this.transactedDate});

  Data.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    cid = json['cid'];
    pushedDate = json['pushed_date'];
    refId = json['ref_id'];
    status = json['status'];
    transactedDate = json['transacted_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['cid'] = this.cid;
    data['pushed_date'] = this.pushedDate;
    data['ref_id'] = this.refId;
    data['status'] = this.status;
    data['transacted_date'] = this.transactedDate;
    return data;
  }
}
