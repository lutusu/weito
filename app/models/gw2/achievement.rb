class Gw2::Achievement
  include Mongoid::Document
  field :gw2_achievement, type: Hash
  validate :gw2_id_present

  private
  
  def gw2_id_present
    errors.add(:gw2_achievement_id, 'is duplicated') if Gw2::Achievement.where("gw2_achievement.id": self.gw2_achievement["id"]).count != 0
  end
end
