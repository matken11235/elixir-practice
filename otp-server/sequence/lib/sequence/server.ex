defmodule Sequence.Server do
	use GenServer

	#####
	# 外部API
	def start_link(current_number) do
		GenServer.start_link(__MODULE__, current_number, name: __MODULE__)
	end
	def next_number do
		GenServer.call __MODULE__, :next_number
	end
	def increment_number(delta) do
		GenServer.cast __MODULE__, {:increment_number, delta}
	end

	#####
	# GenServerの実装
	def handle_call(:next_number, _from, current_number) do
		{ :reply, current_number, current_number + 1 }
	end
	def handle_cast({:increment_number, delta}, current_number) do
		{ :noreply, current_number + delta }
	end
	def format_status(_reason, [ _pdict, state ]) do
		[data: [{ 'State', "My current state is '#{inspect state}', and I'm happy"}]]
	end
end

# Usage
## > { :ok, pid } = GenServer.start_link(Sequence.Server, 100)
## {:ok, #PID<0.0.0>}
## > GenServer.call(pid, :next_number)
## 100
## > GenServer.call(pid, :next_number)
## 101
## > GenServer.cast(pid, {:increment_number, 200})
## :ok
## > GenServer.call(pid, :next_number)
## 302

# debug options
## > { :ok, pid } = GenServer.start_link(Sequence.Server, 100, [debug: [:trace]])
## > { :ok, pid } = GenServer.start_link(Sequence.Server, 100, [debug: [:statistics]])
## > GenServer.call(pid, :next_number)
## > GenServer.call(pid, :next_number)
## > :sys.statistics pid, :get
# erlangのモジュールは，:osのようにタプルの小文字で指定される．
# 以下の文で，traceを有効にできる．
### * :sys.trace pid, true