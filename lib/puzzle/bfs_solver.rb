require_relative '../puzzle'
require_relative 'solver'
require_relative 'node'
require 'thread' # for Queue

# Breadth-first search solution
class Puzzle::BfsSolver < Puzzle::Solver
  def initialize(problem)
    @solution = nil
    run(problem)
    compute_path
  end

  def run(problem)
    g = Puzzle::Node.new(problem)
    frontier = Queue.new
    frontier.enq g
    marked = {g.board => true}

    until frontier.empty?
      ng = frontier.deq

      return @solution = ng if ng.problem.solved?

      # for every action, create some separate graphs
      ng.problem.actions.each do |action|
        new_problem = ng.problem.clone
        new_problem.move(action)
        new_graph = Puzzle::Node.new(new_problem, ng)
        new_graph.move = action

        if !marked[new_graph.board]
          marked[new_graph.board] = true
          frontier.enq new_graph
        end
      end
    end
  end
end

if $0 == __FILE__
  require_relative 'problem'
  board =[
    [7, 3, 8],
    [0, 2, 4],
    [6, 5, 1]
  ]
  board2 = [[1, 2], [0, 3]]
  prob = Puzzle::Problem.new(:board => board2)
  bfs = Puzzle::BfsSolver.new(prob)

  puts bfs.num_steps
  puts bfs.moves
  puts bfs.boards
end
