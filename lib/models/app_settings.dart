class AppSettings {
  final String currency;
  final String language;
  final bool pushNotifications;
  final bool emailAlerts;
  final bool budgetExceeded;
  final bool nearLimit;
  final bool weeklySummary;
  final bool newFeatures;
  final bool securityAlerts;
  final bool biometricLogin;
  final bool twoStepVerification;
  final bool dataSharing;

  AppSettings({
    this.currency = 'USD',
    this.language = 'English',
    this.pushNotifications = true,
    this.emailAlerts = true,
    this.budgetExceeded = true,
    this.nearLimit = true,
    this.weeklySummary = false,
    this.newFeatures = true,
    this.securityAlerts = true,
    this.biometricLogin = true,
    this.twoStepVerification = false,
    this.dataSharing = false,
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      currency: json['currency'] ?? 'USD',
      language: json['language'] ?? 'English',
      pushNotifications: json['pushNotifications'] ?? true,
      emailAlerts: json['emailAlerts'] ?? true,
      budgetExceeded: json['budgetExceeded'] ?? true,
      nearLimit: json['nearLimit'] ?? true,
      weeklySummary: json['weeklySummary'] ?? false,
      newFeatures: json['newFeatures'] ?? true,
      securityAlerts: json['securityAlerts'] ?? true,
      biometricLogin: json['biometricLogin'] ?? true,
      twoStepVerification: json['twoStepVerification'] ?? false,
      dataSharing: json['dataSharing'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currency': currency,
      'language': language,
      'pushNotifications': pushNotifications,
      'emailAlerts': emailAlerts,
      'budgetExceeded': budgetExceeded,
      'nearLimit': nearLimit,
      'weeklySummary': weeklySummary,
      'newFeatures': newFeatures,
      'securityAlerts': securityAlerts,
      'biometricLogin': biometricLogin,
      'twoStepVerification': twoStepVerification,
      'dataSharing': dataSharing,
    };
  }

  AppSettings copyWith({
    String? currency,
    String? language,
    bool? pushNotifications,
    bool? emailAlerts,
    bool? budgetExceeded,
    bool? nearLimit,
    bool? weeklySummary,
    bool? newFeatures,
    bool? securityAlerts,
    bool? biometricLogin,
    bool? twoStepVerification,
    bool? dataSharing,
  }) {
    return AppSettings(
      currency: currency ?? this.currency,
      language: language ?? this.language,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      emailAlerts: emailAlerts ?? this.emailAlerts,
      budgetExceeded: budgetExceeded ?? this.budgetExceeded,
      nearLimit: nearLimit ?? this.nearLimit,
      weeklySummary: weeklySummary ?? this.weeklySummary,
      newFeatures: newFeatures ?? this.newFeatures,
      securityAlerts: securityAlerts ?? this.securityAlerts,
      biometricLogin: biometricLogin ?? this.biometricLogin,
      twoStepVerification: twoStepVerification ?? this.twoStepVerification,
      dataSharing: dataSharing ?? this.dataSharing,
    );
  }
}
