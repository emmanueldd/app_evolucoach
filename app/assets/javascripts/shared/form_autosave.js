// TODO : TESTER le cas de l'update
App.form_autosave = {
  init: function() {
    var self = this;
    if ($("form[data-autosave='true']").length > 0) {
      $("form[data-autosave='true']").find('input, textarea').each(function(){
        $(this).change(function(){
          self.save_form($(this).closest("form"));
        });
      })
    }
  },
  save_form: function(thisObj) {
    // $('#form-spinner').show();
    // setTimeout("$('#form-spinner').hide();", 1000);
    // alert('SAVE FORM');
    console.log($(thisObj).attr('method'))
    console.log($(thisObj).attr('action'))
    console.log($(thisObj).serialize())
    $.ajax({
      type: $(thisObj).attr('method'),
      url: $(thisObj).attr('action'),
      data: $(thisObj).serialize(),
      dataType: "JSON",
      success: function(data) {
        console.log('data =>', data);
        if (data != undefined && $(thisObj).attr("method").toLowerCase() == "post" ) {
          $(thisObj).data('object-id', String(data.id));
          $(thisObj).prop( "action", $(thisObj).data('update-url') + $(thisObj).data('object-id') );
          $(thisObj).prop( "method", "PUT" );
        }
      }
    });
  }
}
