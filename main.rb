require 'csv'

RES_PATH = "ff/result.csv"
DATA_PATH = "ff"
class Converter
  File.open(RES_PATH, "a") do |f|
    f << "Year,Month,Day,Hour,Minute,Second,Temperature,Humidity,Pressure\n"
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
  @csvfile = RES_PATH
  table = CSV.table(@csvfile)

  # data filtering
  table.delete_if do |row|
    row[7].to_i > 100 || row[6].to_f > 40.0
  end

  # data recording
  File.open('ff/filtering.csv', 'w') do |f|
    f.write(table.to_csv)
  end
end

@data = Converter.new
@filter = DataFilter.new
