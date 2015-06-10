$(function() {
  var FAQCtrl;
  FAQCtrl = {
    touchSupport: window.ontouchstart === null,
    init: function() {
      this.clickevent = this.touchSupport ? 'touchend' : 'click';
      if ($('#questions_container').length) {
        return this.bindExpand();
      }
    },
    bindExpand: function() {
      return $('#questions_container').on(this.clickevent, '.faq-expand-toggler', function(event) {
        var $target, $toggler, start_text;
        $toggler = $(event.target).closest('.faq-expand-toggler');
        $target = $toggler.closest('.faq-section');
        start_text = $toggler.text();
        $toggler.text($toggler.attr('togglewith'));
        $toggler.attr('togglewith', start_text);
        return $target.toggleClass('expanded');
      });
    }
  };
  return FAQCtrl.init();
});
