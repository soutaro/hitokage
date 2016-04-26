require "benchmark"
require "hitokage"

def run(message, count, range)
  values = count.times.map { rand(range) }

  puts "🐉 #{message}, count=#{count}, range=#{range}"
  Benchmark.bm 20 do |r|
    r.report "Float#to_s" do
      values.each(&:to_s)
    end

    r.report "Float#hitokage_to_s" do
      values.each(&:hitokage_to_s)
    end
  end

  print "Verifying results..."
  STDOUT.flush
  to_s_results = values.map(&:to_s).map(&:to_f)
  hitokage_results = values.map(&:hitokage_to_s).map(&:to_f)
  puts(to_s_results == hitokage_results ? "👍" : "😵")
  puts
end

count = 5000000

run "Small float numbers", count, 0.0...1.0
run "Usual float numbers", count, 0.0...10000000.0
run "Big floats numbers", count, 1e20...1e30
