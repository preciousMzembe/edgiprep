class SlideMediaModel {
  final MediaType mediaType;
  final String mediaLink;

  SlideMediaModel(
    this.mediaType,
    this.mediaLink,
  );
}

enum MediaType {
  image,
  video,
  audio,
}
