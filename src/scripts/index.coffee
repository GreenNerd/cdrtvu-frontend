$ ->
  IndexCtrl =
    mobileDevice: ///mobile///.test navigator.appVersion.toLowerCase()
    init: ->
      @pcScroll()
      @mobileBars()
      @enableSubMenu()
      @enableCategorySwitch()
      @enableImgsWall()

    pcScroll: ->
      $(document).scroll (event)->
        top = $(document).scrollTop()
        if top < 30
          $('#header_nav').addClass('expanded')
        else
          $('#header_nav').removeClass('expanded')

    mobileBars: ->
      $('#menu_icon').on 'click', (event)->
        $('#header_nav_mobile').toggleClass('expanded')

    enableSubMenu: ->
      $('#header_nav_mobile').on 'click', '.has-sub-nav', (event)->
        event.stopPropagation()
        event.preventDefault()
        $target = $(event.target).closest('a')
        $relate = $ $target.attr('href')
        if $target.hasClass('active')
          $relate.removeClass('active')
          $target.removeClass('active')
        else
          $target.addClass('active')
          $relate.addClass('active')

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
        .on 'click', '.prev', (event)->
          return true if $(event.target).hasClass('disabled')
          setCategoryIndex(getCurrentIndex() - 1)
        .on 'click', '.next', (event)->
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

      if wrapper_width >= total_width
        $('#imgs_wall_ctrl').remove()
        return true

      $container.css 'width', total_width

      setScrollLeft = (number)->
        $wrapper.scrollLeft(number)
        $prev = $('#imgs_wall_ctrl').children('.prev')
        if number <= 0
          $prev.addClass('disabled').next().removeClass('disabled')
        else if number >= total_width - wrapper_width
          $prev.removeClass('disabled').next().addClass('disabled')
        else
          $prev.removeClass('disabled').next().removeClass('disabled')

      setScrollLeft(0)

      $('#imgs_wall_ctrl')
        .on 'click', '.prev', (event)->
          event.stopPropagation()
          startLeft = $wrapper.scrollLeft()
          setScrollLeft Math.max(0, startLeft - wrapper_width / 2)
        .on 'click', '.next', (event)->
          event.stopPropagation()
          startLeft = $wrapper.scrollLeft()
          setScrollLeft Math.min(startLeft + wrapper_width / 2, total_width - wrapper_width)

  IndexCtrl.init()