ActiveAdmin.register Order do
  permit_params Order.attribute_names.map{|n| n.to_sym}
end
