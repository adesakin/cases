// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery.remotipart
//= require jquery.ui.all
//= require foundation
//= require turbolinks
//= require cocoon
//= require_tree .
//= require best_in_place
//= require best_in_place.purr

$(function(){ 
	$(document).foundation(); 

	$(document).ready(function() {

     $('.connectedSortable').sortable({
        helper: "clone",
        connectWith: ".connectedSortable",
      }).disableSelection();



    jQuery(".best_in_place").best_in_place();
    $('#right-yield').stick_in_parent();
    $('select#slice').on('change', function(){
      var slice_id = $(this).val();
      var proj_id = $('#project-content').data('project-id');
      if(slice_id != ""){
        $.getJSON("/projects/" + proj_id + "/slices/" + slice_id, function(data){
          var html = '';
          html += '<div class="large-12 medium-12 columns headbar">';
          html += '<p class="large-3 small-6 columns" style="padding:0;"><b>Estimate :</b><br>' + data.estimate + '<br></p>';
          html += '<p class="large-3 small-6 columns" style="padding:0;"><b>Status :</b><br>' + data.workflow_state + '<br></p>';
          html += '<p class="large-3 small-6 columns" style="padding:0;"><b>Release :</b><br>' + data.release_id  + '<br></p>';
          html += '<p class="large-3 small-6 columns" style="padding:0;"><b>Priority :</b><br>' + data.order_priority + '<br></p>';
          html += '<hr style="border:salmon 1px solid;">';
          html += '</div>';

          var steps = '';
          steps = '<div class="large-12 medium-12 columns slice-steps">';
          steps += '<ul class="square">';
          if(data.steps != ""){
            $.each(data.steps, function(stepIndex, step){
              steps += '<li>' + step.full_desc + '</li>'
            });              
          }
          steps += '</ul></div>';
          $('#slice-inner').html(html + steps);
        });         
        $('a.slice-delete').show();
      } else {
        $('a.slice-delete').hide();
        $('#slice-inner').html("");
      }
    });
  });


$(document).ready(function() {
  $('body').on('ajax:beforeSend', 'a[data-remote="true"]', function(event, xhr, settings) {
    if (settings.type == 'GET') {
      xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    }
  });
});

});
