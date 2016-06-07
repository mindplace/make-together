$(document).ready(function(){
  $('#new-review-link').on('click', function(e){
    e.preventDefault();
    $.ajax({
      url: $(e.target).attr('href')
    }).done(function(response){
      $('#new-review-link').hide();
      $('#review-list').append(response)
    });
  });

  $('.edit-review-link').on('click', function(e){
    e.preventDefault();
    $.ajax({
      url: $(e.target).attr('href')
    }).done(function(response){
      $('#new-review-link').hide();
      $('#'+ this.parentElement.id).replaceWith(response)
    }.bind(this))
  });
  $('#review-list').on("submit", "form.edit_review", function(e){
    e.preventDefault();
    $.ajax({
      url: e.target.action,
      method: "PUT",
      data: $(e.target).serialize()
    }).done(function(response){
      $('.edit_review').remove();
      $('#review-list').append(response);
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
