require 'async'
require 'benchmark'

def print_message(msg)
  5.times do |i|
    Async do
      puts "#{msg} #{i}"
      sleep(0.5)
    end
  end
end

Benchmark.bm do |x|
  x.report do
    Async { print_message("Hello") }
  end
end
