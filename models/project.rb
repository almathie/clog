class Project
  include MongoMapper::Document

  attr_accessible :name, :user, :tags
  #accepts_nested_attributes_for :tags

  key :name,    String
  key :user,    String
  
  #many :tags

  timestamps!
end