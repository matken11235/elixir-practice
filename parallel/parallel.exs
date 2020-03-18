defmodule Functions do
	def random(ary) do
		Enum.map(ary, fn(_) -> :rand.uniform(1000) end)
	end

	def sleep(time) do
		IO.puts("#{time}ms started.")
		:timer.sleep(time)
		IO.puts("#{time}ms stopped.")
		IO.puts("")
	end
end

defmodule Parallel do
	def start(ary) do
		Functions.random(ary)
		|> Enum.map( &(Task.async(Functions, :sleep, [&1])) ) # __MODULE__は自身のモジュール名(今回であれば，Parallel)
		|> Enum.map(&(Task.await/1))
	end
end

defmodule Serial do
	def start(ary) do
		Functions.random(ary)
		|> Enum.map(&(Functions.sleep(&1)))
	end
end