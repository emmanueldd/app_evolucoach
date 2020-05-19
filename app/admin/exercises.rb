ActiveAdmin.register Exercise do
  permit_params Exercise.attribute_names.map{|n| n.to_sym}
end
