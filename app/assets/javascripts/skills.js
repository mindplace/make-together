$(document).ready(function(){
  $('#new-skill').on("click", function(e){
    e.preventDefault();
    $.ajax({
      url: $(e.target).attr('href')
    }).done(function(response){
      $('new-skill').hide();
      $('#skill-list').prepend(response);
    })
  })
  $('#skill-list').on("submit", "form", function(e){
    e.preventDefault();
    $.ajax({
      url: '/skills',
      method: "POST",
      data: $(e.target).serialize()
    }).done(function(response){
      $('#new-skill-form').remove();
      $('#skill-list').prepend(response);
    })
  })
})