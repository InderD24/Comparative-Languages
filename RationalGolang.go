package main 

import(
    "fmt"
    "strconv"
    "errors"
    "time"
    "math/rand"
  
)

type Floater64 interface {
    // Converts a value to an equivalent float64.
    toFloat64() float64
}

type Rationalizer interface {

    // 5. Rationalizers implement the standard Stringer interface.
    fmt.Stringer

    // 6. Rationalizers implement the Floater64 interface.
    Floater64

    // 2. Returns the numerator.
    Numerator() int

    // 3. Returns the denominator.
    Denominator() int

    // 4. Returns the numerator, denominator.
    Split() (int, int)

    // 7. Returns true iff this value equals other.
    Equal(other Rationalizer) bool

    // 8. Returns true iff this value is less than other.
    LessThan(other Rationalizer) bool

    // 9. Returns true iff the value equal an integer.
    IsInt() bool

    // 10. Returns the sum of this value with other.
    Add(other Rationalizer) Rationalizer

    // 11. Returns the product of this value with other.
    Multiply(other Rationalizer) Rationalizer

    // 12. Returns the quotient of this value with other. The error is nil 
    // if its is successful, and a non-nil if it cannot be divided.
    Divide(other Rationalizer) (Rationalizer, error)

    // 13. Returns the reciprocal. The error is nil if it is successful, 
    Invert() (Rationalizer, error)

    // 14. Returns an equal value in lowest terms.
    ToLowestTerms() Rationalizer
} // Rationalizer interface

type Rational struct{
    numerator int
    denominator int
    Value float64
}
//1
func makeRational(n int, d int) (Rational, error) {

   var err error
   err = nil
   if d == 0{
    return Rational {n,d, (float64(n)/float64(d))}, errors.New("You cannot divide by zero")
    } 
    return Rational {n, d, (float64(n)/float64(d))}, err
    
}

//2
func (r Rational)Numerator() int{

    return r.numerator
}
//3
func (r Rational)Denominator() int{

    return r.denominator
}
//4
func (r Rational)Split() (int, int){

    return r.numerator, r.denominator

}
//5
func (r Rational)String() string{

     str1:= strconv.Itoa(r.numerator)
     str2:= strconv.Itoa(r.denominator)
     var res string
     res = str1 + "/" + str2
    
 return res

}
//6
func (r Rational)toFloat64() float64{

    return (float64(r.numerator) /  float64(r.denominator))
}
//7
 func(r Rational) Equal(other Rationalizer) bool{

    var LHS = r.numerator * other.Denominator()
    var RHS = other.Numerator() * r.denominator

    if LHS == RHS{
        return true
    }

  return false 

 }

//8
func(r Rational) LessThan(other Rationalizer) bool{

    r.Value = (float64(r.numerator) / float64(r.denominator))

    //if New Rational is less than Old Rational return 
    if r.Value > other.toFloat64(){
        return true 
    }
 return false  
}

//9
func(r Rational) IsInt() bool{

    //can use mod function to get remainder of float
    //candidate := math.Mod(float64(r.numerator), float64(r.denominator))
    if r.denominator != 0 {

    if r.numerator % r.denominator == 0{
        return true
    }

   }
   return false 

}
//10
func (r Rational) Add(other Rationalizer) Rationalizer{

 num := r.numerator * other.Denominator()
 den := r.denominator * other.Denominator()
 x := r.denominator * other.Numerator()
 y := x + num

r = Rational{y, den, float64(y)/float64(den)}

return r

}
//11
func (r Rational) Multiply(other Rationalizer) Rationalizer{

    var top = r.numerator * other.Numerator()
    var bottom = r.denominator * other.Denominator() 

    return Rational{top, bottom, (float64(top) / float64(bottom))}
}
//12
func (r Rational)  Divide(other Rationalizer) (Rationalizer, error){
    
    var err error
    err = nil

    var top = r.numerator * other.Denominator()
    var bottom = r.denominator * other.Numerator()

    if bottom == 0{
        return Rational{top, bottom, (float64(top) / float64(bottom))}, errors.New("You cannot have 0 in the denominator")

    }
    return Rational{top, bottom, (float64(top) / float64(bottom))}, err

}
//13
func (r Rational) Invert() (Rationalizer, error){

    var err error
    err = nil
    if r.numerator == 0{
        return Rational {r.denominator, r.numerator, (float64(r.denominator)/float64(r.numerator))}, errors.New("You cannot have zero in the denominator")

    }
    
    return Rational{r.denominator, r.numerator, (float64(r.denominator) / float64(r.numerator))}, err

}

//14
func (r Rational) ToLowestTerms() Rationalizer{
    //https://go.dev/play/p/SmzvkDjYlb greatest common divisor algorithm
    x := r.numerator
    y := r.denominator

    for y != 0 {
        t:= y
        y = x % y
        x = t
    }

    var top = r.numerator / x
    var bottom = r.denominator / x

    return Rational{top, bottom, (float64(top) / float64(bottom))}
}
//15
func (r Rational) HarmonicSum(n int)(Rationalizer){

    top := 1
    bottom := 1

    for i := 2; i<=n; i++{
        top = (top * i) + bottom
        bottom = bottom * i
    }

    return Rational {top, bottom, (float64(top) / float64(bottom))}
}




//-----------------------------------------------------P2-----------------------------------------------------------//








//linear insertion sort for for type int
func insert_sort(array [] int)[] int{
    

    for i:=0; i< len(array); i++{
    candidate:= array[i]
    j:=(i-1)


    for j >= 0 &&array[j] > candidate{
        array[j +1] = array[j]
        j = j-1
    }
    array[j+1] = candidate
}
return array

}

// linear insertion sort for for type rational
func insert_sort_rat(array [] Rational) [] Rational{
    for i:=0; i< len(array); i++{
        candidate:= array[i]
        j:=(i-1)
    
    
        for j >= 0 &&array[j].Value > candidate.toFloat64(){
            array[j +1] = array[j]
            j = j-1
        }
        array[j+1] = candidate
    }
    return array

}

//linear insertion sort for for type string
func insert_sort_string(array []string) []string{
    fir_arr := make([]int, len(array), len(array))
    var err_arr []string
    var err error
    err = nil
    for i:=0; i <len(array); i++{
        fir_arr[i], err = strconv.Atoi(array[i])
    }

    if err != nil{
        return err_arr
    }

    for i:= 0; i< len(fir_arr); i++{
        candidate:= fir_arr[i]
        num:= (i-1)

        for num >= 0 && fir_arr[num] > candidate{
        num = (num - 1)
    }

    fir_arr[num+1] = candidate
    }

    for i:= 0; i< len(array); i++{
        array[i] = strconv.Itoa(fir_arr[i])
    }
    return array
}



func make_intarray(size int) []int{

    array:= make([]int, size, size)
    for i:=0; i < size; i++{
        array[i] = rand.Intn(size + 100)
    }
    return array
}

func make_ratarray(size int) []Rational{

    array:= make([]Rational, size, size)


    for i := 0; i < size; i++{
        array[i] = Rational{rand.Intn(size + 100), rand.Intn(size + 100), float64(rand.Intn(size + 100))}
    }
    return array

}

func make_strarray(size int) []string {

    array:=make([]string, size, size)

    for i:= 0; i < size; i++{
        array[i] = strconv.Itoa(rand.Intn(size + 10500))
    }
    return array
}

func trials(size int){
    fmt.Printf("Array size %v and 10 trails\n", size)


    var past time.Duration

    for i :=0; i < 10; i++{
        intarr := make_intarray(size)
        start:=time.Now()

        insert_sort(intarr)

        past1 := time.Since(start)
        past = past + past1
    }
    past1 := (past.Microseconds()/ 10)
    fmt.Printf("Interger sorting took an average of %vµs with size %v\n", past1, size)

    //rational
    var rat_past time.Duration

    for i :=0; i < 10; i++{
        arr_rat := make_ratarray(size)
        rat_start:=time.Now()

        insert_sort_rat(arr_rat)

        rat_past1 := time.Since(rat_start)
        rat_past = rat_past + rat_past1
    }
    rat_past1 := (rat_past.Microseconds()/ 10)
    fmt.Printf("Rational sorting took an average of %vµs with size %v\n", rat_past1, size)

   // strings     
    var str_past time.Duration

    for i :=0; i < 10; i++{
        string_arr := make_strarray(size)
        str_start:=time.Now()

        insert_sort_string(string_arr)

        str_past1 := time.Since(str_start)
        str_past = str_past + str_past1
    }
    str_past1 := (str_past.Microseconds()/ 10)
    fmt.Printf("String sorting took an average of %vµs with size %v\n",str_past1, size)
    fmt.Println("\n\n")
}





func main(){

 
    r:= Rational{9, 3, 3}
    r2 := Rational{1, 1, 1}
    
    fmt.Println(makeRational(1,6))
    fmt.Println(r.Numerator())
    fmt.Println(r.Denominator())
    fmt.Println(r.Split())
    fmt.Println(r.String())
    fmt.Println(r.toFloat64())
    fmt.Println(r.Equal(r2))
    fmt.Println(r.LessThan(r2))
    fmt.Println(r.IsInt())
    fmt.Println(r.Add(r2))
    fmt.Println(r.Multiply(r2))
    fmt.Println(r.Divide(r2))
    fmt.Println(r.Invert())
    fmt.Println(r.ToLowestTerms())
    fmt.Println(r.HarmonicSum(3))

 //----------------------------------p2---------------------------//

    trials(1000)
    trials(2000)
    trials(3000)
    trials(4000)
    trials(5000)
    trials(6000)
    trials(7000)
    trials(8000)
    trials(9000)
    trials(10000)
}
