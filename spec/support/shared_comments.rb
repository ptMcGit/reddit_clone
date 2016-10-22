shared_context "shared_comments" do
  def comment_on_post(p)
    create(
      :comment,
      commentable_id:       p.id,
      commentable_type:     "Post",
    )
  end

  def comment_on_comment(c)
    create(
      :comment,
      commentable_id:       c.id,
      commentable_type:     "Comment",
    )
  end

  def klass(instance)
    instance.class.table_name.classify
  end

  def random_comments( post=create(:post), limit=10 )
    # generate random comments;
    # push these comments into an array such that
    # the array reflects the hierarchical relations
    # among the comments
    count = 0
    commentables = {0 => post}
    results = []

    limit.times do
      nesting_lvl = commentables.keys.sample
      sample = commentables[ nesting_lvl ]
      nesting_lvl += 1

      results.push(
        commentables[ nesting_lvl ] =
        create(
          :comment,
          commentable_id: sample.id,
          commentable_type: klass(sample)
        )
      )
      commentables.select! { |k,v| k <= nesting_lvl }

    end
    results
  end

end
