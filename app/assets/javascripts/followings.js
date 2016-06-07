$(document).ready(function(){
  $('.following-sort-button').on("click", function(e){
    $('.active').addClass('hidden');
    $('.active').removeClass('active')
    clicked = $(e.target.parentElement).attr('class')
    $(clicked).removeClass('hidden');
    $(clicked).addClass('active');
  })
})