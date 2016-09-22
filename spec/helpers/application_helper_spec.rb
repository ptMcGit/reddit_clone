require "rails_helper"

describe ApplicationHelper, :type => :helper do
  before(:all) do
    @b = ::ApplicationHelper::BOOTSTRAP_CONTEXTUAL_CLASSES
    @f = ::ApplicationHelper::FLASH_TRANSLATION
  end


  describe "#class_for_bootstrap" do

    it "returns bootsrap class for message types sample for contextual classes" do
      expect(@b).to include(class_for_bootstrap( @b.sample ))
    end

    it "returns bootstrap class for message types sampled from lookup" do
      expect(@b).to include(class_for_bootstrap( @f.keys.sample ))
    end

    it "returns bootstrap 'info' for message types not in lookup or of contextual classes" do
      stub_const("::ApplicationHelper::BOOTSTRAP_CONTEXTUAL_CLASSES", @b.class.new)
      stub_const("::ApplicationHelper::FLASH_TRANSLATION", @f.class.new)
      non_item = "some_string"
      expect(class_for_bootstrap( non_item )).to eq("info")
    end

  end

end
