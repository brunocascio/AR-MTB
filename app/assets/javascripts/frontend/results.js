jQuery(function($){

  $('#genre-tabs a').click(function (e) {
    e.preventDefault()
    $(this).tab('show')
  });

  $('#schedule-select').on('change', function() {
    $(this).parent('form').submit();
  })

  $('#genre-tabs').on('show.bs.tab', function(e) {
    var el = $(e.target).attr('href');
    $(el)
      .find('.panel-collapse')
      .first()
      .addClass('in')
      // .find('.panel-collapse')
      // .first()
      // .toggleClass('in')
  });

  $('#genre-tabs a').first().trigger('click');

});
