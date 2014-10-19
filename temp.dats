

fun foo
  {i: int}
  {j: int}
  ( i: int i
  , j: int j
  ): void = let
  val i = i - 3
  val j = j - 1
in
  if ((i = j) || (j < 0)) then ()
  else let
    prval () = (): [i - 3 <> j - 1] void
  in
  end
end

