$(function() {
  var IndexCtrl;
  IndexCtrl = {
    init: function() {
      this.pcScroll();
      this.mobileBars();
      this.enableSubMenu();
      return this.enableCategorySwitch();
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
    },
    enableCategorySwitch: function() {
      var $container, $control, $next, $prev, count, getCurrentIndex, setCategoryIndex, setControlStatus, startIndex;
      $container = $('#categories_container');
      $control = $('#category_switch_control');
      $prev = $control.find('.prev');
      $next = $control.find('.next');
      getCurrentIndex = function() {
        return parseInt($container.data('index')) || 0;
      };
      setControlStatus = function(index) {
        if (index === 0) {
          $prev.addClass('disabled');
        } else {
          $prev.removeClass('disabled');
        }
        if (index === (count - 1)) {
          return $next.addClass('disabled');
        } else {
          return $next.removeClass('disabled');
        }
      };
      setCategoryIndex = function(index) {
        $container.data('index', index);
        setControlStatus(index);
        return $container.css('margin-left', "-" + index + "00%");
      };
      startIndex = getCurrentIndex();
      count = $container.children('.category-item').length;
      setControlStatus(startIndex);
      return $control.on('click', '.prev', function(event) {
        if ($(event.target).hasClass('disabled')) {
          return true;
        }
        return setCategoryIndex(getCurrentIndex() - 1);
      }).on('click', '.next', function(event) {
        if ($(event.target).hasClass('disabled')) {
          return true;
        }
        return setCategoryIndex(getCurrentIndex() + 1);
      });
    }
  };
  return IndexCtrl.init();
});
