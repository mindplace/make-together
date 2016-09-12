$(document).ready(function(){
  $('#new-review-link').on('click', function(e){
    e.preventDefault();
    $.ajax({
      url: $(e.target).attr('href')
    }).done(function(response){
      $('#new-review-link').hide();
      $('#review-list').prepend(response)
    });
  });
  $('#review-list').on('click', '.edit-review-link a', function(e){
    e.preventDefault();
    $.ajax({
      url: $(e.target).attr('href')
    }).done(function(response){
      $('#new-review-link').hide();
      $(this.parentElement.parentElement.parentElement).replaceWith(response)
    }.bind(this))
  });
  $('#review-list').on("submit", "form.edit_review", function(e){
    e.preventDefault();
    $.ajax({
      url: e.target.action,
      method: "PUT",
      data: $(e.target).serialize()
    }).done(function(response){
      $(this).replaceWith(response);
    }.bind(this))
  });
    $('#review-list').on("submit", "#new-review-form", function(e){
      e.preventDefault();
      $.ajax({
        url: '/reviews',
        method: "POST",
        data: $(e.target).serialize()
      }).done(function(response){
          $('#new-review-form').remove();
        if (!response.includes("form")){
          $('#review-list').prepend(response);
          $('#new-review-link').show();
        } else {
          $('#review-list').prepend(response);
        }
      })
    })
    $('#review-list').on("click", ".cancel", function(e){
      e.preventDefault();
      $('#new-review-form').remove();
      $('.edit_review').remove();
      $('#new-review-link').show();
    })
})
