$(function(){
  $(".comment_delete").html({
    "<%= j(render "book_comments/destroy", book_comment: book_comment) %>"
  });
});