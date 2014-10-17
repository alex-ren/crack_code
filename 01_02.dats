
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

staload _ = "prelude/DATS/strptr.dats"
staload _ = "prelude/DATS/string.dats"

staload "prelude/SATS/unsafe.sats"



/* ************* ************** */

datasort clist = 

abstype mystring (xs: clist, n: int) = ptr



absprop reverse (clist, clist)

extern prfun is_reverse {xs, ys: clist} (): reverse (xs, ys)

/* ************* ************** */

fun reverse {n: nat} {xs: clist}  (
  str: mystring (xs, n)): 
  [ys: clist] (reverse (xs, ys) | mystring (ys, n)) = let

  fun reverse0 {i, n: nat | i <= (n/2)} {l:addr} (
    str: strnptr (l, n), n: int n, i: int i): string n =
  if (i = ndiv (n, 2)) then castvwtp0{string (n)}(str)
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
  
  val str = cast{string n}(str)
  val nptr = castvwtp0{[l:addr] strnptr(l, n)}(str)

  val n = strnptr_length (nptr)
  val n = cast{int n} n

  val str = reverse0 (nptr, n, 0)
  val str = cast{mystring (xs, n)} (str)
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
  val str = cast{[n: int] string n} (str0)
  val () = print! ("Reverse of ", str, " is ")
  val mystr = cast{[xs: clist][n:nat] mystring (xs, n)} (str)
  val (_ | myrstr) = reverse (mystr)
  val rstr = cast{string} (myrstr)

  val () = println! (rstr)
in
  0
end


