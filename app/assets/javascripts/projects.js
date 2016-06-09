$(document).ready(function(){
  $('.sorted-projects').hide();
  $('#recent').show();
  $('.project-sort-button').on("click", function(e){
    clicked = $(e.target.parentElement).attr('class')
    $('.sorted-projects').hide();
    $('#new-project-link').show();
    $('#new-project-div').remove();
    $(clicked).show();
  })
  $('#new-project-link').on("click", function(e){
    e.preventDefault();
    $.ajax({
      url: $(e.target).attr('href')
    }).done(function(response){
      $('#new-project-link').hide();
      $('.sorted-projects-list').prepend(response);
      $('.sorted-projects').hide();
    })
  })
  $('.sorted-projects-list').on("submit", "#new_project", function(e){
    e.preventDefault();
    $.ajax({
      url: '/projects',
      method: 'POST',
      data: $(e.target).serialize()
    }).done(function(response){
      $('#new-project-div').remove();
      if (!response.includes("form")){
        $('#new-project-link').show();
        $('#recent-projects').prepend(response);
        $('.sorted-projects').show();
      } else {
        $('.sorted-projects-list').prepend(response);
        $('.sorted-projects').hide();
      }
    })
  })
  $('#search-form').on("submit", function(e){
    e.preventDefault();
    $.ajax({
      url: '/search',
      data: $('#search-field').serialize(),
      method: 'POST'
    }).done(function(response){
      $('#new-project-link').show();
      $('#new-project-div').remove();
      $('.sorted-projects').hide();
      $('.sorted-projects-list').prepend(response);
    })
  })
  $('.project-box').on("click", ".favorite-button a", function(e){
    e.preventDefault();
    clicked = e.target.parentElement.parentElement
    $.ajax({
      url: $(e.target.parentElement).attr('href'),
      method: "POST"
    }).done(function(response){
      $(clicked).replaceWith(response);
    })
  })
  $('.project-box').on("click", ".unfavorite-button a", function(e){
    e.preventDefault();
    clicked = e.target.parentElement.parentElement
    $.ajax({
      url: $(e.target.parentElement).attr('href'),
      method: "DELETE"
    }).done(function(response){
      $(clicked).replaceWith(response);
    })
  })
  $('.categories').on("click", "a", function(e){
    debugger;
    selected = $(e.target);
    $('.highlight').css("color", "#8E8F91").removeClass('highlight');
    selected.css("color", "#FF8A7A").addClass('highlight');
    $("html, body").animate({ scrollTop: 0 }, "slow");
  })
  $(window).scroll(function () {
    // distance from top of footer to top of document
    footertotop = ($('footer').position().top);

    // distance user has scrolled from top, adjusted to take in height of sidebar (570 pixels inc. padding)
    scrolltop = $(document).scrollTop()+570;
    // difference between the two
    difference = scrolltop-footertotop;
    // if user has scrolled further than footer,
    // pull sidebar up using a negative margin

    if (scrolltop > footertotop) {
      $('.categories').css('margin-top',  0-difference);
    } else  {
      $('.categories').css('margin-top', 0);
    }
  });

})
  $('.project-box').on("click", "#report-button a", function(e){
    e.preventDefault();
    clicked = e.target
    $.ajax({
      url: $(e.target).attr('href'),
      method: "POST"
    }).done(function(response){
      $(clicked).replaceWith(response);
    })
  })
  $('.project-box').on("click", "#unreport-button a", function(e){
    e.preventDefault();
    clicked = e.target
    $.ajax({
      url: $(e.target).attr('href'),
      method: "DELETE"
    }).done(function(response){
      $(clicked).replaceWith(response);
    })
  })
