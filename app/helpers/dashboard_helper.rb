module DashboardHelper
  # Splits "95014, Cupertino, Santa Clara County, California, United States"
  # into a headline ("Cupertino") and the rest of the address.
  def place_parts(location)
    parts = location.name.to_s.split(", ") - [ location.postal_code ]
    [ parts.first, parts.drop(1).join(", ") ]
  end
end
