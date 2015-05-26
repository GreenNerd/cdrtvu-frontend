$(function() {
  return $(document).scroll(function(event) {
    var top;
    top = $(document).scrollTop();
    if (top < 30) {
      return $('#header_nav').addClass('expanded');
    } else {
      return $('#header_nav').removeClass('expanded');
    }
  });
});
