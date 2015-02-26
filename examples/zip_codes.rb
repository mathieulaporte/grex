class ZipCodeAggregation
  include Grex

  def states_with_population_gt(min_value)
    generate_aggregation(
      group_by(:state){ { total_pop: sum(:pop) } },
      match(:total_pop.gt min_value)
    )
  end

  def avg_population_by_city_and_state
    generate_aggregation(
      group_by([:state, :city]){ { pop: sum(:pop) } },
      group_by('_id.state'){ { avg_city_pop: avg(:pop) } }
    )
  end

  def smallest_and_largest_cities_by_population
    generate_aggregation(
      group_by([:state, :city]){ { pop: sum(:pop) } },
      sort_by(pop: 1),
      group_by("_id.state") do
        {
          biggestCity:  last("_id.city"),
          biggestPop:   last("pop"),
          smallestCity: first("_id.city"),
          smallestPop:  first("pop")
        }
      end
    )
  end

end


ZipCodeAggregation.new.states_with_population_gt(10*1000*1000)
ZipCodeAggregation.new.avg_population_by_city_and_state
ZipCodeAggregation.new.smallest_and_largest_cities_by_population