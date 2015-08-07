module Expressions
  def self.is_an_expression?(ex)
    [Integer, Hash].include?(ex.class)
  end
  module Operators
    module BooleanAggregationOperators
      def _and(*queries)
        { :$and => queries }
      end

      def _or(*queries)
        { :$or => queries }
      end

      def _not(*queries)
        { :$not => queries }
      end
    end

    module SetAggregationOperators
      def set_equals(*expressions)
        { :$setEquals => expressions }
      end

      def set_intersection(*arrays)
        { :$setIntersection => arrays }
      end

      def set_union(*expressions)
        { :$setUnion => expressions }
      end

      def set_difference(array1, array2)
        { :$setDifference => [array1, array2] }
      end

      def set_is_subset(array1, array2)
        { :$setIsSubset => [array1, array2] }
      end

      def any_element_true(array)
        { :$anyElementTrue => [array] }
      end

      def all_elements_true(array)
        { :$allElementTrue => [array] }
      end
    end

    module ComparatorAggregationOperators
      %w(cmp eq gt gte lt lte ne).each do |cmp|
        define_method(cmp) do |ex1, ex2|
          ex1 = ex1.is_a?(Symbol) ? "$#{ex1}" : ex1
          ex2 = ex2.is_a?(Symbol) ? "$#{ex2}" : ex2
          { "$#{cmp}" => [ex1, ex2] }
        end
      end
    end

    module ArithmeticAggregationOperators
      def add(ex1, ex2)
        ex1 = Expressions.is_an_expression?(ex1) ? ex1 : "$#{ex1}"
        ex2 = Expressions.is_an_expression?(ex2) ? ex2 : "$#{ex2}"
        { :$add => [ex1, ex2] }
      end
      def subtract(field)
      end
      def multiply(field)
      end
      def divide(field)
      end
      def mod(field)
      end
    end

    module StringAggregationOperators
      def concat(field)
      end
      def substr(field)
      end
      def toLower(field)
      end
      def toUpper(field)
      end
      def strcasecmp(field)
      end
    end

    module SearchAggregationOperators
      def meta(key)
      end
    end

    module ArrayAggregationOperators
      def size(field)
        { :$size => "$#{field}" }
      end

      def map(input:, as:, _in:)
        { input: input, as: as, in: _in }
      end
    end

    module VariableAggregationOperators
      def let
      end
    end

    module DateAggregationOperators
      def day_of_year(field)
        field.to_sym
      end

      def day_of_month(field)
        field.to_sym
      end

      def day_of_week(field)
        field.to_sym
      end

      def year(field)
        field.to_sym.year
      end

      def month(field)
        field.to_sym
      end

      def week(field)
        field.to_sym
      end

      def hour(field)
        field.to_sym
      end

      def minute(field)
        field.to_sym
      end

      def second(field)
        field.to_sym
      end

      def millisecond(field)
        field.to_sym
      end

      def date_to_string(field, format)
        { :$dateToString => { format: format, date: "$#{field}" } }
      end
    end

    module ConditionAggregationOperators
      def cond(_if, _then, _else)
        { :$cond => [_if, _then, _else] }
      end

      def if_null(expression, _then)
        { :$ifNull => [expression, _then] }
      end
    end
  end

  module AccumulatorsAggregationOperators
    %w(sum avg first last max min push addToSet).each do |acc|
      define_method(acc) do |field|
        case field
        when Symbol
          { "$#{acc}" => "$#{field}" }
        else
          { "$#{acc}" => field }
        end
      end
    end
  end
end
