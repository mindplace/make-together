function loadMoreContent()
{
  $.get('content.html', function(data) {
    if (data != '') {
      $('#content p:last').after(data);
    }
  });
};
$(window).scroll(function() {
  if ($(window).scrollTop() == $(document).height() - $(window).height()) {
    loadMoreContent();
  }
});
