require 'spec_helper'
require 'stringio'
load_class :reader

describe Puzzle::Reader do
  context '#initialize' do
    let(:board) { StringIO.new "5\n1\n1\n7 3 8\n0 2 4\n6 5 1" }

    subject(:reader) do
      described_class.new(board)
    end

    it 'sets the correct algorithm' do
      reader.algorithm.should == :astar
    end

    it 'sets the correct heuristic' do
      reader.heuristic.should == :h1
    end

    it 'sets the correct verbosity' do
      reader.verbosity.should == :steps_moves
    end

    it 'sets the correct tiles' do
      exp = [ [7, 3, 8], [0, 2, 4], [6, 5, 1] ]
      reader.tiles.should == exp
    end

  end

  context '#algorithm' do
    {
      1 => :dfs,
      2 => :bfs,
      3 => :ucs,
      4 => :gbfs,
      5 => :astar,
    }.each do |code, algo|
      context "given a code of #{code}" do
        subject(:reader) { described_class.new(StringIO.new(code.to_s)) }
        its(:algorithm) { should == algo }
      end
    end
  end

  context '#heuristic' do
    { 1 => :h1, 2 => :h2 }.each do |code, heur|
      context "given a code of #{code}" do
        subject { described_class.new(StringIO.new("1\n#{code}")) }
        its(:heuristic) { should == heur }
      end
    end
  end

  context '#verbosity' do
    { 0 => :steps, 1 => :steps_moves, 2 => :steps_moves_seq }.each do |c, verb|
      context "given a code of #{c}" do
        subject { described_class.new(StringIO.new("1\n1\n#{c}")) }
        its(:verbosity) { should == verb }
      end
    end
  end
end
