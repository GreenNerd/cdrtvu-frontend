$ ->
  IndexCtrl =
    init: ->
      @pcScroll()
      @mobileBars()
      @enableSubMenu()

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

  IndexCtrl.init()