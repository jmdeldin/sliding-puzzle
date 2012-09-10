require_relative 'spec_helper'
load_class :problem
load_class :bfs_solver

describe Puzzle::BfsSolver do
  let(:problem) { Puzzle::Problem.new(:board => board) }
  subject(:solver) { described_class.new(problem) }

  context 'when given a solved puzzle' do
    let(:board) { [[1, 2], [3, 0]] }
    its(:steps) { should == 0 }
    its(:moves) { should be_empty }
  end

  context 'when given a puzzle with only one move to make' do
    # 1 2
    # 0 3 (shift 0 right)
    let(:board) { [[1, 2], [0, 3]] }
    it 'returns a path cost of 1' do
      winner = solver.solve
      winner.path_cost.should == 1
    end
  end

  context 'when given a puzzle with four moves to make' do
    # 3 1
    # 2 0
    let(:board) { [[3, 1], [2, 0]] }
    it 'returns a path cost of 4' do
      winner = solver.solve
      winner.path_cost.should == 4
    end
  end
end
