module Expressions
  def self.is_an_expression?(ex)
    [Integer, Hash, String].include?(ex.class)
  end
  def self.to_field(expression)
    expression.is_a?(Symbol) ? "$#{expression}" : expression
  end
  module Operators
    module BooleanAggregationOperators
      def _and(*expressions)
        expressions = expressions.map { |ex| Expressions.to_field(ex) }
        { :$and => expressions }
      end

      def _or(*expressions)
        expressions = expressions.map { |ex| Expressions.to_field(ex) }
        { :$or => expressions }
      end

      def _not(*expressions)
        expressions = expressions.map { |ex| Expressions.to_field(ex) }
        { :$not => expressions }
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
          ex1 = Expressions.to_field(ex1)
          ex2 = Expressions.to_field(ex2)
          { "$#{cmp}" => [ex1, ex2] }
        end
      end
    end

    module ArithmeticAggregationOperators
      %w(add substract multiply divide mod).each do |cmp|
        define_method(cmp) do |ex1, ex2|
          ex1 = Expressions.to_field(ex1)
          ex2 = Expressions.to_field(ex2)
          { "$#{cmp}" => [ex1, ex2] }
        end
      end
      def trunc(number)
        {
          :$trunc => Expressions.to_field(number)
        }
      end

      def ceil
      end

      def floor
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
        { :$size => Expressions.to_field(field) }
      end

      def map(input:, as:, _in:)
        { :$map => { input: Expressions.to_field(input), as: as, in: Expressions.to_field(_in) } }
      end

      def slice
      end

      def array_elem_at(array, i)
        { :$arrayElemAt => [Expressions.to_field(array), i] }
      end

      def concat_arrays(arrays)
        { :$concatArrays => arrays }
      end

      def is_array
      end

      def filter(array_name, as, condition)
        {
          :$filter =>
            {
              input: array_name,
              as: as,
              cond: condition
            }
        }
      end
    end

    module VariableAggregationOperators
      def let(vars:, _in:)
        { :$let => { vars: vars, in: _in } }
      end
    end

    module DateAggregationOperators
      %w(day_of_year day_of_month day_of_week year month week hour minute second millisecond).each do |date_operator|
        define_method(date_operator) do |field|
          date_operator = date_operator.split('_').map
                          .with_index { |w, i| i == 0 ? w : w.capitalize }.join
          { "$#{date_operator}" => Expressions.to_field(field) }
        end
      end

      def date_to_string(field, format)
        { :$dateToString => { format: format, date: "$#{field}" } }
      end
    end

    module ConditionAggregationOperators
      def cond(hash)
        { :$cond => [hash[:if], hash[:then], hash[:else]] }
      end

      def if_null(expression, _then)
        { :$ifNull => [expression, _then] }
      end
    end
  end

  module AccumulatorsAggregationOperators
    %w(sum avg first last max min push addToSet stdDevSamp stdDevPop).each do |acc|
      define_method(acc) do |field|
        { "$#{acc}" => Expressions.to_field(field) }
      end
    end
  end
end
