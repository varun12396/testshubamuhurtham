class HardCodeData {
  static List<String> gender = ['Male', 'Female'];
  static List<String> sibling = ['0', '1', '2', '3', '4'];
  static List<String> profileby = ['Self', 'Parents', 'Friends', 'Relatives'];
  static List<String> dosham = ['No', 'Chevvai Dosham', 'Rahu Ketu Dosham'];
  static List<String> selectSort = [
    'Recent Upload Profile',
    'Ascending',
    'Descending'
  ];
  static List<String> weight = [for (int i = 35; i <= 150; i++) i.toString()];
  static List<String> userAge = [for (int i = 18; i <= 50; i++) i.toString()];
  static List<String> deleteprofile = [
    'Marriage Fixed',
    'Not getting enough matches',
    'Too many notifications',
    'Prefer to search later',
    'I wish not to specify',
  ];

  static List<GallerySetting> gallerysettingData = [
    GallerySetting(id: 'SA', textName: 'Show All'),
    GallerySetting(id: '1', textName: 'Show With Photos'),
    GallerySetting(id: '0', textName: 'Show Without Photos'),
  ];

  static List<JobType> jobTypeList = [
    JobType(id: 'state', textName: 'State Goverment Job'),
    JobType(id: 'cetral', textName: 'Central Goverment Job'),
    JobType(id: 'private', textName: 'Private Limited Job '),
    JobType(id: 'business', textName: 'Business'),
  ];

  static List<HoroscopeSetting> horoscopesettingData = [
    HoroscopeSetting(id: 'G', textName: 'Generated Horoscope'),
    HoroscopeSetting(id: 'M', textName: 'Uploaded Horoscope'),
  ];

  static List<SalaryData> salaryData = [
    SalaryData(id: '1', textName: 'Below 3 L.P.A.'),
    SalaryData(id: '2', textName: '3.01 - 4.00 L.P.A.'),
    SalaryData(id: '3', textName: '4.01 - 5.00 L.P.A.'),
    SalaryData(id: '4', textName: '5.01 - 6.00 L.P.A.'),
    SalaryData(id: '5', textName: '6.01 - 7.00 L.P.A.'),
    SalaryData(id: '6', textName: '7.01 - 8.00 L.P.A.'),
    SalaryData(id: '7', textName: '8.01 - 9.00 L.P.A.'),
    SalaryData(id: '8', textName: '9.01 - 10.00 L.P.A.'),
    SalaryData(id: '9', textName: '10.01 - 11.00 L.P.A.'),
    SalaryData(id: '10', textName: '11.01 - 12.00 L.P.A.'),
    SalaryData(id: '11', textName: 'Above 12.01 L.P.A.'),
  ];

  static List<MaritalData> maritalData = [
    MaritalData(id: 'A', textName: 'Any'),
    MaritalData(id: 'U', textName: 'Single'),
    MaritalData(id: 'D', textName: 'Divorced'),
    MaritalData(id: 'S', textName: 'Separated'),
    MaritalData(id: 'W', textName: 'Widow/Widower'),
  ];

  static List<FamilyValueData> familyValueData = [
    FamilyValueData(id: 'L', textName: 'Liberal'),
    FamilyValueData(id: 'M', textName: 'Moderate'),
    FamilyValueData(id: 'O', textName: 'Orthodox'),
    FamilyValueData(id: 'T', textName: 'Traditional'),
  ];

  static List<FamilyTypeData> familyTypeData = [
    FamilyTypeData(id: 'JF', textName: 'Joint family'),
    FamilyTypeData(id: 'NF', textName: 'Nuclear family'),
    FamilyTypeData(id: 'O', textName: 'Others'),
  ];

  static List<PhysicalStatusData> physicalStatusData = [
    PhysicalStatusData(id: 'A', textName: 'Any'),
    PhysicalStatusData(id: 'N', textName: 'Normal'),
    PhysicalStatusData(id: 'p', textName: 'Physically Challenged'),
  ];

  static List<ZodiacData> zodiaclist = [
    ZodiacData(id: '1', textName: 'Aries - மேஷம்'),
    ZodiacData(id: '2', textName: 'Taurus - ரிஷபம்'),
    ZodiacData(id: '3', textName: 'Gemini - மிதுனம்'),
    ZodiacData(id: '4', textName: 'Cancer - கடகம்'),
    ZodiacData(id: '5', textName: 'Leo - சிம்மம்'),
    ZodiacData(id: '6', textName: 'Virgo - கன்னி'),
    ZodiacData(id: '7', textName: 'Libra - துலாம்'),
    ZodiacData(id: '8', textName: 'Scorpio - விருச்சிகம்'),
    ZodiacData(id: '9', textName: 'Sagittarius - தனுசு'),
    ZodiacData(id: '10', textName: 'Capricorn - மகரம்'),
    ZodiacData(id: '11', textName: 'Aquarius - கும்பம்'),
    ZodiacData(id: '12', textName: 'Pisces - மீனம்'),
  ];

  static List<StarType> startypedata = [
    StarType(id: "1", textName: "Aswini - அஸ்வினி"),
    StarType(id: "2", textName: "Barani - பரணி"),
    StarType(id: "3", textName: "Karthikai - கார்த்திகை"),
    StarType(id: "4", textName: "Rohini - ரோகிணி"),
    StarType(id: "5", textName: "Mirugasiridam - மிருகசீரிடம்"),
    StarType(id: "6", textName: "Thiruvadhirai - திருவாதிரை"),
    StarType(id: "7", textName: "Punarpoosam - புனர்பூசம்"),
    StarType(id: "8", textName: "Poosam - பூசம்"),
    StarType(id: "9", textName: "Ayilyam - ஆயில்யம்"),
    StarType(id: "10", textName: "Magam - மகம்"),
    StarType(id: "11", textName: "Pooram - பூரம்"),
    StarType(id: "12", textName: "Uthiram - உத்திரம்"),
    StarType(id: "13", textName: "Astham - அஸ்தம்"),
    StarType(id: "14", textName: "Chithirai - சித்திரை"),
    StarType(id: "15", textName: "Swathi - சுவாதி"),
    StarType(id: "16", textName: "Visakam - விசாகம்"),
    StarType(id: "17", textName: "Anusham - அனுஷம்"),
    StarType(id: "18", textName: "Kettai - கேட்டை"),
    StarType(id: "19", textName: "Mulam - மூலம்"),
    StarType(id: "20", textName: "Puradam - பூராடம்"),
    StarType(id: "21", textName: "Uthiradam - உத்திராடம்"),
    StarType(id: "22", textName: "Tiruvonam - திருவோணம்"),
    StarType(id: "23", textName: "Avittam - அவிட்டம்"),
    StarType(id: "24", textName: "Sadayam - சதயம்"),
    StarType(id: "25", textName: "Purattadhi - பூரட்டாதி"),
    StarType(id: "26", textName: "Uttrttadhi - உத்திரட்டாதி"),
    StarType(id: "27", textName: "Revathi - ரேவதி"),
  ];

  static List<AnnualIncome> annualincomedata = [
    AnnualIncome(id: "1", textName: "N/A</option>"),
    AnnualIncome(id: "49999", textName: "less than 50000"),
    AnnualIncome(id: "99999", textName: "50000-1 lakh"),
    AnnualIncome(id: "149999", textName: "1 lakh- 1.5 lakhs"),
    AnnualIncome(id: "199999", textName: "1.5 lakhs- 2 lakhs"),
    AnnualIncome(id: "299999", textName: "2 lakhs- 3 lakhs"),
    AnnualIncome(id: "399999", textName: "3 lakhs- 4 lakhs"),
    AnnualIncome(id: "499999", textName: "4 lakhs- 5 lakhs"),
    AnnualIncome(id: "599999", textName: "5 lakhs-6 lakhs"),
    AnnualIncome(id: "699999", textName: "6 lakhs-7 lakhs"),
    AnnualIncome(id: "799999", textName: "7 lakhs-8 lakhs"),
    AnnualIncome(id: "899999", textName: "8 lakhs-9 lakhs"),
    AnnualIncome(id: "999999", textName: "9 lakhs-10 lakhs"),
    AnnualIncome(id: "1199999", textName: "10 lakhs-12 lakhs"),
    AnnualIncome(id: "1499999", textName: "12 lakhs-15 lakhs"),
    AnnualIncome(id: "1999999", textName: "15 lakhs-20 lakhs"),
    AnnualIncome(id: "2999999", textName: "20 lakhs-30 lakhs"),
    AnnualIncome(id: "3999999", textName: "30 lakhs-40 lakhs"),
    AnnualIncome(id: "4999999", textName: "40 lakhs-50 lakhs"),
    AnnualIncome(id: "9999999", textName: "50 lakhs-1 crore"),
    AnnualIncome(id: "10000000", textName: "1 crore and above"),
  ];
}

class JobType {
  String id;
  String textName;
  JobType({required this.id, required this.textName});
}

class GallerySetting {
  String id;
  String textName;
  GallerySetting({required this.id, required this.textName});
}

class HoroscopeSetting {
  String id;
  String textName;
  HoroscopeSetting({required this.id, required this.textName});
}

class SalaryData {
  String id;
  String textName;
  SalaryData({required this.id, required this.textName});
}

class MaritalData {
  String id;
  String textName;
  MaritalData({required this.id, required this.textName});
}

class FamilyValueData {
  String id;
  String textName;
  FamilyValueData({required this.id, required this.textName});
}

class FamilyTypeData {
  String id;
  String textName;
  FamilyTypeData({required this.id, required this.textName});
}

class PhysicalStatusData {
  String id;
  String textName;
  PhysicalStatusData({required this.id, required this.textName});
}

class ZodiacData {
  String id;
  String textName;
  ZodiacData({required this.id, required this.textName});
}

class StarType {
  String id;
  String textName;
  StarType({required this.id, required this.textName});
}

class AnnualIncome {
  String id;
  String textName;
  AnnualIncome({required this.id, required this.textName});
}
