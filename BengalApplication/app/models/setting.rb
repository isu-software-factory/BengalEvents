class Setting < ApplicationRecord
  has_one_attached :logo

  def reset_default
    if self.update(primary_color: "#6d6e71", secondary_color: "#f47920", additional_color: "#f69240", font: "Arial", site_name: "Bengal Stem Day")
      true
    else
      false
    end
  end

  def reset_default_logo
    self.logo.attach(io: File.open("app/assets/images/LogoWide-ScienceEngineeringWhite.png"), filename: "LogoWide-ScienceEngineeringWhite.png")
  end
end
