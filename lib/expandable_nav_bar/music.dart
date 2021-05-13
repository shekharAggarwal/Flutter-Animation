class Music {
  const Music({this.singer, this.name, this.backgroundImage, this.singerImage});

  final String singer;
  final String name;
  final String backgroundImage;
  final String singerImage;
}

final musics = List.generate(
  4,
  (index) => Music(
      singer: "Singer ${index + 1}",
      name: "Song Name ${index + 1}",
      backgroundImage: "https://i.scdn.co/image/ab6765630000ba8a3b47b54b346c2917f3683aef",
      singerImage: "https://i.scdn.co/image/ab6765630000ba8a3b47b54b346c2917f3683aef"),
);
