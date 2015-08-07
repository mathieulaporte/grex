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
  include Expressions::Operators::BooleanAggregationOperators
  include Expressions::Operators::ArithmeticAggregationOperators
  include Expressions::Operators::ArrayAggregationOperators
  include Expressions::Operators::DateAggregationOperators
  include Expressions::Operators::ConditionAggregationOperators
  include Expressions::AccumulatorsAggregationOperators

  def self.aggregate
    generate_aggregation(yield)
  end

  def generate_aggregation(*args)
    fail 'Wrong parameters' unless args.map{ |arg| arg.kind_of?(Hash) }.reduce(&:&)
    args
  end
end

class Symbol
  def type(type)
    { self => { :$type => Grex::TYPE[type] } }
  end
end
