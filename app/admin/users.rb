ActiveAdmin.register User do
  permit_params User.attribute_names.map{|n| n.to_sym}
end
