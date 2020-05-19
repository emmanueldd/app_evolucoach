ActiveAdmin.register ExerciseCategory do
  permit_params ExerciseCategory.attribute_names.map{|n| n.to_sym}
end
