//      console.log($(this).parent().data("vote-value"))


$(document).ready(function () {
    var path = "/votes"

    $(".btn-upvote").click(function() {
        current_post = $(this).parent().data("post-value")
        vote_value = $(this).data("vote-value")
        console.log(current_post, vote_value)
        //$.ajax(path, method: "POST" data: { post_id: current_post, value: vote_value })
        $(this).addClass("btn-primary")
        $(this).closest("div").find(".btn-downvote").removeClass("btn-primary")
        $.ajax({
            url: "/votes.json",
            method: "POST",
            data: { post_id: current_post, value: vote_value},
            success: function() { alert("request successful") },
            error:      function() { alert("request errored") }
        })



    })
    $(".btn-downvote").click(function() {
        current_post = $(this).parent().data("post-value")
        vote_value = $(this).data("vote-value")
                console.log(current_post, vote_value)
        $(this).addClass("btn-primary")
        $(this).closest("div").find(".btn-upvote").removeClass("btn-primary")
        $.ajax({
            url: "/votes.json",
            method: "POST",
            data: { post_id: current_post, value: vote_value},
            success: function() { alert("request successful") },
            error:      function() { alert("request errored") }
        })


    })
})
