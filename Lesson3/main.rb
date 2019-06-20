
require_relative 'station'
require_relative 'train'
require_relative 'route'

spb = Station.new("St. Petersburg")
msk = Station.new("Moscow")
nsk = Station.new("Novosibirsk")
cnx = Station.new("Chiang Mai")

summerweekend = Route.new(spb, cnx)

sapsan_express = Train.new(1, "passenger", 5)
yellow_arrow = Train.new(2, "cargo", 10)

summerweekend.add_station(msk)
summerweekend.add_station(nsk)


sapsan_express.take_route(summerweekend)
yellow_arrow.take_route(summerweekend)
