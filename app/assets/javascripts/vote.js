$(document).ready(function () {
    $(".upvote-btn").click(function() {
        console.log($(this).parent())
        $(this).addClass("btn-primary")
        $(this).closest("div").find(".downvote-btn").removeClass("btn-primary")
    })
    $(".downvote-btn").click(function() {
        console.log($(this))
        $(this).addClass("btn-primary")
        $(this).closest("div").find(".upvote-btn").removeClass("btn-primary")

    })
})
