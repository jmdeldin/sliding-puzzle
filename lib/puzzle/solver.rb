require_relative '../puzzle'
require_relative 'node'
require 'algorithms'

class Puzzle::Solver
  attr_reader :counts, :solution

  def initialize(problem, frontier)
    @frontier = frontier
    @counts = 0
    @solution = nil
    @problem = problem
    run
    compute_path
  end

  def run
    g = Puzzle::Node.new(@problem)
    @frontier.push g
    marked = {g.board => true}

    until @frontier.empty?
      ng = @frontier.pop

      return @solution = ng if ng.problem.solved?
      @counts += 1
      progress_report

      # for every action, create some separate graphs
      ng.problem.actions.each do |action|
        new_problem = ng.problem.clone
        new_problem.move(action)
        new_graph = Puzzle::Node.new(new_problem, ng)
        new_graph.move = action

        if !marked[new_graph.board]
          marked[new_graph.board] = true
          @frontier.push new_graph
        end
      end
    end
  end

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
    @nodes.reject { |n| n.move.nil? }.map { |n| n.move.upcase[0] }.join(" => ")
  end

  def steps
    puts "Number of steps: #{num_steps}"
  end

  def steps_moves
    steps
    puts "Moves: #{moves}"
  end

  def steps_moves_seq
    steps_moves
    puts "History from unsolved to solved:"
    puts boards
  end

  def boards
    @nodes.map { |n| n.problem.print_board }.join("\n")
  end

  def progress_report
    if @counts > 1000 && @counts % 1000 == 0
      puts "Still working -- expanded #{@counts} nodes so far..."
    end
  end
end
