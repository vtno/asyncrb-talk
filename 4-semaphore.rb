require 'async'
require 'async/semaphore'
require 'benchmark'

def print_message(msg, sem)
  5.times do |i|
    sem.async do
      puts "#{msg} #{i}"
      sleep(0.5)
    end
  end
end

sem = Async::Semaphore.new(2)

Benchmark.bm do |x|
  x.report do
    Async { print_message("Hello", sem) }
  end
end
