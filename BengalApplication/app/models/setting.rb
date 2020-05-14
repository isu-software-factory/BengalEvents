class Setting < ApplicationRecord

  def reset_default
    if self.update(primary_color: "#0000", secondary_color: "#0000", site_name: "Bengal Stem Day")
      true
    else
      false
    end
  end
end
