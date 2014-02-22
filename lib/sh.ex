defmodule Sh do
  defexception CommandNotFound, command: nil do
    def message(__MODULE__[command: command]) do
      "Command not found: #{command}"
    end
  end

  defexception AbnormalExit, output: nil, status: nil do
    def message(__MODULE__[status: status]) do
      "exited with non-zero status (#{status})"
    end
  end

  def unquote(:"$handle_undefined_function")(program, args) do
    command = to_string(program)
      |> String.replace("_", "-")
      |> System.find_executable
      || raise CommandNotFound, command: program

    if is_list(List.last(args)) do
      { args, [opts] } = Enum.split(args, -1)
      args = process_options(opts) ++ args
    end

    # http://www.erlang.org/doc/man/erlang.html#open_port-2
    opts = ~w(exit_status stderr_to_stdout in binary eof hide)a ++ [args: args]
    port = Port.open({ :spawn_executable, command }, opts)

    loop(port, "")
  end

  defp loop(port, acc) do
    receive do
      { ^port, { :data, data } } ->
        loop(port, acc <> data)
      { ^port, :eof } ->
        send port, { self, :close }
        receive do
          { ^port, { :exit_status, 0 } } ->
            acc
          { ^port, { :exit_status, status } } ->
            raise AbnormalExit[output: acc, status: status]
        end
    end
  end

  defp process_options(opts) do
    Enum.reduce Enum.reverse(opts), [], fn { key, value }, acc ->
      key = to_string(key)
      if String.length(key) == 1 do
        if value do
          ["-#{key}", to_string(value) | acc]
        else
          acc
        end
      else
        key = String.replace(key, "_", "-")
        if value do
          if value != true do
            ["--#{key}=#{value}" | acc]
          else
            ["--#{key}" | acc]
          end
        else
          acc
        end
      end
    end
  end
end
