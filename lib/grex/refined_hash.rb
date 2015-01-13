module RefinedHash
  refine Hash do
    def year
      { :$year => self }
    end

    def month
      { :$month => self }
    end

    def day
      { :$dayOfMonth => self }
    end
  end
end