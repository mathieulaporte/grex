# require './lib/grex'
# require 'grex'
class UserAggregation
  include Grex

  def five_most_common_likes
    generate_aggregation(
      unwind(:like),
      group_by(:likes) do
        { number: sum(1) }
      end,
      sort_by(number: DESC),
      limit(5)
    )
  end

  def total_join_by_month
    generate_aggregation(
      group_by(:join_at.month) do
        { number: sum(1) }
      end,
      sort_by(id: ASC)
    )
  end

end

UserAggregation.new.five_most_common_likes
UserAggregation.new.total_join_by_month
