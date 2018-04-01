class Gw2::Minipet
  include Mongoid::Document
  
  field :gw2_minipet, type: Hash
  
  validate :gw2_id_present

  private
  
  def gw2_id_present
    errors.add(:gw2_minipet, 'is duplicated') if Gw2::Minipet.where("gw2_minipet.id": self.gw2_minipet["id"]).count != 0
  end
end
