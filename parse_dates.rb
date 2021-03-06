require 'csv'
raise unless filename = ARGV[0]
# tbl = CSV.read(filename, col_sep:"\t", headers: :first_row)

tbl = File.readlines(filename).map{|row| row.chomp.split("\t") }
hdr = tbl.shift
tbl = tbl.map{|l| l + ['-'] * (hdr.size - l.size) }

idx = hdr.index('check_date')

puts [*hdr, 'month', 'day', 'weekday', 'yearday'].join("\t")

tbl.each{|row|
begin
  dt = row[idx]
  date = dt && !dt.empty? && Date.parse(dt)
  additional = date ? [date.month, date.day, date.wday, date.yday] : [-1,-1,-1, -1]
  puts [*row, *additional].join("\t")
rescue
  $stderr.puts row[idx].inspect
  raise
end
}
