defmodule My do
	defmacro macro(param) do
		IO.inspect param
	end
end

defmodule Test do
	require My

	# これらの値がそのまま表現となる
	My.macro :atom			#=> :atom
	My.macro 1				#=> 1
	My.macro 1.0			#=> 1.0
	My.macro [1, 2, 3]		#=> [1, 2, 3]
	My.macro "binaries"		#=> "binaries"
	My.macro { 1, 2 }		#=> { 1, 2 }
	My.macro do: 1			#=> [do: 1]

	# そしてこれらは三つ組のタプルで表現される
	My.macro { 1, 2, 3, 4, 5 }
	# => {:"{}", [line: 20], [1,2,3,4,5]}

	My.macro do: ( a = 1; a + a)
	# => [do:
	#     {:__block__, [],
	#       [{:=, [line: 23], [{:a, [line: 23], nil}, 1]},
	#        {:+, [line: 23], [{:a, [line: 23], nil}, {:a, [line: 23], nil}]}]}]

	My.macro do
		1+2
	else
		3+4
	end
	# => [do: {:+, [line: 30], [1, 2]},
	#     else: {:+, [line: 32], [3, 4]}] 
end