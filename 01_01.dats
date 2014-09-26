

#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

extern castfn i2sz {n: int} (x: int n): size_t n
extern castfn c2i (c: char): [i: nat | i <= 255] int i
extern castfn s02s (s: string): [n: nat] string n

/*
 * string type has length information
 *
 */
fun is_unique_char2 {n: nat} (str: string n): bool = let
  // rec of type arrszref has length information
  val record = arrszref_make_elt<bool> (i2sz(256), false)
  val n = string_length (str)

  fun loop {n, i: nat | i < n} (
    str: string n, 
    n: size_t n, 
    record: arrszref (bool), 
    i: size_t i): bool = let
    // val c = string_get_at_size(str, i)
    val c = str[i]
    val loc = c2i (c)
    val b = record[loc]
  in
    if b then ~b else let
      val () = record[loc] := true
    in
      if i + 1 = n then true
      else loop (str, n, record, i + 1)
    end
  end
in
  if (n = 0) then true
  else loop (str, n, record, i2sz(0))
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
  val b = is_unique_char2 (str)
  val () = if b then println! (str0, " is unique.")
           else println! (str0, " is not unique.")
in
  0
end

