$ ->
  FAQCtrl =
    init: ->
      @bindExpand() if $('#questions_container').length
    bindExpand: ->
      $('#questions_container').on 'click', '.faq-expand-toggler', (event)->
        $toggler = $(event.target).closest('.faq-expand-toggler')
        $target = $toggler.closest('.faq-section')
        start_text = $toggler.text()

        $toggler.text $toggler.attr('togglewith')
        $toggler.attr 'togglewith', start_text
        $target.toggleClass('expanded')


  FAQCtrl.init()