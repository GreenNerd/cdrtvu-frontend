$ ->
  $(document).scroll (event)->
    top = $(document).scrollTop()
    if top < 30
      $('#header_nav').addClass('expanded')
    else
      $('#header_nav').removeClass('expanded')