module Grex
  module Stages
    def project(h)
      { :$project => h }
    end

    def match(h = {})
      h.merge(block_given? ? yield : {})
      {
        :$match => h
      }
    end
    alias_method query match

    def redact(h)
      { :$redact => h }
    end

    def limit(n)
      { :$limit => n }
    end

    def skip(n)
      { :$skip => n }
    end

    def unwind(sym)
      { :$unwind => "$#{sym}" }
    end

    def group_by(keys)
      {
        :$group => {
          _id: parse_keys(keys)
        }.merge(block_given? ? yield : {})
      }
    end

    def sort_by(keys)
      {
        :$sort => keys
      }
    end

    def geo_near
    end

    def out(collection_name)
      { :$out => collection_name }
    end

    private

    def parse_keys(keys)
      case keys
      when Hash
        return keys
      when Symbol, String
        return { keys => "$#{keys}" }
      when Array
        return Hash[keys.map { |key| [key, "$#{key}"] }]
      else
        fail 'Must be a Hash, Symbol or Array'
      end
    end
  end
end
