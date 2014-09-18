(function($){
  $.fn.insertStep = function(val){

    if ($('div').hasClass('slice_flows_step_id')) {
      var initial_rank = 2;
      var exploded_rank = 3;
      var arr_iterator = 0;
      last_step = $('.slice_flows_step_id').children().eq(-1);
      arr = last_step.prop("name").split("][");
      switch(arr.length) {
        case initial_rank:
          arr_name = arr[0] + "][" + arr_iterator + "][" + arr[1];
          last_step.prop('name', arr_name)          
          break;
        case exploded_rank: 
          break;
        default:
          console.log("Node not well formed");
          return;
      }

      rearr = last_step.prop("name").split("][");
      rearr_iterator = parseInt(rearr[1])+1;
      next_arr_name = rearr[0] + "][" + rearr_iterator + "][" + rearr[2];
      next_arr_id = (rearr[0] + "_" + rearr_iterator + "_" + rearr[2]).replace("[", "_").replace("]", "");
      next_step = last_step.clone().insertAfter(last_step);
      next_step.prop('name', next_arr_name).prop('id', next_arr_id).val(val);
      next_step.insertAfter(last_step);
      return next_step;      
    }
    else {
      return console.log("No initial step");
    }
  }; 
}(jQuery));