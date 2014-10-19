
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

fun replaceSpaces
  {n: pos} 
  ( arr: arrayref (char, n)
  ): void = let
    fun string_length 
      {n: pos} {i: nat | i < n}
      ( arr: arrayref (char, n)
      , i: int i
      ): [m: nat | m < n] int m = let
      val c = arr[i]
    in
      if c = '\0' then i
      else let
        // asserting, the last character in array has to be '\0'
        extern prfun assertn {i, n: int} (): [n > i + 1] void
        prval () = assertn {i, n} ()
      in
        string_length (arr, i + 1)
      end
    end

    fun loop
      {n: pos} {k: pos}
      {is, id: nat | (id == 2 * k + is)  && id < n}
      ( arr: arrayref (char, n)
      , is: int is
      , id: int id
      ): void = let
      val c = arr[is]
    in
      if c = ' ' then let
        val () = arr[id] := '0'
        val () = arr[id - 1] := '2'
        val () = arr[id - 2] := '%'
        val id = id - 3
        val is = is - 1
      in
        if (is = id || is < 0) then ()
        else let
          prval () = (): [(is -1 != id - 3)] void
        in
          loop {n}{k-1}{is-1, id-3} (arr, is, id)
        end
      end else let
        val () = arr[id] := arr[is]
        val id = id - 1
        val is = is - 1
      in
        if is = id then ()
        else loop (arr, is, id)
      end
    end

  in
  end
      
