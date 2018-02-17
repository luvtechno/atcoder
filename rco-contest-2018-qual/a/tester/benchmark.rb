require 'benchmark'

BASIC_LENGTH = 10000

5.times do |factor|
  length = BASIC_LENGTH * (10 ** factor)
  puts "_" * 60 + "\nLENGTH: #{length}"

  Benchmark.bm(10, 'String VS Array') do |x|
    string_report = x.report("String")  do
      s = ''
      length.times { s << 'U' }
    end

    array_report = x.report("Array")  do
      a = []
      length.times { a << 'U' }
      a.join
    end

    [string_report / array_report]
  end
end
