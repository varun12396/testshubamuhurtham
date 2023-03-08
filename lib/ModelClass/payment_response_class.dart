import 'dart:convert';

PaymentResponse responseFromJson(String str) => PaymentResponse.fromJson(json.decode(str));

class PaymentResponse {
  PaymentResponse({
    required this.id,
    required this.mode,
    required this.status,
    required this.unmappedstatus,
    required this.key,
    required this.txnid,
    required this.transactionFee,
    required this.amount,
    required this.discount,
    required this.addedon,
    required this.productinfo,
    required this.firstname,
    required this.email,
    required this.phone,
    required this.udf1,
    required this.udf2,
    required this.udf3,
    required this.udf4,
    required this.udf5,
    required this.hash,
    required this.field1,
    required this.field2,
    required this.field3,
    required this.field4,
    required this.field5,
    required this.field6,
    required this.field7,
    required this.field9,
    required this.paymentSource,
    required this.pgType,
    required this.bankRefNo,
    required this.ibiboCode,
    required this.errorCode,
    required this.errorMessage,
    required this.isSeamless,
    required this.surl,
    required this.furl,
  });

  int id;
  String mode;
  String status;
  String unmappedstatus;
  String key;
  String txnid;
  String transactionFee;
  String amount;
  String discount;
  String addedon;
  String productinfo;
  String firstname;
  String email;
  String phone;
  String udf1;
  String udf2;
  String udf3;
  String udf4;
  String udf5;
  String hash;
  String field1;
  String field2;
  String field3;
  String field4;
  String field5;
  String field6;
  String field7;
  String field9;
  String paymentSource;
  String pgType;
  String bankRefNo;
  String ibiboCode;
  String errorCode;
  String errorMessage;
  int isSeamless;
  String surl;
  String furl;

  factory PaymentResponse.fromJson(Map<String, dynamic> json) =>
      PaymentResponse(
        id: json["id"] ?? 0,
        mode: json["mode"] ?? '',
        status: json["status"] ?? '',
        unmappedstatus: json["unmappedstatus"] ?? '',
        key: json["key"] ?? '',
        txnid: json["txnid"] ?? '',
        transactionFee: json["transaction_fee"] ?? '',
        amount: json["amount"] ?? '',
        discount: json["discount"] ?? '',
        addedon: json["addedon"] ?? '',
        productinfo: json["productinfo"] ?? '',
        firstname: json["firstname"] ?? '',
        email: json["email"] ?? '',
        phone: json["phone"] ?? '',
        udf1: json["udf1"] ?? '',
        udf2: json["udf2"] ?? '',
        udf3: json["udf3"] ?? '',
        udf4: json["udf4"] ?? '',
        udf5: json["udf5"] ?? '',
        hash: json["hash"] ?? '',
        field1: json["field1"] ?? '',
        field2: json["field2"] ?? '',
        field3: json["field3"] ?? '',
        field4: json["field4"] ?? '',
        field5: json["field5"] ?? '',
        field6: json["field6"] ?? '',
        field7: json["field7"] ?? '',
        field9: json["field9"] ?? '',
        paymentSource: json["payment_source"] ?? '',
        pgType: json["PG_TYPE"] ?? '',
        bankRefNo: json["bank_ref_no"] ?? '',
        ibiboCode: json["ibibo_code"] ?? '',
        errorCode: json["error_code"] ?? '',
        errorMessage: json["Error_Message"] ?? '',
        isSeamless: json["is_seamless"] ?? 0,
        surl: json["surl"] ?? '',
        furl: json["furl"] ?? '',
      );
}
