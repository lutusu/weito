class Gw2::Mastery
  include Mongoid::Document
  
  field :gw2_mastery, type: Hash
  
  validate :gw2_id_present

  private
  
  def gw2_id_present
    errors.add(:gw2_mastery, 'is duplicated') if Gw2::Mastery.where("gw2_mastery.id": self.gw2_mastery["id"]).count != 0
  end
end
