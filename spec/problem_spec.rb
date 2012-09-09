require 'spec_helper'
load_class :problem

describe Puzzle::Problem do
  let(:opts) do
    {
      :board     => [ [3, 2, 1], [4, 5, 6], [7, 8, 0] ],
      :algorithm => :bfs,
      :heuristic => :h1,
      :verbosity => :steps,
    }
  end
  let(:goal) { [ [1, 2, 3], [4, 5, 6], [7, 8, 0] ] }
  subject { described_class.new(opts) }

  its(:m) { should == 3 }
  its(:n) { should == 3 }
  its(:goal_state) { should == goal }

  describe '#solved?' do
    context 'with a board in the goal state' do
      subject { described_class.new(opts.merge(:board => goal)) }
      its(:solved?) { should be_true }
    end

    context 'with a board not in the goal state' do
      its(:solved?) { should be_false }
    end
  end

  describe '#actions' do
    subject { described_class.new(:board => board) }
    context 'when the blank is in the top row' do
      let(:board) { [[1,0], [3, 2]] }
      its(:actions) { should_not include :up }
      its(:actions) { should include :down }
    end

    context 'when the blank is in the bottom row' do
      let(:board) { [[1,2], [3, 0]] }
      its(:actions) { should_not include :down }
      its(:actions) { should include :up }
    end

    context 'when the blank is in the left column' do
      let(:board) { [[0, 1], [2, 3]] }
      its(:actions) { should_not include :left }
      its(:actions) { should include :right }
    end

    context 'when the blank is in the right column' do
      let(:board) { [[1, 0], [2, 3]] }
      its(:actions) { should_not include :right }
      its(:actions) { should include :left }
    end
  end

  describe 'moving' do
    subject(:problem) { described_class.new(:board => board) }
    context 'with the blank in the bottom-left corner' do
      let(:board) { [[1, 2], [0, 3]] }
      it 'can move to the right' do
        problem.move(:right)
        problem.board.should == [[1, 2], [3, 0]]
      end

      it 'can move up' do
        problem.move(:up)
        problem.board.should == [[0, 2], [1, 3]]
      end

      it 'raises an error if you try to move it left' do
        expect(lambda { problem.move(:left) }).to raise_error
      end

      it 'raises an error if you try to move it down' do
        expect(lambda { problem.move(:down) }).to raise_error
      end
    end

    context 'with the blank in the top-right corner' do
      let(:board) { [[1, 0], [3, 2]] }
      it 'can move to the left' do
        problem.move(:left)
        problem.board.should == [[0, 1], [3, 2]]
      end

      it 'can move down' do
        problem.move(:down)
        problem.board.should == [[1, 2], [3, 0]]
      end

      it 'raises an error if you try to move it right' do
        expect(lambda { problem.move(:right) }).to raise_error
      end

      it 'raises an error if you try to move it up' do
        expect(lambda { problem.move(:up) }).to raise_error
      end
    end
  end

  describe '#path_cost' do
    subject(:problem) { described_class.new(:board => [[3, 1], [2, 0]]) }
    it 'is incremented every time a move is made' do
      problem.move(:up)
      problem.path_cost.should == 1
      problem.move(:left)
      problem.path_cost.should == 2
    end
  end

  describe '#print_board' do
    subject(:problem) { described_class.new(:board => [[3, 1], [2, 0]]) }
    it 'prints the board with spaces' do
      problem.print_board.should == " 3  1 \n 2  0 \n"
    end
  end
end
