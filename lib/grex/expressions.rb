module Expressions
  module Operators
    module Boolean
      def and(field)
      end
      def or(field)
      end
      def not(field)
      end
    end

    module Set
      def setEquals(field)
      end
      def setIntersection(field)
      end
      def setUnion(field)
      end
      def setDifference(field)
      end
      def setIsSubset(field)
      end
      def anyElementTrue(field)
      end
      def allElementsTrue(field)
      end
    end

    module Comparator
      def cmp(field)
      end
      def eq(field)
      end
      def gt(field)
      end
      def gte(field)
      end
      def lt(field)
      end
      def lte(field)
      end
      def ne(field)
      end
    end

    module Arithmetic
      def add(field)
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

    module String
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

    module Search
      def meta(key)
      end
    end

    module Array
      def size(field)
      end
      def map(field)
      end
    end

    module Variable
      def let
      end
    end

    module Date
      def day_of_year(field)
      end
      def day_of_month(field)
      end
      def day_of_week(field)
      end
      def year(field)
      end
      def month(field)
      end
      def week(field)
      end
      def hour(field)
      end
      def minute(field)
      end
      def second(field)
      end
      def millisecond(field)
      end
    end

    module Condition
      def cond
      end

      def if_null
      end
    end
  end

  module Accumulators
    def sum(field)
      case field
      when String, Symbol
        { :$sum => "$#{field}" }
      when Numeric
        { :$sum => field }
      end
    end
    def avg(key)
    end
    def first(field)
      { :$first => "$#{field}" }
    end
    def last(field)
      { :$last => "$#{field}" }
    end
    def max(key)
    end
    def min(key)
    end
    def push(key)
    end
    def addToSet(key)
    end
  end
end