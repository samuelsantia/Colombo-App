# encoding: UTF-8
require 'spec_helper'

describe GalAlbum do
  
  before(:each) do
    @gal_category = Factory(:gal_category)
    @attr = {
      :name            => "Album name",
      :gal_category_id => @gal_category.id,
      :description     => "Album description",
      :permalink       => "album-name",
      :status          => 0
    }
  end
  
  describe "validations" do
    
    it "should create a new instance with valid attributes" do
      GalAlbum.create!(@attr)
    end
    
    describe "name" do
      
      it "should require a name" do
        GalAlbum.new(@attr.merge(:name => "")).should_not be_valid
      end
      
      it "should reject long names" do
        GalAlbum.new(@attr.merge(:name => ("a"*51))).should_not be_valid
      end
    end
    
    describe "description" do
      
      it "should reject long description" do
        GalAlbum.new(@attr.merge(:description => ("a"*256))).should_not be_valid
      end
    end
    
    describe "permalink" do
      
      it "should require a permalink" do
        category = GalAlbum.new(@attr.merge(:name => "",:permalink => "")).should_not be_valid
      end
      
      it "should reject long permalinks" do
        GalAlbum.new(@attr.merge(:permalink => ("a"*51))).should_not be_valid
      end
      
      it "should reject invalid permalinks" do
        ["a a", "a_a", "a*a", "a.a"].each do |invalid_permalink| 
          GalAlbum.new(@attr.merge(:permalink => invalid_permalink)).should_not be_valid
        end
      end
      
      it "should acepts valid permalinks" do
        ["a-a", "aaaa"].each do |valid_permalink|
          GalAlbum.new(@attr.merge(:permalink => valid_permalink)).should be_valid
        end
      end
      
      it "should reject duplicated permalinks" do
        GalAlbum.create!(@attr)
        GalAlbum.new(@attr).should_not be_valid
      end
    end
    
    describe "status" do
      
      it "should require an status" do
        GalAlbum.new(@attr.merge(:status => "")).should_not be_valid
      end
    end
  end
  
  describe "status attribute" do
    
    it "should be 0 by default" do
      @attr.delete(:status)
      GalAlbum.new(@attr).status.should == 0
    end
  end
  
  describe "relationships" do
    
    before(:each) do
      @gal_album = GalAlbum.new(@attr)
    end
    
    it "should respond to gal_category" do
      @gal_album.should respond_to(:gal_category)
    end
    
    it "should have the right associated gal_category" do
      @gal_album.gal_category_id.should == @gal_category.id
      @gal_album.gal_category.should == @gal_category
    end
  end
  
  describe "set_permalink method" do
    
    it "should only call if permalink is blank" do
      GalAlbum.create!(@attr).permalink.should == @attr[:permalink]
    end
    
    it "should create a permalink if self is blank" do
      GalAlbum.create!(@attr.merge(:permalink => "")).permalink.should == @attr[:name].parameterize
    end
    
    it "should create a permalink if self is nil" do
      @attr.delete(:permalink)
      GalAlbum.create!(@attr).permalink.should == @attr[:name].parameterize
    end
    
    it "should change special chars" do
      @attr.delete(:permalink)
      GalAlbum.create!(@attr.merge(:name => 'áñí')).permalink.should == "ani"
    end
  end
end
