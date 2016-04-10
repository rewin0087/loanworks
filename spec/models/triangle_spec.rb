require 'rails_helper'

RSpec.describe Triangle, :type => :model do
  context 'constants' do
    it { expect(Triangle.triangle_types).to eql({ "scaline" => 0, "isosceles" => 1, "equilateral" => 2 }) }
    it { expect(Triangle.triangle_types[:scaline]).to eql(0) }
    it { expect(Triangle.triangle_types[:isosceles]).to eql(1) }
    it { expect(Triangle.triangle_types[:equilateral]).to eql(2) }
  end

  context 'validations' do
    it { should validate_presence_of(:side_a) }
    it { should validate_presence_of(:side_b) }
    it { should validate_presence_of(:side_c) }
    it { should validate_numericality_of(:side_a) }
    it { should validate_numericality_of(:side_b) }
    it { should validate_numericality_of(:side_c) }
  end

  context 'class_methods' do
    context '.available_params' do
      it { expect(Triangle.available_params).to eql([:side_a, :side_b, :side_c]) }
    end
  end
end
