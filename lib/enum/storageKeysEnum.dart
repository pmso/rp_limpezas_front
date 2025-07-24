enum StorageKeysEnum {
  accessToken('jwt'),
  refreshToken('refresh'),
  firstTime('first_time'),
  userId('user_id'),
  userEmail('user_email');

  final String key;
  const StorageKeysEnum(this.key);
}