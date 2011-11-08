# encoding: UTF-8
require 'spec_helper'

describe GalCategory do
  
  before(:each) do
    @attr = {
      :name        => "Category Name",
      :description => "category description",
      :permalink   => "category-permalink",
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
        category = GalCategory.new(@attr.merge(:name => "",:permalink => "")).should_not be_valid
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
  
  describe "status attribute" do
    
    it "should be 0 by default" do
      @attr.delete(:status)
      GalCategory.new(@attr).status.should == 0
    end
  end
  
  describe "relationships" do
    
    before :each do
      @category = GalCategory.create(@attr)
    end
    
    it "should respond to albums" do
      @category.should respond_to(:gal_albums)
    end
  end
  
  describe "set_permalink method" do
    
    it "should only call if permalink is blank" do
      GalCategory.create!(@attr).permalink.should == @attr[:permalink]
    end
    
    it "should create a permalink if self is blank" do
      GalCategory.create!(@attr.merge(:permalink => "")).permalink.should == @attr[:name].parameterize
    end
    
    it "should create a permalink if self is nil" do
      @attr.delete(:permalink)
      GalCategory.create!(@attr).permalink.should == @attr[:name].parameterize
    end
    
    it "should change special chars" do
      @attr.delete(:permalink)
      GalCategory.create!(@attr.merge(:name => 'áñí')).permalink.should == "ani"
    end
  end  
end
