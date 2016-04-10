class Triangle < ActiveRecord::Base
  default_scope -> { order(triangle_type: 'DESC') }
  enum triangle_type: [:scaline, :isosceles, :equilateral]

  after_create :evaluate_triangle

  validates :side_a, :side_b, :side_c, presence: true, numericality: {:only_integer => true}

  def self.available_params
    [
      :side_a,
      :side_b,
      :side_c
    ]
  end

  def evaluate_triangle
    if side_a == side_b && side_b == side_c && side_c == side_a
      equilateral!
    elsif identical_side_a_and_b? || identical_side_b_and_c? || identical_side_a_and_c?
      isosceles!
    else
      scaline!
    end
  end


  private

  def identical_side_a_and_b?
    (side_a == side_b && side_b != side_c && side_a != side_c)
  end

  def identical_side_b_and_c?
    (side_b == side_c && side_c != side_a && side_a != side_b)
  end

  def identical_side_a_and_c?
    (side_a == side_c && side_a != side_b && side_c != side_b)
  end
end
