class RegExpUtils {
  static final emailPatternRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );
  static final passwordPatternRegExp = RegExp(
    r'^.*(?=.{8,255})((?=.*[!@#$%^&*_,.?’:;“]))(?=.*\d)((?=.*[A-Z]))((?=.*[a-z])).*$',
  );

  static final emojiPatternRegExp = RegExp(
    r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])',
  );

  static final namePatternRegExp = RegExp(r'^[a-zA-Z ]{3,60}$');
  static final numberRegExp = RegExp(r'^[0-9]{4}$');
  static const spaceRegExp = " ";
  static final amountRegExp = RegExp(r'^[0-9]+(\.[0-9][0-9])?$');

  static final bankAccountRegExp = RegExp(r'^[0-9]{10,18}$');
  static final ifscCodeRegExp = RegExp(r'^(?:[A-Z]{4})?[0-9]{6,28}$');
}
