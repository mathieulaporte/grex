require 'mongo'
require 'grex/refined_hash'
require 'grex/refined_symbol'
require 'grex/core_methods'

module Grex

  ASC   = 1
  DESC  = -1

  include RefinedHash
  include RefinedSymbol
  include CoreMethods

  module ClassMethods

    def collection(c = nil)
      if c
        @collection = c
      else
        @collection
      end
    end

    include CoreMethods

  end

  def self.included(base)
    base.extend(ClassMethods)
    if base.ancestors.map(&:to_s).include?('Mongoid::Document')
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