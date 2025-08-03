enum StorageKeysEnum {
  accessToken('jwt'),
  refreshToken('refresh'),
  firstTime('first_time'),
  userId('user_id'),
  userEmail('user_email'),
  userUsername('username'),
  userName('user_name');

  final String key;
  const StorageKeysEnum(this.key);
}