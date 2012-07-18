#!/usr/bin/ruby
# Generate all primes up to 10000
# This question is calculation for natural number less than 10000.
# Pick up prime numbers at an interval of 100 and count them, after that, output by following
# format.

# 2-100: 2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97 : 25
# 101-200: 101 103 107 109 113 127 131 137 139 149 151 157 163 167 173 179 181 191
# 193 197 199 : 21
# 201-300: 211 223 227 229 233 239 241 251 257 263 269 271 277 281 283 293 : 16
# 301-400: 307 311 313 317 331 337 347 349 353 359 367 373 379 383 389 397 : 16
# ...
# 9801-9900: 9803 9811 9817 9829 9833 9839 9851 9857 9859 9871 9883 9887 : 12
# 9901-10000: 9901 9907 9923 9929 9931 9941 9949 9967 9973 : 9

$all_primes = Hash.new
$all_primes_array = Array.new
$interval_size = 100

# check if any prime from 2 to sqrt(`num`) is a factor of `num`
def is_prime? num
  $all_primes_array.each do |possible_factor|
    return true if possible_factor > Math.sqrt(num)
    return false if (num % possible_factor == 0)
  end
  return true
end

# returns a Hash of arrays, key is the min of the range to be printed 
def generate_primes_until num
  $all_primes = Hash.new
  (2..num).each do |possible_prime|
    if is_prime? possible_prime
      key = (round_to_interval possible_prime)+1
      key = 2 if key==1
      $all_primes[key] = Array.new if $all_primes[key].nil?
      $all_primes[key].push(possible_prime)
      $all_primes_array.push(possible_prime)
    end
  end
  return $all_primes
end

# prints directly without saving more than one range in memory at a time
def print_primes_until num
  current_min = 2
  current_range = Array.new
  $all_primes_array = Array.new
  (2..num).each do |possible_prime|
    if is_prime? possible_prime
      prime_range_min = (round_to_interval possible_prime)+1
      prime_range_min = 2 if prime_range_min==1
  
      if (prime_range_min > current_min)
        puts "#{current_min}-#{round_to_interval(current_min+100)}: #{current_range.join(" ")} : #{current_range.length}"
        current_range = [possible_prime]
        current_min = prime_range_min
      else
        current_range.push(possible_prime)
      end
      $all_primes_array.push(possible_prime)
    end
  end
  # flush the remaining
  puts "#{current_min}-#{round_to_interval(current_min+100)}: #{current_range.join(" ")} : #{current_range.length}"
  return nil
end

def round_to_interval num
  num / $interval_size * $interval_size
end

def print_primes
  $all_primes.sort.each do |min, primes|
    puts "#{min}-#{round_to_interval(min+100)}: #{primes.join(" ")} : #{primes.length}"
  end
end

# main
if __FILE__ == $0
  default_number = 10000
  #ARGV[0].nil? ? generate_primes_until(default_number) : generate_primes_until(ARGV[0].to_i)
  #print_primes
  ARGV[0].nil? ? print_primes_until(default_number) : print_primes_until(ARGV[0].to_i)

end

