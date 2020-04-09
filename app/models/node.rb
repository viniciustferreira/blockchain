class Node < ApplicationRecord
  def address
    "http://#{url}:#{port}"
  end

  def to_s
    "#{id}:#{address}"
  end

end