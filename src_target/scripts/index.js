$(function() {
  var IndexCtrl;
  IndexCtrl = {
    mobileDevice: /mobile/.test(navigator.appVersion.toLowerCase()),
    touchSupport: window.ontouchstart === null,
    init: function() {
      this.clickevent = this.touchSupport ? 'touchend' : 'click';
      this.onScroll();
      this.mobileBars();
      this.enableSubMenu();
      this.enableCategorySwitch();
      if ($('#imgs_wall_container').length) {
        this.enableImgsWall();
      }
      this.enableFooterQrcode();
      return this.enableLandingAnchor();
    },
    onScroll: function() {
      return $(document).scroll(function(event) {
        var top;
        top = $(document).scrollTop();
        if (top < 30) {
          $('#header_nav').addClass('expanded');
          return $('#header_nav_mobile').removeClass('floating');
        } else {
          $('#header_nav').removeClass('expanded');
          return $('#header_nav_mobile').addClass('floating');
        }
      });
    },
    mobileBars: function() {
      return $(document).on(this.clickevent, '#menu_icon', function(event) {
        return $('#header_nav_mobile').toggleClass('expanded');
      });
    },
    enableSubMenu: function() {
      return $('#header_nav_mobile').on(this.clickevent, '.has-sub-nav', (function(_this) {
        return function(event) {
          var $relate, $target, isActived;
          event.stopPropagation();
          event.preventDefault();
          $target = $(event.target).closest('a');
          $relate = $($target.attr('href'));
          isActived = $target.hasClass('active');
          if (_this.activeSubNavs) {
            _this.activeSubNavs.removeClass('active');
            $(_this.activeSubNavs.attr('href')).removeClass('active');
          }
          if (isActived) {
            $relate.removeClass('active');
            $target.removeClass('active');
            return _this.activeSubNavs = null;
          } else {
            $target.addClass('active');
            $relate.addClass('active');
            return _this.activeSubNavs = $target;
          }
        };
      })(this));
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
      return $control.on(this.clickevent, '.prev', function(event) {
        if ($(event.target).hasClass('disabled')) {
          return true;
        }
        return setCategoryIndex(getCurrentIndex() - 1);
      }).on(this.clickevent, '.next', function(event) {
        if ($(event.target).hasClass('disabled')) {
          return true;
        }
        return setCategoryIndex(getCurrentIndex() + 1);
      });
    },
    enableImgsWall: function() {
      var $container, $imgs, $wrapper, item_width, line, setMarginLeft, total_width, wrapper_width;
      line = this.mobileDevice ? 3 : 2;
      $container = $('#imgs_wall');
      $imgs = $container.children();
      $wrapper = $container.closest('.imgs-wall');
      wrapper_width = $wrapper.width();
      item_width = $imgs.eq(0).width();
      total_width = Math.ceil($imgs.length / line) * item_width;
      if (wrapper_width >= total_width) {
        return true;
      }
      $container.css('width', total_width);
      setMarginLeft = function(number) {
        var $prev;
        $container.css('margin-left', number + "px");
        $prev = $('#imgs_wall_container').children('.prev');
        if (number >= 0) {
          return $prev.addClass('disabled').next().removeClass('disabled');
        } else if (number <= wrapper_width - total_width) {
          return $prev.removeClass('disabled').next().addClass('disabled');
        } else {
          return $prev.removeClass('disabled').next().removeClass('disabled');
        }
      };
      setMarginLeft(0);
      return $('#imgs_wall_container').on(this.clickevent, '.prev', function(event) {
        var startLeft;
        event.stopPropagation();
        startLeft = parseInt($container.css('margin-left'));
        return setMarginLeft(Math.min(0, startLeft + wrapper_width / 2));
      }).on(this.clickevent, '.next', function(event) {
        var startLeft;
        event.stopPropagation();
        startLeft = parseInt($container.css('margin-left'));
        return setMarginLeft(Math.max(startLeft - wrapper_width / 2, wrapper_width - total_width));
      });
    },
    enableFooterQrcode: function() {
      var active_link;
      if (!this.mobileDevice) {
        return true;
      }
      active_link = void 0;
      return $(document).on(this.clickevent, '.extra-link-item', function(event) {
        var $target;
        event.stopPropagation();
        if (active_link) {
          active_link.removeClass('active');
        }
        $target = $(event.target).closest('.extra-link-item');
        $target.toggleClass('active');
        return active_link = $target;
      }).on(this.clickevent, '.qr-container', function(event) {
        return event.stopPropagation();
      }).on(this.clickevent, function(event) {
        if (active_link) {
          return active_link.removeClass('active');
        }
      });
    },
    enableLandingAnchor: function() {
      return $('#second_panel').on(this.clickevent, 'a', function(event) {
        return $(document.body).animate({
          scrollTop: $('#second_panel').offset().top
        }, 400);
      });
    }
  };
  return IndexCtrl.init();
});
