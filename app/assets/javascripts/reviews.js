$(document).ready(function(){
  $('#new-review-link').on('click', function(e){
    e.preventDefault();
    $.ajax({
      url: $(e.target).attr('href')
    }).done(function(response){
      $('#new-review-link').hide();
      $('#review-list').append(response)
    })
    $('#review-list').unbind().on("submit", "form", function(e){
      e.preventDefault();
      $.ajax({
        url: '/reviews',
        method: "POST",
        data: $(e.target).serialize()
      }).done(function(response){
          $('#new-review-form').remove();
        if (!response.includes("form")){
          $('#review-list').append(response);
          $('#new-review-link').show();
        } else {
          $('#review-list').append(response);
        }
      })
    })
    $('#review-list').on("click", "#cancel", function(e){
      e.preventDefault();
      $('#new-review-form').remove();
      $('#new-review-link').show();
    })
  })
})