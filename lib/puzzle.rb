$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))
unless Kernel.respond_to?(:require_relative)
  module Kernel
    def require_relative(path)
      require File.join(File.dirname(caller[0]), path.to_str)
    end
  end
end

module Puzzle
  [:Reader, :Node, :Solver, :Problem].each do |m|
    autoload m, "puzzle/#{m.to_s.downcase}"
  end
  autoload :PrioritySolver, 'puzzle/priority_solver'
  autoload :AstarSolver, 'puzzle/astar_solver'
  autoload :BfsSolver, 'puzzle/bfs_solver'
  autoload :DfsSolver, 'puzzle/dfs_solver'
  autoload :UcsSolver, 'puzzle/ucs_solver'
  autoload :GreedySolver, 'puzzle/greedy_solver'

end
