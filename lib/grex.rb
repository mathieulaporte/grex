require 'mongo'
require 'grex/refined_hash'
require 'grex/refined_symbol'
require 'grex/core_methods'

module Grex

  ASC     = 1
  DESC    = -1
  PRUNE   = "$$PRUNE"
  DESCEND = "$$DESCEND"

  TYPE                 = {}
  TYPE[Float]          = 1
  TYPE[String]         = 2
  TYPE[Hash]           = 3
  TYPE[Array]          = 4
  TYPE[BSON::ObjectId] = 7
  TYPE[Boolean]        = 8 if defined? Boolean
  TYPE[Date]           = 9
  TYPE[nil]            = 10
  TYPE[Regexp]         = 11

  include RefinedHash
  include RefinedSymbol
  include CoreMethods

  module ClassMethods
    include CoreMethods
    def collection(c = nil)
      if c
        @collection = c
      else
        @collection
      end
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
    if defined?(Mongoid) && base.ancestors.include?(Mongoid::Document)
      base.collection(base.collection_name)
    end
  end

  class Config
    def self.connection=(mongo_connection)
      @@connection = mongo_connection
    end

    def self.connection
      @@connection
    end
  end

  def self.config
    yield Config
  end
end