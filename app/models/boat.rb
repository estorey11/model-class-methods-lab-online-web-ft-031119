class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    first_five=[]
    self.all.each_with_index do |boat, i|
      if i<5
        first_five << boat
      end
    end
    first_five
  end

  def self.dinghy
    where("length < 20")
  end

  def self.ship
    where("length >= 20")
  end

  def self.last_three_alphabetically
    all.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    includes(:classifications).where(classifications: { name: 'Sailboat' })
  end

  def self.with_three_classifications
    three_class=[]
    self.all.each do |boat|
      three_class << boat if boat.classifications.size==3
    end
    three_class
  end

end
