$(function() {
  var IndexCtrl;
  IndexCtrl = {
    init: function() {
      this.pcScroll();
      this.mobileBars();
      return this.enableSubMenu();
    },
    pcScroll: function() {
      return $(document).scroll(function(event) {
        var top;
        top = $(document).scrollTop();
        if (top < 30) {
          return $('#header_nav').addClass('expanded');
        } else {
          return $('#header_nav').removeClass('expanded');
        }
      });
    },
    mobileBars: function() {
      return $('#menu_icon').on('click', function(event) {
        return $('#header_nav_mobile').toggleClass('expanded');
      });
    },
    enableSubMenu: function() {
      return $('#header_nav_mobile').on('click', '.has-sub-nav', function(event) {
        var $relate, $target;
        event.stopPropagation();
        event.preventDefault();
        $target = $(event.target).closest('a');
        $relate = $($target.attr('href'));
        if ($target.hasClass('active')) {
          $relate.removeClass('active');
          return $target.removeClass('active');
        } else {
          $target.addClass('active');
          return $relate.addClass('active');
        }
      });
    }
  };
  return IndexCtrl.init();
});
