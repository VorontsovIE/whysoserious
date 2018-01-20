require 'csv'
raise unless filename = ARGV[0]
# tbl = CSV.read(filename, col_sep:"\t", headers: :first_row)

tbl = File.readlines(filename).map{|row| row.chomp.split("\t") }
hdr = tbl.shift
tbl = tbl.map{|l| l + ['-'] * (hdr.size - l.size) }

idx = hdr.index('okved_osn_code')

puts [*hdr, 'osn_1', 'osn_1_2'].join("\t")

tbl.each{|row|
begin
  osn = row[idx].split('.')
  additional = [1,2].map{|sz| osn.first(sz).join('.') }
  puts (row + additional).join("\t")
rescue
  $stderr.puts row[idx].inspect
  raise
end
}
