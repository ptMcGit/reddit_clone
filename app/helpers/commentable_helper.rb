module CommentableHelper

  def process_commentable(commentables)
    results = []
    lookup = Hash.new(nil)

    commentables.each do |comment|
      if lookup[comment.commentable_id]
        lookup[comment.id] = lookup[comment.commentable_id] + 1
      else
        lookup[comment.id] = 1
      end
      results.push( [lookup[comment.id], comment] )
    end
    results
  end

  # def process_commentable(commentable)
  #   x = print_commentable(commentable)
  #   x.flatten.map { |h| [h.keys.first, h.values.first] }
  # end


  # def print_commentable(commentable, nesting=0)
  #   s = [{nesting=>commentable}]
  #   nesting += 1
  #   commentable.comments.each do |c|
  #     s.push print_commentable(c, nesting)
  #   end
  #   s
  # end

end
