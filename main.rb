RES_PATH = "ff/res.txt"
DATA_PATH = "ff"
File.open(RES_PATH, "a") do |f|
  text=""
  year = 10..99
  month = 1..12
  day = 1..31
  year.each do |y|
    month.each do |m|
      day.each do |d|
        Dir.glob("#{DATA_PATH}/#{y}/#{m}/#{d}.txt") do |txt|
          line_count = 0 
          File.open("#{txt}").each do  |line|
            f << line        
            file = "#{txt}"
          end
        end
      end
    end
  end
end
lines = File.open(RES_PATH).each_line.count
puts "Total lines: #{lines}" 
puts "Res in: #{RES_PATH}"