$ ->
  FAQCtrl =
    touchSupport: window.ontouchstart is null
    init: ->
      @clickevent = if @touchSupport then 'touchend' else 'click'
      @bindExpand() if $('#questions_container').length
    bindExpand: ->
      $('#questions_container').on @clickevent, '.faq-expand-toggler', (event)->
        $toggler = $(event.target).closest('.faq-expand-toggler')
        $target = $toggler.closest('.faq-section')
        start_text = $toggler.text()

        $toggler.text $toggler.attr('togglewith')
        $toggler.attr 'togglewith', start_text
        $target.toggleClass('expanded')

  FAQCtrl.init()