# require './lib/grex'
# require 'grex'
class Events
  include Grex

  def by_day_and_type
    generate_aggregation(
      group_by({:day => :created_at.day, type: '$type'}) do
        { count: sum(1) }
      end
    )
  end

  def activ_users
    generate_aggregation(
      group_by({:day => :created_at.day, user: '$actor.id'}) do
        { count: sum(1) }
      end,
      sort_by(count: DESC),
      limit(5)
    )
  end

end

Events.new.by_day_and_type
Events.new.activ_users
