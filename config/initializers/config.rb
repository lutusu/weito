module WeitoConfig
  @config = YAML.load_file(Rails.root.join("config",'config.yml')).symbolize_keys!
  def self.config
    @config
  end
end
module WeitoResource
  @resources = YAML.load_file(Rails.root.join("config",'resource.yml')).symbolize_keys!

  def self.resources
    @resources
  end
end