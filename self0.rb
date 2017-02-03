class Interpreter
  def initialize(ram)
    @ram = Array.new(256) { rand(256) }
    ram.split(" ").map(&:to_i).each_with_index do |it, index|
      @ram[index] = it
    end
  end

  def run
    while true
      @pc = @ram[0]
      case @ram[@pc]
      when 0 then exit(0)
      when 1 then print
      when 2 then operation(:+)
      when 3 then operation(:-)
      when 4 then jmp
      when 5 then jnz
      else
        raise NotImplementedError.new("Opcode: #{@ram[@pc]}")
      end
    end
  end

  def print
    puts "#{@ram[@pc+1]}"
    advance_pc(2)
  end

  def operation(sign)
    target = @ram[@pc+1]
    @ram[target] = @ram[target].send(sign, 1)
    @ram[target] = @ram[target] % 256
    advance_pc(2)
  end

  def jmp
    @ram[0] = @ram[@pc+1]
  end

  def jnz
    if @ram[@ram[@pc+2]] == 0
      advance_pc(3)
    else
      @ram[0] = @ram[@pc+1]
    end
  end

  def advance_pc(n)
    @ram[0] += n
    @ram[0] = 0 if @ram[0] > 255
  end
end

Interpreter.new(ARGV[0]).run
