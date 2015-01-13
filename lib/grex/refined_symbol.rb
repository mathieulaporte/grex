module RefinedSymbol
  refine Symbol do
    def year
      { :$year => "$#{self.to_s.split('.').first}" }
    end

    def month
      { :$month => "$#{self.to_s.split('.').first}" }
    end

    def day
      { :$dayOfMonth => "$#{self.to_s.split('.').first}" }
    end

    def +(sym)
      { :$add => ["$#{self}", sym] }
    end

    def -(sym)
      { :$subtract => [self, sym] }
    end

    def /(sym)
      { :$divide => [self, sym] }
    end

    def size
      { :$size => "$#{self.to_s.split('.').first}"}
    end

    def cond(h = { :if => nil , :then => nil, :else => nil })
      { self => { :$cond => [ h[:if], h[:then], h[:else] ] } }
    end

    def if_null(h = { :if => nil, :then => nil})
      { self => { :$ifNull => [ h[:if], h[:then] ]} }
    end

    def <(sym)
      { :$gt => [self, sym] }
    end

    def <=(sym)
      { :$gt => [self, sym] }
    end

    def >(sym)
      { :$lt => [self, sym] }
    end

    def >=(sym)
      { :$lte => [self, sym] }
    end

    def ==(sym)
      { :$eq => [ self, sym ] }
    end

    def !=(sym)
      { :$ne => [ self, sym ] }
    end

    def type(_type)
      { self => { :$type => Grex::TYPE[_type] } }
    end
  end
end