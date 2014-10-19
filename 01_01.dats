

#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

staload "prelude/SATS/unsafe.sats"

staload _ = "prelude/DATS/arrayref.dats"

/*
 * string type has length information
 *
 */
fun is_unique_char2 {n: nat} (str: string n): bool = let
  // rec of type arrszref has length information
  val record = arrszref_make_elt<bool> (cast{size_t}(256), false)
  val n = string_length (str)

  fun loop {n, i: nat | i < n} (
    str: string n, 
    n: size_t n, 
    record: arrszref (bool), 
    i: size_t i): bool = let
    // val c = string_get_at_size(str, i)
    val c = str[i]
    val loc = cast{int} (c)
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
  else if (n > 256) then false
  else loop (str, n, record, cast{size_t 0}(0))
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
  val str = cast{[n:nat] string n}(str0)
  val b = is_unique_char2 (str)
  val () = if b then println! (str0, " is unique.")
           else println! (str0, " is not unique.")
in
  0
end

