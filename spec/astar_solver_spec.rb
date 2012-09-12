require_relative 'spec_helper'
load_class :problem
load_class :astar_solver

describe Puzzle::AstarSolver do
  let(:problem) { Puzzle::Problem.new(:board => board) }
  subject(:solver) { described_class.new(problem, :h1) }

  context 'when given a solved puzzle' do
    let(:board) { [[1, 2], [3, 0]] }
    specify { solver.num_steps.should == 0}
    specify { solver.moves.should be_empty }
    specify { solver.boards.should == problem.print_board }
  end

  context 'when given a puzzle with only one move to make' do
    # 1 2
    # 0 3 (shift 0 right)
    let(:board) { [[1, 2], [0, 3]] }

    it 'returns a path cost of 1' do
      solver.num_steps.should == 1
    end

    it 'returns a sequence of moves' do
      solver.moves.should == "R"
    end
  end

  context 'when given a puzzle with four moves to make' do
    # 3 1
    # 2 0
    let(:board) { [[3, 1], [2, 0]] }
    it 'returns a path cost of 4' do
      solver.num_steps.should == 4
    end
  end
end
