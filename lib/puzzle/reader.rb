# Reads and parses a puzzle file.
#
class Puzzle::Reader
  attr_reader :board

  # handle -- IO object (we don't mandate a file handle so testing is easier)
  def initialize(handle)
    @algo_code, @heuristic_code, @verbosity_code, @board = parse(handle)
  end

  def algorithm
    @algorithm ||= {
      1 => :dfs,
      2 => :bfs,
      3 => :ucs,
      4 => :gbfs,
      5 => :astar,
    }[@algo_code]
  end

  def heuristic
    @heuristic_code == 1 ? :h1 : :h2
  end

  def verbosity
    @verbosity ||= {
      0 => :steps,
      1 => :steps_moves,
      2 => :steps_moves_seq,
    }[@verbosity_code]
  end

  private

  def parse(handle)
    algo, heuristic, verbosity = 0
    board = []
    i = 0

    handle.each_line do |line|
      next if line.strip! == ''

      if i == 0
        algo = Integer(line)
      elsif i == 1
        heuristic = Integer(line)
      elsif i == 2
        verbosity = Integer(line)
      else
        board << line.split(/\s/).map { |x| Integer(x) }
      end

      i += 1
    end

    [algo, heuristic, verbosity, board]
  end
end
