
class SettingModelResponse {
  bool? success;
  Data? data;

  SettingModelResponse({this.success, this.data});

  SettingModelResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? websiteUrl;
  String? aboutUsUrl;
  String? privacyPolicyUrl;
  String? version;
  String? contentRights;
  String? contactUsUrl;
  String? rateAppUrl;
  int? customEventActive;
  int? ratingDialogActive;
  int? videoDownloadsActive;
  int? maintenanceModeActive;
  String? marqueeText;
  int? vipPromoActive;
  String? telegramAdmin;
  String? viberContact;
  String? messengerLink;
  String? vipPricingText;
  String? vipBenefits;
  String? customEventLink;
  String? customEventImage;
  String? newAppLink;
  int? fakeUnlock;
  String? fakeAnnouncementText;
  String? fakeMarqueeText;
  String? fakeBypassCode;
  Ads? ads;

  Data(
      {this.id,
      this.websiteUrl,
      this.aboutUsUrl,
      this.privacyPolicyUrl,
      this.version,
      this.contentRights,
      this.contactUsUrl,
      this.rateAppUrl,
      this.customEventActive,
      this.ratingDialogActive,
      this.videoDownloadsActive,
      this.maintenanceModeActive,
      this.marqueeText,
      this.vipPromoActive,
      this.telegramAdmin,
      this.viberContact,
      this.messengerLink,
      this.vipPricingText,
      this.vipBenefits,
      this.customEventLink,
      this.customEventImage,
      this.newAppLink,
      this.fakeUnlock,
      this.fakeAnnouncementText,
      this.fakeMarqueeText,
      this.fakeBypassCode,
      this.ads});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    websiteUrl = json['website_url'];
    aboutUsUrl = json['about_us_url'];
    privacyPolicyUrl = json['privacy_policy_url'];
    version = json['version'];
    contentRights = json['content_rights'];
    contactUsUrl = json['contact_us_url'];
    rateAppUrl = json['rate_app_url'];
    customEventActive = json['custom_event_active'];
    ratingDialogActive = json['rating_dialog_active'];
    videoDownloadsActive = json['video_downloads_active'];
    maintenanceModeActive = json['maintenance_mode_active'];
    marqueeText = json['marquee_text'];
    vipPromoActive = json['vip_promo_active'];
    telegramAdmin = json['telegram_admin'];
    viberContact = json['viber_contact'];
    messengerLink = json['messenger_link'];
    vipPricingText = json['vip_pricing_text'];
    vipBenefits = json['vip_benefits'];
    customEventLink = json['custom_event_link'];
    customEventImage = json['custom_event_image'];
    newAppLink = json['new_app_link'];
    fakeUnlock = json['fake_unlock'];
    fakeAnnouncementText = json['fake_announcement_text'];
    fakeMarqueeText = json['fake_marquee_text'];
    fakeBypassCode = json['fake_bypass_code'];
    ads = json['ads'] != null ? new Ads.fromJson(json['ads']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['website_url'] = this.websiteUrl;
    data['about_us_url'] = this.aboutUsUrl;
    data['privacy_policy_url'] = this.privacyPolicyUrl;
    data['version'] = this.version;
    data['content_rights'] = this.contentRights;
    data['contact_us_url'] = this.contactUsUrl;
    data['rate_app_url'] = this.rateAppUrl;
    data['custom_event_active'] = this.customEventActive;
    data['rating_dialog_active'] = this.ratingDialogActive;
    data['video_downloads_active'] = this.videoDownloadsActive;
    data['maintenance_mode_active'] = this.maintenanceModeActive;
    data['marquee_text'] = this.marqueeText;
    data['vip_promo_active'] = this.vipPromoActive;
    data['telegram_admin'] = this.telegramAdmin;
    data['viber_contact'] = this.viberContact;
    data['messenger_link'] = this.messengerLink;
    data['vip_pricing_text'] = this.vipPricingText;
    data['vip_benefits'] = this.vipBenefits;
    data['custom_event_link'] = this.customEventLink;
    data['custom_event_image'] = this.customEventImage;
    data['new_app_link'] = this.newAppLink;
    data['fake_unlock'] = this.fakeUnlock;
    data['fake_announcement_text'] = this.fakeAnnouncementText;
    data['fake_marquee_text'] = this.fakeMarqueeText;
    data['fake_bypass_code'] = this.fakeBypassCode;
    if (this.ads != null) {
      data['ads'] = this.ads!.toJson();
    }
    return data;
  }
}

class Ads {
  int? id;
  String? provider;
  int? testMode;
  int? bannerActive;
  String? bannerUnitId;
  int? interstitialActive;
  String? interstitialUnitId;
  int? interstitialClicks;
  int? rewardedActive;
  String? rewardedUnitId;
  int? appOpenActive;
  String? appOpenUnitId;
  int? appOpenClicks;
  int? vipFreeDailyLimit;
  int? rewardedInterstitialActive;
  String? rewardedInterstitialUnitId;
  int? downloadLimitCount;
  int? downloadLimitHours;
  int? nativeActive;
  String? nativeUnitId;

  Ads(
      {this.id,
      this.provider,
      this.testMode,
      this.bannerActive,
      this.bannerUnitId,
      this.interstitialActive,
      this.interstitialUnitId,
      this.interstitialClicks,
      this.rewardedActive,
      this.rewardedUnitId,
      this.appOpenActive,
      this.appOpenUnitId,
      this.appOpenClicks,
      this.vipFreeDailyLimit,
      this.rewardedInterstitialActive,
      this.rewardedInterstitialUnitId,
      this.downloadLimitCount,
      this.downloadLimitHours,
      this.nativeActive,
      this.nativeUnitId});

  Ads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provider = json['provider'];
    testMode = json['test_mode'];
    bannerActive = json['banner_active'];
    bannerUnitId = json['banner_unit_id'];
    interstitialActive = json['interstitial_active'];
    interstitialUnitId = json['interstitial_unit_id'];
    interstitialClicks = json['interstitial_clicks'];
    rewardedActive = json['rewarded_active'];
    rewardedUnitId = json['rewarded_unit_id'];
    appOpenActive = json['app_open_active'];
    appOpenUnitId = json['app_open_unit_id'];
    appOpenClicks = json['app_open_clicks'];
    vipFreeDailyLimit = json['vip_free_daily_limit'];
    rewardedInterstitialActive = json['rewarded_interstitial_active'];
    rewardedInterstitialUnitId = json['rewarded_interstitial_unit_id'];
    downloadLimitCount = json['download_limit_count'];
    downloadLimitHours = json['download_limit_hours'];
    nativeActive = json['native_active'];
    nativeUnitId = json['native_unit_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider'] = this.provider;
    data['test_mode'] = this.testMode;
    data['banner_active'] = this.bannerActive;
    data['banner_unit_id'] = this.bannerUnitId;
    data['interstitial_active'] = this.interstitialActive;
    data['interstitial_unit_id'] = this.interstitialUnitId;
    data['interstitial_clicks'] = this.interstitialClicks;
    data['rewarded_active'] = this.rewardedActive;
    data['rewarded_unit_id'] = this.rewardedUnitId;
    data['app_open_active'] = this.appOpenActive;
    data['app_open_unit_id'] = this.appOpenUnitId;
    data['app_open_clicks'] = this.appOpenClicks;
    data['vip_free_daily_limit'] = this.vipFreeDailyLimit;
    data['rewarded_interstitial_active'] = this.rewardedInterstitialActive;
    data['rewarded_interstitial_unit_id'] = this.rewardedInterstitialUnitId;
    data['download_limit_count'] = this.downloadLimitCount;
    data['download_limit_hours'] = this.downloadLimitHours;
    data['native_active'] = this.nativeActive;
    data['native_unit_id'] = this.nativeUnitId;
    return data;
  }
}
