class Installation {
  String installationId;
  String userId;
  String pushChannel;
  bool pushChannelExpired;
  String expirationTime;
  List<String> tags;

  Installation(this.userId, this.pushChannel, this.installationId);

  String get getInstallationId => installationId;

  set setInstallationId(String installationId) =>
      this.installationId = installationId;

  String get getUserId => userId;

  set setUserId(String userId) => this.userId = userId;

  String get getPushChannel => pushChannel;

  set setPushChannel(String pushChannel) => this.pushChannel = pushChannel;

  bool get getPushChannelExpired => pushChannelExpired;

  set setPushChannelExpired(bool pushChannelExpired) =>
      this.pushChannelExpired = pushChannelExpired;

  String get getExpirationTime => expirationTime;

  set setExpirationTime(String expirationTime) =>
      this.expirationTime = expirationTime;

  List<String> get getTags => tags;

  set setTags(List<String> tags) => this.tags = tags;

  Map<String, dynamic> toJson() => {
        'installationId': installationId,
        'userId': userId,
        'pushChannel': pushChannel,
        'pushChannelExpired': pushChannelExpired,
        'expirationTime': expirationTime,
        'tags': tags,
      };
}
