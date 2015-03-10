require 'open-uri'
require 'zlib'
require 'yajl'
require 'mongo'



COMMON_YEAR_DAYS_IN_MONTH = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

def days_in_month(month, year = Time.now.year)
   return 29 if month == 2 && Date.gregorian_leap?(year)
   COMMON_YEAR_DAYS_IN_MONTH[month]
end

db = Mongo::Connection.new['github']

(1...3).each do |month|
  puts "Month #{month}"
  (1..days_in_month(month)).each do |day|
    puts "Day #{day}"
    (0...23).each do |hour|
      puts "Hour #{hour}"
      puts "http://data.githubarchive.org/2015-0#{month}-0#{day}-#{hour}.json.gz"
      gz = open(URI.encode("http://data.githubarchive.org/2015-0#{month}-0#{day}-#{hour}.json.gz"))
      js = Zlib::GzipReader.new(gz).read
      Yajl::Parser.parse(js) do |event|
        db['events'] << event
      end
    end
  end
end

# db['events'].find.each{ |event| db['events'].update({ _id:  event['_id'] }, { '$set' => {  created_at: Time.parse(event['created_at']) } })}
# db['events'].aggregate([{:$group=>{:_id=>{:$dayOfMonth=>"$created_at"}, :number=>{:$sum => 1}}}])
# nb d'event par type et par jour
# nb d'event par jour sur le repo rails
# le repo qui à le plus d'activité par semaine
# temps moyen entre 2 pull request sur un projet
# 10 projets les plus actif
# Combien de fois le mot wikipedia apparait dans les conversations par jours
# le user le plus actif db['events'].aggregate([{:$group=>{:_id=>{:day=>{:$dayOfMonth=>"$created_at"}, :user=>"$actor.id"}, :count=>{:$sum=>1}}}, {:$sort=>{:count=>-1}}, {:$limit=>5}, {:$out => 'actif'}])