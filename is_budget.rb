require 'csv'
raise unless filename = ARGV[0]
# tbl = CSV.read(filename, col_sep:"\t", headers: :first_row)

tbl = File.readlines(filename).map{|row| row.chomp.split("\t") }
hdr = tbl.shift
tbl = tbl.map{|l| l + ['-'] * (hdr.size - l.size) }

idx = hdr.index('company_name')


puts [*hdr, 'isbudget','ishousing', 'isooo'].join("\t")

tbl.each{|row|
begin  
  isbudget = row[idx]&.match(/государственн|бюджетн|муниципальн|казенн/i)
  ishousing = row[idx]&.match(/жилищн|/i)
  isooo = row[idx]&.match(/ОГРАНИЧЕННОЙ ОТВЕТСТВЕННОСТЬЮ|/i)
  puts (row + [(isbudget ? 1 : 0), (ishousing ? 1 : 0), (isooo ? 1 : 0)]).join("\t")
rescue
  $stderr.puts row[idx].inspect
  raise
end
}
