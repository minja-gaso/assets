$(document).ready(function(){
  $("#START_DATE").datepicker({
    dateFormat: "yy-mm-dd",
    onSelect: function(selected){
       $("#END_DATE").datepicker("option","minDate", selected)
    }
  });
  $("#END_DATE").datepicker({
    dateFormat: "yy-mm-dd",
    onSelect: function(selected){
       $("#START_DATE").datepicker("option","maxDate", selected)
    }
  });
  $("#FORM_START_DATE").datepicker({
    dateFormat: "mm-dd-yy"
  });
  $("#FORM_END_DATE").datepicker({
    dateFormat: "mm-dd-yy"
  });
});
