require 'async'
require 'async/barrier'
require 'securerandom'
require 'benchmark'

def worker
  sleep(1)
  SecureRandom.hex(10)
end

Benchmark.bm do |x|
  results = []
  x.report(:seq) do
    5.times do
      results << worker
    end
  end
  puts results
end

puts "----------"

Benchmark.bm do |x|
  results = []
  x.report(:async) do
    Async do
      tasks = []
      5.times do
        tasks << Async { results << worker }
      end
      tasks.each(&:wait)
    end
  end
  puts results
end

puts "----------"

Benchmark.bm do |x|
  results = []
  x.report(:barrier) do
    Async do
      barrier = Async::Barrier.new
      5.times do
        barrier.async do
          results << worker
        end
      end
      barrier.wait
    end
  end
  puts results
end
