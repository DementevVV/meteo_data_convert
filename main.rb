require 'csv'

RES_PATH = "ff/result.csv"
DATA_PATH = "ff"
class Converter
  File.open(RES_PATH, "a") do |f|
    f << "Year,Month,Day,Hour,Minute,Second,Temp,Hum,Press\n"
    # text=""
    year = 10..99
    month = 1..12
    day = 1..31
    year.each do |y|
      month.each do |m|
        day.each do |d|
          Dir.glob("#{DATA_PATH}/#{y}/#{m}/#{d}.txt") do |txt|
            line_count = 0
            File.open("#{txt}").each do  |line|
              f << line.split(/[\/,:, ]/).join(',')
              file = "#{txt}"
            end
          end
        end
      end
    end
  end
end

class DataFilter
  # CSV.foreach(RES_PATH) do |row|
  #   row[6] = row[6].to_f ## Temperature to float
  #   row[7] = row[7].to_i ## Hum to integer
  #   row[8] = row[8].to_f ## Press to float
  #   row.delete(row) if row[6] > 40
  #   puts "Error" if row[6] > 40
  # end
  @csvfile = RES_PATH
  table = CSV.table(@csvfile)

  table.delete_if do |row|
    row[7].to_i > 100 || row[6].to_f > 40.0
  end

  File.open('ff/filtering.csv', 'w') do |f|
    f.write(table.to_csv)
  end
end

# lines = File.open(RES_PATH).each_line.count
# puts "Total lines: #{lines}"
@data = Converter.new
@filter = DataFilter.new
