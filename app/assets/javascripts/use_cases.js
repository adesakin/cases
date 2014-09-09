$(document).ready(function(){
  $('a.splice-add.btn').on('click', function(){
    $("<div class='slice-drop slice-panel'><div>").insertAfter(this);
  });
});
