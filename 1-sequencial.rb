require 'benchmark'

def print_message(msg)
  5.times do |i|
    puts "#{msg} #{i}"
    sleep(0.5)
  end
end

Benchmark.bm do |x|
  x.report { print_message("Hello") }
end
