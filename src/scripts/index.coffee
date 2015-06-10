$ ->
  IndexCtrl =
    mobileDevice: ///mobile///.test navigator.appVersion.toLowerCase()
    touchSupport: window.ontouchstart is null
    init: ->
      @clickevent = if @touchSupport then 'touchend' else 'click'
      @pcScroll()
      @mobileBars()
      @enableSubMenu()
      @enableCategorySwitch()
      @enableImgsWall() if $('#imgs_wall_container').length
      @enableFooterQrcode()

    pcScroll: ->
      $(document).scroll (event)->
        top = $(document).scrollTop()
        if top < 30
          $('#header_nav').addClass('expanded')
        else
          $('#header_nav').removeClass('expanded')

    mobileBars: ->
      $('#menu_icon').on @clickevent, (event)->
        $('#header_nav_mobile').toggleClass('expanded')

    enableSubMenu: ->
      $('#header_nav_mobile').on @clickevent, '.has-sub-nav', (event)=>
        event.stopPropagation()
        event.preventDefault()
        $target = $(event.target).closest('a')
        $relate = $ $target.attr('href')
        isActived = $target.hasClass('active')

        if @activeSubNavs
          @activeSubNavs.removeClass('active')
          $(@activeSubNavs.attr('href')).removeClass('active')

        if isActived
          $relate.removeClass('active')
          $target.removeClass('active')
          @activeSubNavs = null
        else
          $target.addClass('active')
          $relate.addClass('active')
          @activeSubNavs = $target

    enableCategorySwitch: ->
      $container = $('#categories_container')
      $control = $('#category_switch_control')
      $prev = $control.find('.prev')
      $next = $control.find('.next')

      getCurrentIndex = ->
        parseInt($container.data('index')) or 0

      setControlStatus = (index)->
        if index is 0
          $prev.addClass('disabled')
        else
          $prev.removeClass('disabled')
        if index is (count - 1)
          $next.addClass('disabled')
        else
          $next.removeClass('disabled')

      setCategoryIndex = (index)->
        $container.data('index', index)
        setControlStatus(index)
        $container.css('margin-left', "-#{index}00%")

      startIndex = getCurrentIndex()
      count = $container.children('.category-item').length
      setControlStatus(startIndex)

      $control
        .on @clickevent, '.prev', (event)->
          return true if $(event.target).hasClass('disabled')
          setCategoryIndex(getCurrentIndex() - 1)
        .on @clickevent, '.next', (event)->
          return true if $(event.target).hasClass('disabled')
          setCategoryIndex(getCurrentIndex() + 1)

    enableImgsWall: ->
      line = if @mobileDevice then 3 else 2
      $container = $('#imgs_wall')
      $imgs = $container.children()
      $wrapper = $container.closest('.imgs-wall')
      wrapper_width = $wrapper.width()
      item_width = $imgs.eq(0).width()
      total_width = Math.ceil($imgs.length / line)*item_width

      return true if wrapper_width >= total_width

      $container.css 'width', total_width

      setMarginLeft = (number)->
        $container.css 'margin-left', "#{number}px"
        $prev = $('#imgs_wall_container').children('.prev')
        if number >= 0
          $prev.addClass('disabled').next().removeClass('disabled')
        else if number <= wrapper_width - total_width
          $prev.removeClass('disabled').next().addClass('disabled')
        else
          $prev.removeClass('disabled').next().removeClass('disabled')

      setMarginLeft(0)

      $('#imgs_wall_container')
        .on @clickevent, '.prev', (event)->
          event.stopPropagation()
          startLeft = parseInt $container.css('margin-left')
          setMarginLeft Math.min(0, startLeft + wrapper_width / 2)
        .on @clickevent, '.next', (event)->
          event.stopPropagation()
          startLeft = parseInt $container.css('margin-left')
          setMarginLeft Math.max(startLeft - wrapper_width / 2, wrapper_width - total_width)

    enableFooterQrcode: ->
      return true unless @mobileDevice
      active_link = undefined
      $(document)
        .on @clickevent, '.extra-link-item', (event)->
          event.stopPropagation()
          if active_link
            active_link.removeClass('active')
          $target = $(event.target).closest('.extra-link-item')
          $target.toggleClass('active')
          active_link = $target
        .on @clickevent, '.qr-container', (event)->
          event.stopPropagation()
        .on @clickevent, (event)->
          if active_link
            active_link.removeClass('active')


  IndexCtrl.init()