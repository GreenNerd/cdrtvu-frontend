$ ->
  IndexCtrl =
    init: ->
      @pcScroll()
      @mobileBars()
      @enableSubMenu()
      @enableCategorySwitch()

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


  IndexCtrl.init()