class Gw2::Skin
  include Mongoid::Document
  
  field :gw2_skin, type: Hash
  
  validate :gw2_id_present

  private
  
  def gw2_id_present
    errors.add(:gw2_skin, 'is duplicated') if Gw2::Skin.where("gw2_skin.id": self.gw2_skin["id"]).count != 0
  end
end
