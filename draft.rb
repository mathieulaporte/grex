# db.zipcodes.aggregate( [
#    { $group:
#       {
#         _id: { state: "$state", city: "$city" },
#         pop: { $sum: "$pop" }
#       }
#    },
#    { $sort: { pop: 1 } },
#    { $group:
#       {
#         _id : "$_id.state",
#         biggestCity:  { $last: "$_id.city" },
#         biggestPop:   { $last: "$pop" },
#         smallestCity: { $first: "$_id.city" },
#         smallestPop:  { $first: "$pop" }
#       }
#    }
#    )

#    group(by: [:state, :city], pop: sum(:pop)),
#    sort(by: { pop: ASC }),
#    group( by: :_id['state'],
#           biggestCity:  last(:_id['city']),
#           biggestPop:   first(:pop),
#           smallestCity: last(:_id['city']),
#           smallestPop:  first(:pop))


# # Example of use

# generate_aggregation(
#   group_by([:state, :city]) do
#     { pop: sum(:pop) }
#   end,
#   sort_by(pop: 1),
#   group_by("_id.state") do
#     {
#       biggestCity:  last("_id.city"),
#       biggestPop:   last("pop"),
#       smallestCity: first("_id.city"),
#       smallestPop:  first("pop")
#     }
#   end
# )

