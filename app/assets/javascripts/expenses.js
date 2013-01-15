$(document).ready(function() {
  $(".expenses_form input").tooltip({
    'trigger' : 'focus',
    'placement' : 'bottom'
  });
  $("select.category").tooltip({
    'trigger' : 'focus',
    'placement' : 'top'
  });
  $("select").tooltip({
    'trigger' : 'focus',
    'placement' : 'left'
  });
  $("tr.expense").tooltip({
    'trigger' : 'hover',
    'placement' : 'right'
  });
});
