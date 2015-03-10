require 'mongo'
require File.expand_path(File.dirname(__FILE__) + '/grex/expressions')
require File.expand_path(File.dirname(__FILE__) + '/grex/stages')
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
  TYPE[Time]           = 9
  TYPE[nil]            = 10
  TYPE[Regexp]         = 11

  include Stages
  include Expressions::Operators
  include Expressions::Accumulators

  def self.aggregate
    generate_aggregation(yield)
  end

  def generate_aggregation(*args)
    raise 'Wrong parameters' unless args.map{ |arg| arg.kind_of?(Hash) }.reduce(&:&)
    args
  end

  # module ClassMethods
  #   include CoreMethods
  #   def grex_collection(c = nil)
  #     if c
  #       @grex_collection = c
  #     else
  #       @grex_collection
  #     end
  #   end
  # end

  # def self.included(base)
  #   base.extend(ClassMethods)
  #   if defined?(Mongoid) && base.ancestors.include?(Mongoid::Document)
  #     base.grex_collection(base.collection_name)
  #   end
  # end

  # class Config
  #   def self.connection=(mongo_connection)
  #     @@connection = mongo_connection
  #   end

  #   def self.connection
  #     @@connection
  #   end
  # end

  # def self.config
  #   yield Config
  # end
end

class Symbol
  def gt(sym)
    { self => { :$gt => sym } }
  end
  def lt(sym)
    { self => { :$lt => sym } }
  end
  def gte(sym)
    { self => { :$gte => sym } }
  end
  def lte(sym)
    { self => { :$lte => sym } }
  end

  def type(type)
    { self => { :$type => Grex::TYPE[type] } }
  end

  def year
    { :$year => "$#{self}" }
  end

  def month
    { :$month => "$#{self}" }
  end

  def day
    { :$dayOfMonth => "$#{self}" }
  end

  def week
    { :$week => "$#{self}" }
  end

  def hour
    { :$hour => "$#{self}" }
  end
end