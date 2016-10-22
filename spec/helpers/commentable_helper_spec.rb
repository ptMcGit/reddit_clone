require "rails_helper"

describe CommentableHelper, :type => :helper do
  include_context "shared_comments"

  before(:all) do
    @p  = create(:post)
  end

  describe "#process_commentables" do
    before(:all) do
      @comments = random_comments_with_nesting_as_arrays(@p)
      @p_comments = process_commentable(@p.all_comments)
    end

    it "returns commentables for views with nesting as expected" do
      expect(@p_comments).to eq(@comments)
    end

    it "returns an array of arrays with specific criteria" do
      expect(@p_comments.class).to eq(Array)

      sample = @p_comments.sample

      expect(sample.class).to eq(Array)

      expect(sample[0].class).to eq(Fixnum)
      expect(sample[1].class).to eq(Comment.first.class)
    end
  end
end
