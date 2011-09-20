require 'spec_helper'

describe GalCategory do
  
  before(:each) do
    @attr = {
      :name        => "category",
      :description => "category description",
      :permalink   => "category",
      :status      => 0
    }
  end
  
  describe "validations" do
    
    it "should create a new instance with valid attributes" do
      GalCategory.create!(@attr)
    end
    
    describe "name" do
      
      it "should require a name" do
        GalCategory.new(@attr.merge(:name => "")).should_not be_valid
      end
      
      it "should reject long names" do
        GalCategory.new(@attr.merge(:name => ("a"*51))).should_not be_valid
      end
    end
    
    describe "description" do
      
      it "should reject long description" do
        GalCategory.new(@attr.merge(:description => ("a"*256))).should_not be_valid
      end
    end
    
    describe "permalink" do
      
      it "should require a permalink" do
        GalCategory.new(@attr.merge(:permalink => "")).should_not be_valid
      end
      
      it "should reject long permalinks" do
        GalCategory.new(@attr.merge(:permalink => ("a"*51))).should_not be_valid
      end
      
      it "should reject invalid permalinks" do
        ["a a", "a_a", "a*a", "a.a"].each do |invalid_permalink| 
          GalCategory.new(@attr.merge(:permalink => invalid_permalink)).should_not be_valid
        end
      end
      
      it "should acepts valid permalinks" do
        ["a-a", "aaaa"].each do |valid_permalink|
          GalCategory.new(@attr.merge(:permalink => valid_permalink)).should be_valid
        end
      end
      
      it "should reject duplicated permalinks" do
        GalCategory.create!(@attr)
        GalCategory.new(@attr).should_not be_valid
      end
    end
    
    describe "status" do
      
      it "should require an status" do
        GalCategory.new(@attr.merge(:status => "")).should_not be_valid
      end
    end
  end  
end
