(function($){
  $.fn.tableSortable = function(){

    return this.each(function(){
      var parentElement = $(this).closest('tr');
      var cl = parentElement.attr('class');
      var elem = parentElement.find('td:last').detach();
      var newElemTr = $('<tr>').addClass(cl).insertAfter(parentElement);
      $(newElemTr).html(elem);
    });  
  }; 
}(jQuery));