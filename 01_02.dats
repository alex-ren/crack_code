
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

staload _ = "prelude/DATS/strptr.dats"
staload _ = "prelude/DATS/string.dats"

extern castfn string2strnptr {n:nat} (str: string n): [l:addr] strnptr (l, n)

extern castfn ssz2int {n:int} (x: ssize_t n): int (n)

extern castfn s02s (s: string): [n: nat] string n


/* ************* ************** */

datasort clist =

abstype mystring (xs: clist, n: int)

extern castfn mystring2string {xs:clist}{n:int} (
  str: mystring (xs, n)): string n

extern castfn string2mystring {xs:clist}{n:int} (
  str: string (n)): mystring (xs, n)

absprop reverse (clist, clist)

extern prfun is_reverse {xs, ys: clist} (): reverse (xs, ys)

/* ************* ************** */

fun reverse {n: nat} {xs: clist}  (
  str: mystring (xs, n)): 
  [ys: clist] (reverse (xs, ys) | mystring (ys, n)) = let

  fun reverse0 {i, n: nat | i <= (n/2)} {l:addr} (
    str: strnptr (l, n), n: int n, i: int i): string n =
  if (i = half n) then strnptr2string (str)
  else let
    val () = (): [i < (n/2)] void
    val () = (): [n <> 0] void
    val () = (): [i <= n] void
    val c = str[i]
    val loc = n - 1 - i
    val d = str[loc]
    val () = str[i] := d
    val () = str[loc] := c
  in
    reverse0 (str, n, i + 1)
  end
  
  val str = mystring2string (str)
  val nptr = string2strnptr (str)

  val n =  strnptr_length (nptr)
  val n = ssz2int n

  val str = reverse0 (nptr, n, 0)
  val str = string2mystring (str)
  prval pf = is_reverse ()
in
  (pf | str)
end

/*
 *
 * fun main {n:int|n>0} (
 *   argc: int n, argv: &(@[string][n])): void
 *
 */
implement main (argc, argv) =
if argc < 2 then 0
else let
  val str0 = argv[1]
  val str = s02s (str0)
  val mystr = string2mystring (str)
  val (_ | myrstr) = reverse (mystr)
  val rstr = mystring2string (myrstr)

  val () = println! ("Reverse of ", str, " is ", "rstr")
in
  0
end


