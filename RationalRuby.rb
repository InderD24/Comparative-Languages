class MyRational

    attr_reader :num, :den
  
    #initialize method
    def initialize(num, denom)
  
    if denom == 0    
      begin
        raise ArgumentError.new("A value of 0 is not valid for the denominator, I will set it to 1 for you")
      rescue ArgumentError => err_msg
        puts err_msg
        end
      @num = num
      @den = 1
      return
      end 
  
      @num = num
      @den = denom
    end 
  
  #2
    def num
      @num
    end
  #3
    def denom
      @den
    end
  
  #4
    def pair()
      pairs = Array[num, denom]
      return pairs
    end
  #5
    def to_s()
      numer = num.to_s
      denomin = den.to_s
      str = (numer + "/" + denomin)
      return str
    end
  #6
    def to_f()
      numer = num.to_f
      denomin = den.to_f
      res = numer / denomin
      return res
    end 
  
  #7
    def ==(other)
      rat = (num * other.den)
      rat1 = (other.num * denom)
      rat == rat1
    end 
  #8
    def <=>(other)
      rat = (num * other.den)
      rat1 = (other.num * denom)
      rat <=> rat1
    end
  #9
    def int?()
      num % denom == 0
    end
  #10
    def +(other)
      numer = (num * other.den)
      denom = (den * other.den)
      a = (den * other.num)
      b = (a + numer)
      sum  = MyRational.new(b, denom) 
      return sum
    end
  #11
    def *(other)
      top = num * other.num
      bottom = den * other.den
      res = MyRational.new(top, bottom)
      return res
    end
  #12
    def /(other)
      top = num * other.den
      bottom = den * other.num
      res = MyRational.new(top, bottom)
      return res
    end 
  #13
    def invert()
      neww = MyRational.new(den, num)
      return neww
    end
  #14
    def to_lowest_terms
      bo = den
      nu = num
      while bo != 0 
        res = bo
        bo = nu % bo
        nu = res
      end
      
      top = num / nu
      bottom = denom / nu
      return MyRational.new(top, bottom)
    end 
  
end 
  
  #outside class
  #15
   def harmonicSum(n)
      top = 1
      bottom = 1
      index = 2
  
      while index <= n
        
        top = (top * index) + bottom
        bottom = bottom * index
        index = index + 1
      end 
     
    return MyRational.new(top, bottom).to_lowest_terms
     
    end
  
class Integers < MyRational
    def initialize(num)
      @num = num
    end
  
   #to_mr method
    def to_mr()
      numer = num
      new_den = 1
      return MyRational.new(numer,new_den)
    end
end    
  
  
  #                    PART 2
  ######################################################################################################################################################################################################################
  
  
  #Sort Array of Ints
  def InsertionSort(arr)
    
      $i = 0
      while $i < arr.length
        candidate = arr[$i]
        j = ($i - 1)
        while j >= 0 && arr[j] > candidate
          arr[j + 1] = arr[j]
          j = j - 1
        end
        arr[j + 1] = candidate
        $i += 1
      end
      print "Sorted Integer: "
       puts "#{arr}"
      return arr
    end

    #Sort Array of Rationls
    def InsertionSortrat(arr1)
    $i = 0
      while $i < arr1.length
        candidate = arr1[$i]
        j = ($i - 1)
        while j >= 0 && (arr1[j].num.to_f /  arr1[j].den.to_f) > (candidate.num.to_f /  candidate.den.to_f)
          arr1[j + 1] = arr1[j]
          j = j - 1
        end
        arr1[j + 1] = candidate
     
        $i += 1
      end
       puts arr1
      return arr1
    end

  #Sort Array of strings 
   def InsertionSortstring(arr2)
    
      $i = 0
      while $i < arr2.length
        candidate = arr2[$i]
        j = ($i - 1)
        while j >= 0 && arr2[j].to_i > candidate.to_i
          arr2[j + 1] = arr2[j]
          j = j - 1
        end
        arr2[j + 1] = candidate
        $i += 1
      end
      print "Sorted String: "
       puts "#{arr2}"
          
      return arr2
    end
  
  
  
  
  #making random array of ints
  def make_arr_int(size)
    arr = Array[]
    $i = 0
    while $i < size
      arr[$i] = rand(size*10)
      $i += 1
    end
    return arr
  end
  
  #making random array of rationals
  def make_arr_rat(size)
    arr1 = Array[]
    $i = 0
    while $i < size
      numer = rand(size * 10)
      deno = rand(1 ... size*10)
      rat = MyRational.new(numer, deno)
      arr1[$i] = rat
      $i += 1
    end
    return arr1
  end
  
  #making random Array of strings
  def make_arr_string(size)
    arr2 = Array[]
    $i = 0
    while $i < size
      arr2[$i] = rand(size*10)
      $i += 1
      $j = 0
       while $j < arr2.length
            arr2[$j] = arr2[$j].to_s
            $j += 1
       end
    end
    return arr2
  end
  
  #timing derived from https://ruby-doc.org/core-2.5.2/Process.html#method-c-clock_gettime
  def time_Sort(size, cnt)
    total_time = 0
    i = 0
    while i < cnt
      arr_int = make_arr_int(size)
      time_start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      
      InsertionSort(arr_int)
      
      time_end = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      time_elapesed = (time_end - time_start)*1000000
      total_time  = total_time + time_elapesed
      i += 1
    end
    avg_time  = total_time / cnt
    print "Sorting Integer of Size = " + size.to_s + " Avaerage of " + cnt.to_s + " runs" + " time: " + avg_time.to_s + "\n"
  
  
  
  # for rationals
    total_time = 0
    i = 0
    avg_time = 0
    while i < cnt
      arr_rat = make_arr_rat(size)
      time_start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      
      InsertionSortrat(arr_rat)
      
      time_end = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      time_elapesed = (time_end - time_start)*1000000
      total_time  = total_time + time_elapesed
      i += 1
    end
    avg_time  = total_time / cnt
    print "Sorting Rational of Size = " + size.to_s + " Avaerage of " + cnt.to_s + " runs" + " time: " + avg_time.to_s + "\n"
  
  #for strings
   total_time = 0
    i = 0
    avg_time = 0
    while i < cnt
      arr_string = make_arr_string(size)
      time_start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      
      InsertionSortstring(arr_string)
      
      time_end = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      time_elapesed = (time_end - time_start)*1000000
      total_time  = total_time + time_elapesed
      i += 1
    end
    avg_time  = total_time / cnt
    print "Sorting String of Size = " + size.to_s + " Avaerage of " + cnt.to_s + " runs" + " time: " + avg_time.to_s + "\n"
end


  frac1 = MyRational.new(4,3)
  frac2 = MyRational.new(2,9)
  intergers = Integers.new(89)
  printf ""
  puts"numerator"
  puts frac1.num()
  puts "\n"
  puts"denominator"
  puts frac1.denom()
  puts "\n"
  puts "pair"
  puts "#{frac1.pair}"
  puts "\n"
  puts "to string"
  puts frac1.to_s()
  puts "\n"
  puts "to float"
  puts frac1.to_f()
  puts "\n"
  puts "equal"
  puts (frac1 == frac2)
  puts "\n"
  puts "spaceship"
  puts (frac1 <=> frac2)
  puts "\n"
  puts"is int"
  puts frac1.int?()
  puts "\n"
  puts "add"
  puts (frac1 + frac2)
  puts "\n"
  puts "multiply"
  puts (frac1 * frac2)
  puts "\n"
  puts "divide"
  puts (frac1 / frac2)
  puts "\n"
  printf "invert\n"
  puts frac1.invert()
  puts "\n"
  puts "lowest terms "
  puts frac1.to_lowest_terms()
  puts "\n"
  puts "harmonic sum"
  puts (harmonicSum(2))
  puts "\n"
  puts "to_mr method"
  puts intergers.to_mr()
  puts "\n"
  
  
  
  x = make_arr_int(10)
  puts "\n "
  InsertionSort(x)
  puts "\n "
 
  
  y = make_arr_rat(10)
  puts "\n"
  InsertionSortrat(y)
  puts"\n"
  
  z = make_arr_string(10)
  puts "\n"
  InsertionSortstring(z)
  puts "\n"


#code for timing the sorting
#   puts "\n"
#   time_Sort(1000, 10)
#   puts "\n"
#   time_Sort(2000, 10)
#   puts "\n"
#   time_Sort(3000, 10)
#   puts "\n"
#   time_Sort(4000, 10)
#   puts "\n"
#   time_Sort(5000, 10)
#   puts "\n"
#   time_Sort(6000, 10)
#   puts "\n"
#   time_Sort(7000, 10)
#   puts "\n"
#   time_Sort(8000, 10)
#   puts "\n"
#   time_Sort(9000, 10)
#   puts "\n"
#   time_Sort(10000, 10)
