require './lib/grex'
require "minitest/autorun"

describe Grex::Stages do

  before(:each) do
    @subject = Object.new.extend(Grex::Stages)
  end

  describe "#match" do
    it "must return a hash with a key $match" do
      hash = @subject.match(:field => 'value')
      hash[:$match].wont_be_nil
    end
  end

  describe "#group_by" do

    it "must return a hash with a key $group" do
      hash = @subject.group_by(:field)
      hash[:$group].wont_be_nil
    end

    it "do not need a block" do
      @subject.group_by(:my_key).must_be_instance_of Hash
    end

    it "can group_by an Array of fields" do
      @subject.group_by([:my_key1, :my_key2]).must_be_instance_of Hash
    end

    describe "when a symbol is passed as parameters" do
      it "must return a valid hash" do
        assert_equal(@subject.group_by(:my_key), {:$group=>{:_id=>{:my_key=>"$my_key"}}})
      end
    end

    describe "when a block is passed and return a hash" do
      it "must return a valid hash and with accumulators" do
        assert_equal(@subject.group_by(:my_key){ { '$sum' => :count } }, {:$group=>{:_id=>{:my_key=>"$my_key"}, "$sum"=>:count}})
      end
    end
  end

  describe "#unwind" do
    it "must return a hash with a key $unwind" do
      hash = @subject.unwind(:field)
      hash[:$unwind].wont_be_nil
    end
  end
end