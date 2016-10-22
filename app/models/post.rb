class Post < ActiveRecord::Base
  belongs_to :room
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :votes

  validates :content, presence: true
  validates :title, presence: true

  def sum
    self.votes.sum("value")
  end

  def all_comments
    subtree = self.class.all_comments_sql(self)
    results = ActiveRecord::Base.connection.execute( subtree )
    results = results.to_a.map { |h| h.values.first.to_i }
    Comment.find( results ).index_by( &:id ).slice( *results ).values
  end

  def self.all_comments_sql(instance)
    records_array = <<-SQL
WITH RECURSIVE comment_tree(id, content, commentable_id, commentable_type, path) AS (
  SELECT id, content, commentable_id, commentable_type, ARRAY[id]
  FROM comments
  WHERE commentable_type = 'Post' AND commentable_id = '#{instance.id}'
UNION ALL
  SELECT comments.id, comments.content, comments.commentable_id, comments.commentable_type, path || comments.id
  FROM comment_tree
  JOIN comments ON comments.commentable_id=comment_tree.id
  WHERE NOT comments.id = ANY(path) AND comments.commentable_type = 'Comment'
)
SELECT id
FROM comment_tree
ORDER BY path
  SQL
  end

end
