class PackageList {
  PackageList({
    required this.status,
    required this.packageList,
  });

  bool status;
  List<PackageListDatum> packageList;

  factory PackageList.fromJson(Map<String, dynamic> json) {
    return PackageList(
      status: json["status"] ?? false,
      packageList: json["package_list"] != null
          ? List<PackageListDatum>.from(
              json["package_list"].map((x) => PackageListDatum.fromJson(x)))
          : [],
    );
  }
}

class PackageListDatum {
  PackageListDatum({
    required this.packageId,
    required this.packageTypeId,
    required this.packageTypeName,
    required this.isAddon,
    required this.duration,
    required this.displayDuration,
    required this.packageName,
    required this.noOfSendInterest,
    required this.noOfHoroscopeViews,
    required this.horoscopeCompatibility,
    required this.amount,
    required this.isActive,
    required this.createdAt,
    required this.deletedAt,
    required this.createdById,
  });

  String packageId;
  String packageTypeId;
  String packageTypeName;
  String isAddon;
  String duration;
  String displayDuration;
  String packageName;
  String noOfSendInterest;
  String noOfHoroscopeViews;
  String horoscopeCompatibility;
  String amount;
  String isActive;
  String createdAt;
  dynamic deletedAt;
  String createdById;

  factory PackageListDatum.fromJson(Map<String, dynamic> json) {
    return PackageListDatum(
      packageId: json["package_id"] ?? '',
      packageTypeId: json["package_type_id"] ?? '',
      packageTypeName: json["package_type_name"] ?? '',
      isAddon: json["is_addon"] ?? '',
      duration: json["duration"] ?? '',
      displayDuration: json["display_duration"] ?? '',
      packageName: json["package_name"] ?? '',
      noOfSendInterest: json["no_of_send_interest"] ?? '',
      noOfHoroscopeViews: json["no_of_horoscope_views"] ?? '',
      horoscopeCompatibility: json["horoscope_compatibility"] ?? '',
      amount: json["amount"] ?? '',
      isActive: json["is_active"] ?? '',
      createdAt: json["created_at"] ?? '',
      deletedAt: json["deleted_at"],
      createdById: json["created_by_id"] ?? '',
    );
  }
}

class MakePayment {
  MakePayment({
    required this.status,
    required this.data,
  });

  bool status;
  MakePaymentData data;

  factory MakePayment.fromJson(Map<String, dynamic> json) => MakePayment(
        status: json["status"] ?? false,
        data: MakePaymentData.fromJson(json["data"]),
      );
}

class MakePaymentData {
  MakePaymentData({
    required this.selectedPackageData,
    required this.payableAmount,
    required this.subscribedPackages,
    required this.taxTotal,
    required this.formattedAmount,
  });

  SelectedPackageData selectedPackageData;
  int payableAmount;
  String subscribedPackages;
  int taxTotal;
  int formattedAmount;

  factory MakePaymentData.fromJson(Map<String, dynamic> json) {
    return MakePaymentData(
      selectedPackageData:
          SelectedPackageData.fromJson(json["selected_package_data"]),
      payableAmount: json["payable_amount"] ?? 0,
      subscribedPackages: json["subscribed_packages"] ?? '',
      taxTotal: json["tax_total"] ?? 0,
      formattedAmount: json["formatted_amount"] ?? 0,
    );
  }
}

class SelectedPackageData {
  SelectedPackageData({
    required this.basePackage,
  });

  BaseAddOnPackage basePackage;

  factory SelectedPackageData.fromJson(Map<String, dynamic> json) {
    return SelectedPackageData(
      basePackage: BaseAddOnPackage.fromJson(json["base_package"]),
    );
  }
}

class BaseAddOnPackage {
  BaseAddOnPackage({
    required this.packageId,
    required this.packageTypeId,
    required this.packageTypeName,
    required this.isAddon,
    required this.duration,
    required this.displayDuration,
    required this.packageName,
    required this.noOfSendInterest,
    required this.noOfHoroscopeViews,
    required this.horoscopeCompatibility,
    required this.amount,
    required this.isActive,
    required this.createdAt,
    required this.deletedAt,
    required this.createdById,
  });

  String packageId;
  String packageTypeId;
  String packageTypeName;
  String isAddon;
  String duration;
  String displayDuration;
  dynamic packageName;
  String noOfSendInterest;
  String noOfHoroscopeViews;
  String horoscopeCompatibility;
  String amount;
  String isActive;
  String createdAt;
  dynamic deletedAt;
  String createdById;

  factory BaseAddOnPackage.fromJson(Map<String, dynamic> json) {
    return BaseAddOnPackage(
      packageId: json["package_id"] ?? '',
      packageTypeId: json["package_type_id"] ?? '',
      packageTypeName: json["package_type_name"] ?? '',
      isAddon: json["is_addon"] ?? '',
      duration: json["duration"] ?? '',
      displayDuration: json["display_duration"] ?? '',
      packageName: json["package_name"] ?? '',
      noOfSendInterest: json["no_of_send_interest"] ?? '',
      noOfHoroscopeViews: json["no_of_horoscope_views"] ?? '',
      horoscopeCompatibility: json["horoscope_compatibility"] ?? '',
      amount: json["amount"] ?? '',
      isActive: json["is_active"] ?? '',
      createdAt: json["created_at"] ?? '',
      deletedAt: json["deleted_at"] ?? '',
      createdById: json["created_by_id"] ?? '',
    );
  }
}

class ReportPaymentData {
  ReportPaymentData({
    required this.status,
    required this.message,
  });

  final bool status;
  final String message;

  factory ReportPaymentData.fromJson(Map<String, dynamic> json) {
    return ReportPaymentData(
      status: json["status"] ?? '',
      message: json["message"] ?? '',
    );
  }
}

class PDFInvoice {
  PDFInvoice({
    required this.status,
    required this.message,
  });

  bool status;
  PDFInvoiceMessage message;

  factory PDFInvoice.fromJson(Map<String, dynamic> json) => PDFInvoice(
        status: json["status"] ?? false,
        message: PDFInvoiceMessage.fromJson(json["message"]),
      );
}

class PDFInvoiceMessage {
  PDFInvoiceMessage({
    required this.invoiceDetails,
    required this.newDate,
    required this.product,
    required this.total,
    required this.grandTotal,
    required this.amountInWords,
  });

  List<InvoiceDetail> invoiceDetails;
  String newDate;
  List<Product> product;
  List<Total> total;
  String grandTotal;
  String amountInWords;

  factory PDFInvoiceMessage.fromJson(Map<String, dynamic> json) =>
      PDFInvoiceMessage(
        invoiceDetails: json["invoice_details"] == null
            ? []
            : List<InvoiceDetail>.from(
                json["invoice_details"].map((x) => InvoiceDetail.fromJson(x))),
        newDate: json["new_date"] ?? '',
        product: json["product"] == null
            ? []
            : List<Product>.from(
                json["product"].map((x) => Product.fromJson(x))),
        total: json["total"] == null
            ? []
            : List<Total>.from(json["total"].map((x) => Total.fromJson(x))),
        grandTotal: json["grand_total"] ?? '',
        amountInWords: json["amount_in_Words"] ?? '',
      );
}

class InvoiceDetail {
  InvoiceDetail({
    required this.id,
    required this.profileNo,
    required this.firstname,
    required this.phone,
    required this.email,
    required this.amount,
    required this.status,
    required this.txnid,
    required this.subsribedDate,
    required this.productinfo,
  });

  String id;
  String profileNo;
  String firstname;
  String phone;
  String email;
  String amount;
  String status;
  String txnid;
  String subsribedDate;
  String productinfo;

  factory InvoiceDetail.fromJson(Map<String, dynamic> json) => InvoiceDetail(
        id: json["id"] ?? '',
        profileNo: json["profile_no"] ?? '',
        firstname: json["firstname"] ?? '',
        phone: json["phone"] ?? '',
        email: json["email"] ?? '',
        amount: json["amount"] ?? '',
        status: json["status"] ?? '',
        txnid: json["txnid"] ?? '',
        subsribedDate: json["subsribed_date"] ?? '',
        productinfo: json["productinfo"] ?? '',
      );
}

class Product {
  Product({
    required this.packageId,
    required this.packageTypeId,
    required this.duration,
    required this.displayDuration,
    required this.packageName,
    required this.noOfSendInterest,
    required this.noOfHoroscopeViews,
    required this.horoscopeCompatibility,
    required this.amount,
    required this.isActive,
    required this.createdAt,
    required this.deletedAt,
    required this.createdById,
  });

  String packageId;
  String packageTypeId;
  String duration;
  String displayDuration;
  String packageName;
  String noOfSendInterest;
  String noOfHoroscopeViews;
  String horoscopeCompatibility;
  String amount;
  String isActive;
  String createdAt;
  dynamic deletedAt;
  String createdById;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        packageId: json["package_id"] ?? '',
        packageTypeId: json["package_type_id"] ?? '',
        duration: json["duration"] ?? '',
        displayDuration: json["display_duration"] ?? '',
        packageName: json["package_name"] ?? '',
        noOfSendInterest: json["no_of_send_interest"] ?? '',
        noOfHoroscopeViews: json["no_of_horoscope_views"] ?? '',
        horoscopeCompatibility: json["horoscope_compatibility"] ?? '',
        amount: json["amount"] ?? '',
        isActive: json["is_active"] ?? '',
        createdAt: json["created_at"] ?? '',
        deletedAt: json["deleted_at"] ?? '',
        createdById: json["created_by_id"] ?? '',
      );
}

class Total {
  Total({
    required this.sumPackagesAmount,
  });

  String sumPackagesAmount;

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        sumPackagesAmount: json["SUM(packages.amount)"] ?? '',
      );
}
