module CommentableHelper

  def process_commentable(commentable)
    x = print_commentable(commentable)
    x.flatten.map { |h| [h.keys.first, h.values.first] }
  end


  def print_commentable(commentable, nesting=0)
    s = [{nesting=>commentable}]
    nesting += 1
    commentable.comments.each do |c|
      s.push print_commentable(c, nesting)
    end
    s
  end

end
