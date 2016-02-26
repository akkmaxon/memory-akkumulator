$(document).ready(function() {
  if($('p.alert')) {
    setTimeout(function() {
      $('p.alert').fadeOut(2000);
    }, 1000);
  }
  $('[title]').tooltip();
});
