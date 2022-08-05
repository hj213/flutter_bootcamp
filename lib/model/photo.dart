class Photo {
  final String id;

  final int width;

  final int height;

  final String previewUrl;

  final String downloadUrl;

  final int likes;

  final String username;

  final String userProfileImageUrl;

  Photo.from(dynamic source)
      : id = source['id'],
        width = source['width'],
        height = source['height'],
        previewUrl = source['urls']['regular'],
        downloadUrl = source['urls']['raw'],
        likes = source['likes'],
        username = source['user']['username'],
        userProfileImageUrl = source['user']['profile_image']['medium'];

  const Photo(
      this.id,
      this.width,
      this.height,
      this.previewUrl,
      this.downloadUrl,
      this.likes,
      this.username,
      this.userProfileImageUrl,
      );
}
