require 'csv'
raise unless filename = ARGV[0]
tbl = CSV.read(filename, col_sep:',', headers: :first_row)

puts ['month', 'day', 'weekday', 'yearday'].join("\t")

tbl.lazy.map{|row|
  row['check_date']
}.map{|dt|
  dt && Date.parse(dt)
}.map{|date|
  date ? [date.month, date.day, date.wday, date.yday] : [-1,-1,-1, -1]
}.each{|infos|
  puts infos.join("\t")
}
