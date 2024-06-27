require 'async'
require 'async/semaphore'
require 'benchmark'

def snake_case(str)
  str.gsub(/\W+/, '_').gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase
end

semaphore = Async::Semaphore.new(20)
file_path = 'output.txt'

Benchmark.bm do |x|
  x.report(:async) do
    Async do
      File.open(file_path, 'r').each do |line|
        semaphore.async do
          snake_cased_line = snake_case(line.chomp)
        end
      end
    end
  end

  x.report(:sequencial) do
    File.open(file_path, 'r').each do |line|
      snake_cased_line = snake_case(line.chomp)
    end
  end
end
