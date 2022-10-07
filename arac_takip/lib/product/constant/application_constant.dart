class ApplicationConstant {
  static ApplicationConstant? _instance;
  static ApplicationConstant get instance {
    // _instance ??= ApplicationConstant()._init();
    return _instance!;
  }

  ApplicationConstant._init();

  //Örnek olarak verilebilecek bir URL
  //final baseUrl = '';
}

double kZero = 0;
double kOne = 1;
