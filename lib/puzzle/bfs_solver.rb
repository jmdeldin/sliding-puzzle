require 'thread' # for Queue

# Breadth-first search solution
class Puzzle::BfsSolver
  attr_reader :steps, :moves

  def initialize(problem)
    @problem = problem
    @steps   = 0
    @moves   = []
  end

  def solve
    marked   = Hash.new(false)
    frontier = Queue.new

    frontier.enq(@problem)
    marked[@problem.board.join] = true

    until frontier.empty?
      prob = frontier.deq

      return prob if prob.solved?

      prob.actions.each do |action|
        new_prob = prob.clone
        new_prob.move(action)
        key = new_prob.board.join

        if !marked[key]
          marked[key] = true
          frontier.enq new_prob
        end
      end
    end

  end
end
