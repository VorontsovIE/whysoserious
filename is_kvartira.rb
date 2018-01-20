require 'csv'
raise unless filename = ARGV[0]
# tbl = CSV.read(filename, col_sep:"\t", headers: :first_row)

tbl = File.readlines(filename).map{|row| row.chomp.split("\t") }
hdr = tbl.shift
tbl = tbl.map{|l| l + ['-'] * (hdr.size - l.size) }

idxs = ['street', 'house', 'building', 'apartment',].map{|x| hdr.index(x) }


puts [*hdr, 'iskvartira'].join("\t")

tbl.each{|row|
begin  
  additional = row.values_at(*idxs).any?{|x| x&.match(/квартира|кв\./i) }
  puts (row +  [additional ? 1 : 0]).join("\t")
rescue
  $stderr.puts row[idx].inspect
  raise
end
}
