var template = function(i) {
  return '<li>' +
  '<label for="song_lyrics_attributes_' + i + '_word">Word or phrase</label>' +
  '<input type="text" name="song[lyrics_attributes][' + i + '][word]" id="song_lyrics_attributes_' + i +'_word">' +
  '<label for="song_lyrics_attributes_' + i + '_part_of_speech">Part of speech</label>' +
  '<input type="text" name="song[lyrics_attributes][' + i + '][part_of_speech]" id="song_lyrics_attributes_' + i + '_part_of_speech">' +
  '</li>';
};

$(document).ready(function() {
  var count = parseInt($('#words-phrases li').last().data('number'), 10) + 1;
  $('.panel-body').on('click', '#add-another', function() {
    $('#words-phrases').append(template(count));
    count++;
  });
});
