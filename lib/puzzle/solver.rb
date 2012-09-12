class Puzzle::Solver
  def compute_path
    @nodes = []
    @path_length = -1 # skip the root

    cur = @solution
    while cur
      @nodes.unshift cur # prepend
      @path_length += 1
      cur = cur.parent
    end
  end

  def num_steps
    @path_length
  end

  def moves
    @nodes.reject { |n| n.move.nil? }.map { |n| n.move.upcase[0] }.join(", ")
  end

  def boards
    @nodes.map { |n| n.problem.print_board }.join("\n")
  end
end
