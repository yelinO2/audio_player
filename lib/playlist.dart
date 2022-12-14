import 'song.dart';

class Playlist {
  final List<Song> _myPlaylist = [
    Song(
        src: 'with_you.mp3',
        title: 'With You',
        artist: 'Tyler Shaw',
        albumn: 'withyou.jpg'),
    Song(
        src: 'love_you_still.mp3',
        title: 'Love You Still',
        artist: 'Tyler Shaw',
        albumn: 'loveyoustill.jpg'),
    Song(src: 'SOLO.mp3', title: 'SOLO', artist: 'Jennie', albumn: 'solo.jpg'),
    Song(
        src: 'make_you_mine.mp3',
        title: 'Make You Mine',
        artist: 'Public',
        albumn: 'makeyoumine.jpg'),
    Song(
        src: "it's_you.mp3",
        title: "It's You",
        artist: 'Daniel Shaw',
        albumn: 'itsyou.jpg'),
  ];

  getSrc(currentSong) {
    return _myPlaylist[currentSong].src;
  }

  getTitle(currentSong) {
    return _myPlaylist[currentSong].title;
  }

  getArtist(currentSong) {
    return _myPlaylist[currentSong].artist;
  }

  getAlbumn(currentSong) {
    return _myPlaylist[currentSong].albumn;
  }

  getLength() {
    return _myPlaylist.length;
  }
}
