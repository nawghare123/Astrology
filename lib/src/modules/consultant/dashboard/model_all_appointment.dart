// class MentorAllAppointmentModel {
//   MentorAllAppointmentModel({
//     bool? status,
//     int? success,
//     MentorAllAppointmentModelData? data,
//     String? msg,}){
//     _status = status;
//     _success = success;
//     _data = data;
//     _msg = msg;
//   }
//
//   MentorAllAppointmentModel.fromJson(dynamic json) {
//     _status = json['Status'];
//     _success = json['success'];
//     _data = json['data'] != null ? MentorAllAppointmentModelData.fromJson(json['data']) : null;
//     _msg = json['msg'];
//   }
//   bool? _status;
//   int? _success;
//   MentorAllAppointmentModelData? _data;
//   String? _msg;
//
//   bool? get status => _status;
//   int? get success => _success;
//   MentorAllAppointmentModelData? get data => _data;
//   String? get msg => _msg;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['Status'] = _status;
//     map['success'] = _success;
//     if (_data != null) {
//       map['data'] = _data?.toJson();
//     }
//     map['msg'] = _msg;
//     return map;
//   }
//
// }
//
// class MentorAllAppointmentModelData {
//   MentorAllAppointmentModelData({
//     Appointments? appointments,}){
//     _appointments = appointments;
//   }
//
//   MentorAllAppointmentModelData.fromJson(dynamic json) {
//     _appointments = json['Appointments'] != null ? Appointments.fromJson(json['Appointments']) : null;
//   }
//   Appointments? _appointments;
//
//   Appointments? get appointments => _appointments;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (_appointments != null) {
//       map['Appointments'] = _appointments?.toJson();
//     }
//     return map;
//   }
//
// }
//
// class Appointments {
//   Appointments({
//     int? currentPage,
//     List<MentorSingleAppointmentModel>? data,
//     String? firstPageUrl,
//     int? from,
//     int? lastPage,
//     String? lastPageUrl,
//     List<Links>? links,
//     dynamic nextPageUrl,
//     String? path,
//     int? perPage,
//     dynamic prevPageUrl,
//     int? to,
//     int? total,}){
//     _currentPage = currentPage;
//     _data = data;
//     _firstPageUrl = firstPageUrl;
//     _from = from;
//     _lastPage = lastPage;
//     _lastPageUrl = lastPageUrl;
//     _links = links;
//     _nextPageUrl = nextPageUrl;
//     _path = path;
//     _perPage = perPage;
//     _prevPageUrl = prevPageUrl;
//     _to = to;
//     _total = total;
//   }
//
//   Appointments.fromJson(dynamic json) {
//     _currentPage = json['current_page'];
//     if (json['data'] != null) {
//       _data = [];
//       json['data'].forEach((v) {
//         _data?.add(MentorSingleAppointmentModel.fromJson(v));
//       });
//     }
//     _firstPageUrl = json['first_page_url'];
//     _from = json['from'];
//     _lastPage = json['last_page'];
//     _lastPageUrl = json['last_page_url'];
//     if (json['links'] != null) {
//       _links = [];
//       json['links'].forEach((v) {
//         _links?.add(Links.fromJson(v));
//       });
//     }
//     _nextPageUrl = json['next_page_url'];
//     _path = json['path'];
//     _perPage = json['per_page'];
//     _prevPageUrl = json['prev_page_url'];
//     _to = json['to'];
//     _total = json['total'];
//   }
//   int? _currentPage;
//   List<MentorSingleAppointmentModel>? _data;
//   String? _firstPageUrl;
//   int? _from;
//   int? _lastPage;
//   String? _lastPageUrl;
//   List<Links>? _links;
//   dynamic _nextPageUrl;
//   String? _path;
//   int? _perPage;
//   dynamic _prevPageUrl;
//   int? _to;
//   int? _total;
//
//   int? get currentPage => _currentPage;
//   List<MentorSingleAppointmentModel>? get data => _data;
//   String? get firstPageUrl => _firstPageUrl;
//   int? get from => _from;
//   int? get lastPage => _lastPage;
//   String? get lastPageUrl => _lastPageUrl;
//   List<Links>? get links => _links;
//   dynamic get nextPageUrl => _nextPageUrl;
//   String? get path => _path;
//   int? get perPage => _perPage;
//   dynamic get prevPageUrl => _prevPageUrl;
//   int? get to => _to;
//   int? get total => _total;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['current_page'] = _currentPage;
//     if (_data != null) {
//       map['data'] = _data?.map((v) => v.toJson()).toList();
//     }
//     map['first_page_url'] = _firstPageUrl;
//     map['from'] = _from;
//     map['last_page'] = _lastPage;
//     map['last_page_url'] = _lastPageUrl;
//     if (_links != null) {
//       map['links'] = _links?.map((v) => v.toJson()).toList();
//     }
//     map['next_page_url'] = _nextPageUrl;
//     map['path'] = _path;
//     map['per_page'] = _perPage;
//     map['prev_page_url'] = _prevPageUrl;
//     map['to'] = _to;
//     map['total'] = _total;
//     return map;
//   }
//
// }
//
// class Links {
//   Links({
//     dynamic url,
//     String? label,
//     bool? active,}){
//     _url = url;
//     _label = label;
//     _active = active;
//   }
//
//   Links.fromJson(dynamic json) {
//     _url = json['url'];
//     _label = json['label'];
//     _active = json['active'];
//   }
//   dynamic _url;
//   String? _label;
//   bool? _active;
//
//   dynamic get url => _url;
//   String? get label => _label;
//   bool? get active => _active;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['url'] = _url;
//     map['label'] = _label;
//     map['active'] = _active;
//     return map;
//   }
//
// }
//
// class MentorSingleAppointmentModel {
//   MentorSingleAppointmentModel({
//     int? id,
//     int? menteeId,
//     int? mentorId,
//     String? date,
//     String? time,
//     int? payment,
//     int? isPaid,
//     dynamic paymentStatusCode,
//     dynamic paymentResponseMsg,
//     dynamic paymentOrderRef,
//     int? paymentId,
//     String? appointmentTypeString,
//     int? appointmentTypeId,
//     String? questions,
//     String? file,
//     String? fileType,
//     int? appointmentStatus,
//     String? createdAt,
//     String? updatedAt,
//     String? endTime,
//     Mentee? mentee,}){
//     _id = id;
//     _menteeId = menteeId;
//     _mentorId = mentorId;
//     _date = date;
//     _time = time;
//     _payment = payment;
//     _isPaid = isPaid;
//     _paymentStatusCode = paymentStatusCode;
//     _paymentResponseMsg = paymentResponseMsg;
//     _paymentOrderRef = paymentOrderRef;
//     _paymentId = paymentId;
//     _appointmentTypeString = appointmentTypeString;
//     _appointmentTypeId = appointmentTypeId;
//     _questions = questions;
//     _file = file;
//     _fileType = fileType;
//     _appointmentStatus = appointmentStatus;
//     _createdAt = createdAt;
//     _updatedAt = updatedAt;
//     _endTime = endTime;
//     _mentee = mentee;
//   }
//
//   MentorSingleAppointmentModel.fromJson(dynamic json) {
//     _id = json['id'];
//     _menteeId = json['mentee_id'];
//     _mentorId = json['mentor_id'];
//     _date = json['date'];
//     _time = json['time'];
//     _payment = json['payment'];
//     _isPaid = json['is_paid'];
//     _paymentStatusCode = json['payment_status_code'];
//     _paymentResponseMsg = json['payment_response_msg'];
//     _paymentOrderRef = json['payment_order_ref'];
//     _paymentId = json['payment_id'];
//     _appointmentTypeString = json['appointment_type_string'];
//     _appointmentTypeId = json['appointment_type_id'];
//     _questions = json['questions'];
//     _file = json['file'];
//     _fileType = json['file_type'];
//     _appointmentStatus = json['appointment_status'];
//     _createdAt = json['created_at'];
//     _updatedAt = json['updated_at'];
//     _endTime = json['end_time'];
//     _mentee = json['mentee'] != null ? Mentee.fromJson(json['mentee']) : null;
//   }
//   int? _id;
//   int? _menteeId;
//   int? _mentorId;
//   String? _date;
//   String? _time;
//   int? _payment;
//   int? _isPaid;
//   dynamic _paymentStatusCode;
//   dynamic _paymentResponseMsg;
//   dynamic _paymentOrderRef;
//   int? _paymentId;
//   String? _appointmentTypeString;
//   int? _appointmentTypeId;
//   String? _questions;
//   String? _file;
//   String? _fileType;
//   int? _appointmentStatus;
//   String? _createdAt;
//   String? _updatedAt;
//   String? _endTime;
//   Mentee? _mentee;
//
//   int? get id => _id;
//   int? get menteeId => _menteeId;
//   int? get mentorId => _mentorId;
//   String? get date => _date;
//   String? get time => _time;
//   int? get payment => _payment;
//   int? get isPaid => _isPaid;
//   dynamic get paymentStatusCode => _paymentStatusCode;
//   dynamic get paymentResponseMsg => _paymentResponseMsg;
//   dynamic get paymentOrderRef => _paymentOrderRef;
//   int? get paymentId => _paymentId;
//   String? get appointmentTypeString => _appointmentTypeString;
//   int? get appointmentTypeId => _appointmentTypeId;
//   String? get questions => _questions;
//   String? get file => _file;
//   String? get fileType => _fileType;
//   int? get appointmentStatus => _appointmentStatus;
//   String? get createdAt => _createdAt;
//   String? get updatedAt => _updatedAt;
//   String? get endTime => _endTime;
//   Mentee? get mentee => _mentee;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['mentee_id'] = _menteeId;
//     map['mentor_id'] = _mentorId;
//     map['date'] = _date;
//     map['time'] = _time;
//     map['payment'] = _payment;
//     map['is_paid'] = _isPaid;
//     map['payment_status_code'] = _paymentStatusCode;
//     map['payment_response_msg'] = _paymentResponseMsg;
//     map['payment_order_ref'] = _paymentOrderRef;
//     map['payment_id'] = _paymentId;
//     map['appointment_type_string'] = _appointmentTypeString;
//     map['appointment_type_id'] = _appointmentTypeId;
//     map['questions'] = _questions;
//     map['file'] = _file;
//     map['file_type'] = _fileType;
//     map['appointment_status'] = _appointmentStatus;
//     map['created_at'] = _createdAt;
//     map['updated_at'] = _updatedAt;
//     map['end_time'] = _updatedAt;
//     if (_mentee != null) {
//       map['mentee'] = _mentee?.toJson();
//     }
//     return map;
//   }
//
// }
//
// class Mentee {
//   Mentee({
//     int? id,
//     String? firstName,
//     String? lastName,
//     String? email,
//     String? phone,
//     String? imagePath,
//     int? country,
//     String? city,
//     dynamic address,
//     dynamic postalCode,
//     dynamic isOtpVerified,
//     dynamic fatherName,
//     dynamic cnic,
//     String? gender,
//     dynamic religion,
//     String? dob,
//     dynamic occupation,
//     String? onlineStatus,
//     String? createdAt,
//     String? updatedAt,
//     MenteeIdentityHiddenModel? mentee,}){
//     _id = id;
//     _firstName = firstName;
//     _lastName = lastName;
//     _email = email;
//     _phone = phone;
//     _imagePath = imagePath;
//     _country = country;
//     _city = city;
//     _address = address;
//     _postalCode = postalCode;
//     _isOtpVerified = isOtpVerified;
//     _fatherName = fatherName;
//     _cnic = cnic;
//     _gender = gender;
//     _religion = religion;
//     _dob = dob;
//     _occupation = occupation;
//     _onlineStatus = onlineStatus;
//     _createdAt = createdAt;
//     _updatedAt = updatedAt;
//     _mentee = mentee;
//   }
//
//   Mentee.fromJson(dynamic json) {
//     _id = json['id'];
//     _firstName = json['first_name'];
//     _lastName = json['last_name'];
//     _email = json['email'];
//     _phone = json['phone'];
//     _imagePath = json['image_path'];
//     _country = json['country'];
//     _city = json['city'];
//     _address = json['address'];
//     _postalCode = json['postal_code'];
//     _isOtpVerified = json['is_otp_verified'];
//     _fatherName = json['father_name'];
//     _cnic = json['cnic'];
//     _gender = json['gender'];
//     _religion = json['religion'];
//     _dob = json['dob'];
//     _occupation = json['occupation'];
//     _onlineStatus = json['online_status'];
//     _createdAt = json['created_at'];
//     _updatedAt = json['updated_at'];
//     _mentee = json['mentee'] != null ? MenteeIdentityHiddenModel.fromJson(json['mentee']) : null;
//   }
//   int? _id;
//   String? _firstName;
//   String? _lastName;
//   String? _email;
//   String? _phone;
//   String? _imagePath;
//   int? _country;
//   String? _city;
//   dynamic _address;
//   dynamic _postalCode;
//   dynamic _isOtpVerified;
//   dynamic _fatherName;
//   dynamic _cnic;
//   String? _gender;
//   dynamic _religion;
//   String? _dob;
//   dynamic _occupation;
//   String? _onlineStatus;
//   String? _createdAt;
//   String? _updatedAt;
//   MenteeIdentityHiddenModel? _mentee;
//
//   int? get id => _id;
//   String? get firstName => _firstName;
//   String? get lastName => _lastName;
//   String? get email => _email;
//   String? get phone => _phone;
//   String? get imagePath => _imagePath;
//   int? get country => _country;
//   String? get city => _city;
//   dynamic get address => _address;
//   dynamic get postalCode => _postalCode;
//   dynamic get isOtpVerified => _isOtpVerified;
//   dynamic get fatherName => _fatherName;
//   dynamic get cnic => _cnic;
//   String? get gender => _gender;
//   dynamic get religion => _religion;
//   String? get dob => _dob;
//   dynamic get occupation => _occupation;
//   String? get onlineStatus => _onlineStatus;
//   String? get createdAt => _createdAt;
//   String? get updatedAt => _updatedAt;
//   MenteeIdentityHiddenModel? get mentee => _mentee;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['first_name'] = _firstName;
//     map['last_name'] = _lastName;
//     map['email'] = _email;
//     map['phone'] = _phone;
//     map['image_path'] = _imagePath;
//     map['country'] = _country;
//     map['city'] = _city;
//     map['address'] = _address;
//     map['postal_code'] = _postalCode;
//     map['is_otp_verified'] = _isOtpVerified;
//     map['father_name'] = _fatherName;
//     map['cnic'] = _cnic;
//     map['gender'] = _gender;
//     map['religion'] = _religion;
//     map['dob'] = _dob;
//     map['occupation'] = _occupation;
//     map['online_status'] = _onlineStatus;
//     map['created_at'] = _createdAt;
//     map['updated_at'] = _updatedAt;
//     if (_mentee != null) {
//       map['mentee'] = _mentee?.toJson();
//     }
//     return map;
//   }
//
// }

class MenteeIdentityHiddenModel {
  MenteeIdentityHiddenModel({
    int? identityHidden,
    int? userId,}){
    _identityHidden = identityHidden;
    _userId = userId;
  }

  MenteeIdentityHiddenModel.fromJson(dynamic json) {
    _identityHidden = json['identity_hidden'];
    _userId = json['user_id'];
  }
  int? _identityHidden;
  int? _userId;

  int? get identityHidden => _identityHidden;
  int? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['identity_hidden'] = _identityHidden;
    map['user_id'] = _userId;
    return map;
  }
}