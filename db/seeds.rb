['Pectoraux', 'Triceps', 'Dos', 'Biceps', 'Épaules', 'Dos', 'Jambes', 'Abdos', 'Autres'].each do |name|
  ExerciseCategory.create(name:  name)
end

 ["Pompes", "Pompes avec élastique", "Pompes au TRX", "Pompes serrées", "Pompes serrées avec élastique", "Pompes sur genoux", "Pompes sur genoux serrées", "Pompes inclinées (pieds en hauteur)", "Pompes inclinées (pieds en hauteur)  avec élastique", "Pompes inclinées (pieds en hauteur) au TRX", "Pompes inclinées serrées", "Pompes inclinées serrées avec élastique", "Pompes sur barre guidée", "Pompes sur barre guidée serrées","Dips larges", "Dips", "Dips larges lestés", "Dips lestés", "Dips larges machine assistée", "Dips machine assistée", "Dips assis machine", "Dips au bord d’un banc", "Dips entre 2 bancs","Développé assis incliné", "Développé assis", "Développé assis décliné", "Développé assis unilatéral de ¾","Développé couché incliné (barre libre, barre guidée)", "Développé couché (barre libre, barre guidée)", "Développé couché décliné (barre libre, barre guidée)","Développé incliné haltères", "Développé couché haltères", "Développé décliné haltères","Ecartés inclinés haltères", "Ecartés couchés haltères", "Ecartés déclinés haltères","Butterfly (coudes)", "Butterfly (mains)","Ecartés couchés inclinés poulies", "Ecartés couchés poulies", "Ecartés couchés déclinés poulies", "Ecartés poulies hautes", "Ecartés poulies mi-hauteur", "Ecartés poulies basses","Pullover", "Pullover 2 haltères collés", "Pullover en travers d’un banc", "Pullover en travers d’un banc 2 haltères collés", "Pullover sur banc décliné",
"Pullover sur banc décliné 2 haltères collés","Développé militaire assis serré (barre / haltères / disque)", "Développé incliné serré (barre / haltères / disque)", "Développé couché serré (barre / haltères / disque)", "Développé décliné serré (barre / haltères / disque)",
"Elévations frontales serré (haltères / disque)"].each do |name|
  ec_id = ExerciseCategory.find_by(name: 'Pectoraux').id
  Exercise.create(name: name, exercise_category_id: ec_id)
end

 ["Pompes serrées", "Pompes serrées sur barre guidée","Dips", "Dips lestés", "Dips sur un banc", "Dips machine","Développé couché prise serrée barre", "Développé couché prise serrée haltères","Barre au front (pronation / supination / marteau)",
"Barre au front derrière la tête (pronation / supination / marteau)","Extensions triceps assis (haltères / disque)", "Extensions triceps assis unilatéral (haltère / poulie / élastique)", "Extensions triceps assis à la poulie basse", "Extensions triceps au TRX","Kick back triceps haltère", "Kick back triceps poulie","Extensions triceps poulie haute à la corde", "Extensions triceps poulie haute à la corde derrière la tête", "Extensions triceps poulie haute en pronation", "Extensions triceps poulie haute en supination", "Extensions triceps poulie haute en supination unilatéral","Gainage + extensions de bras alternées",
"Gainage + extensions de bras (2 bras en même temps)"].each do |name|
  ec_id = ExerciseCategory.find_by(name: 'Triceps').id
  Exercise.create(name: name, exercise_category_id: ec_id)
end

 ["Superman bras tendus", "Superman unilatéral", "Superman bras fléchis","Tractions allongées sous une barre guidée", "Tractions prise large en pronation", "Tractions prise serrée en supination", "Tractions prise large marteau", "Tractions prise serrée marteau", "Tractions machine assistée (pronation, supination, marteau)", "Tractions avec élastique (pronation, supination, marteau)",
"Tractions au TRX (pronation, supination, marteau, rotation, unilatéral)","Tirage poitrine prise large en pronation", "Tirage poitrine prise serrée en supination", "Tirage poitrine prise large marteau", "Tirage poitrine prise serrée marteau", "Tirage vertical unilatéral poulie","Tirage vertical semi - guidé", "Tirage vertical semi - guidé unilatéral", "Tirage vertical machine guidée (face / dos)","Pullover debout barre", "Pullover debout corde","Tirage horizontal prise large en pronation", "Tirage horizontal prise large marteau", "Tirage horizontal prise serrée marteau", "Tirage horizontal unilatéral","Rowing assis serré (droit / incliné)", "Rowing assis serré unilatéral (droit / incliné)", "Rowing assis large (droit / incliné)", "Rowing assis large unilatéral (droit / incliné)","Bûcheron (rowing haltère coude serré)", "Rowing haltère coude écarté","Rowing barre buste penché en pronation", "Rowing barre buste penché en supination",
"Rowing haltères buste penché (marteau / pronation / supination)","Rowing à plat ventre sur un banc - prise large marteau", "Rowing à plat ventre sur un banc - en pronation", "Rowing à plat ventre sur un banc - en supination", "Rowing à plat ventre sur un banc - haltères","Soulevé de terre", "Good morning",
"Lombaires au pupitre"].each do |name|
  ec_id = ExerciseCategory.find_by(name: 'Dos').id
  Exercise.create(name: name, exercise_category_id: ec_id)
end

 ["Tractions prise sérrée en supination", "Tractions prise serrée marteau", "Tractions allongées prise serrée en supination", "Tractions au TRX en supination", "Biceps curl au TRX","Biceps curl haltères en rotation (2 en même temps / alterné)", "Biceps curl haltères en supination (2 en même temps / alterné)", "Biceps curl haltères prise marteau (2 en même temps / alterné)","Biceps curl barre en supination", "Biceps curl barre en pronation","Biceps curl poulie basse en supination", "Biceps curl poulie basse en pronation", "Biceps curl poulie basse unilatéral", "Biceps curl poulie basse marteau (avec corde)","Biceps curl incliné (2 en même temps / unilatéral)","Biceps curl au pupitre Larry Scott (barre / haltère)", "Biceps curl au pupitre machine (2 en même temps / unilatéral)","Biceps curl concentration", "Biceps curl concentration sur un dossier","Biceps curl aux poulies vis-à-vis"].each do |name|
 ec_id = ExerciseCategory.find_by(name: 'Biceps').id
 Exercise.create(name: name, exercise_category_id: ec_id)
end

 ["Développé militaire barre", "Développé militaire haltères", "Développé militaire haltères rotation", "Développé militaire machine guidée", "Développé militaire machine semi-guidée","Elévations frontales barre", "Elévations frontales poulie basse (barre / corde)", "Elévations frontales haltères (2 en même temps / alterné)", "Elévations frontales avec disque", "Elévations frontales + rotations avec disque","Elévations latérales bras fléchis", "Elévations latérales bras tendus", "Elévations latérales bras tendus - pouces vers le sol", "Elévations latérales unilatérales", "Elévations latérales machine guidée", "Elévations latérales poulie basse - unilatéral","Oiseau avec haltères", "Oiseau aux poulies basses", "Oiseau à la poulie basse unilatéral","Deltoïdes postérieurs au butterfly", "Deltoïdes postérieurs à la poulie - unilatéral", "Deltoïdes postérieurs à la poulie haute avec corde","L-fly à la poulie", "L-fly avec élastique",
"L-fly au sol avec haltère","Ecartés au TRX","Elévations frontales au TRX","Tirage menton (sérré / large)", "Epaulé jeté", "Shrug",
"Shrug en rotation"].each do |name|
ec_id = ExerciseCategory.find_by(name: 'Épaules').id
Exercise.create(name: name, exercise_category_id: ec_id)
end

 ["Leg press (guidée / 45°)", "Leg press serré (guidée / 45°)", "Leg press unilatéral (guidée / 45°)","Leg curl assis", "Leg curl assis unilatéral", "Leg curl allongé", "Leg curl allongé unilatéral", "Leg curl allongé haltère", "Leg curl debout unilatéral", "Ischios à la swiss ball", "Ischios au TRX","Leg extensions", "Leg extensions unilatéral", "Extensions au sol sur pointes de pied", "Extensions au sol sur pointes de pied - unilatéral","La chaise", "La chaise + abductions avec élastique", "La chaise + adductions avec balle","Squat", "Front squat", "Squat sumo", "Squat pieds joints", "Squat jump", "Jumping Jack Squat", "Squat box", "Squat + montées de genoux", "Thruster", "Squat pistol", "Squat pistol sur box", "Squat au TRX", "Squat pistol au TRX", "Squat jump au TRX", "Fentes (barre libre / barre guidée / haltères)", "Fentes avant alternées", "Fentes arrière alternées", "Fentes dynamiques", "Fentes bulgares (barre libre / barre guidée / haltères / machine, TRX)", "Fentes en marchant", "Montée de genoux sur box","Adducteurs à la machine", "Adducteurs au sol", "Adducteurs debout à la machine", "Adducteurs à la poulie basse","Abducteurs à la machine", "Abductions de hanche au sol jambe fléchie", "Abductions de hanche au sol jambe tendue", "Abductions de hanche debout avec disque", "Abductions de hanche debout à la poulie basse", "Abductions de hanche debout à la machine","Rear kick au sol sur les genoux", "Rear kick à la machine", "Rear kick à la poulie basse","Hipthrust (haltère / barre guidée / barre libre)", "Hipthrust au sol", "Hipthrust au sol - unilatéral","Mollets assis (bilatéral / unilatéral)", "Mollets debout machine (bilatéral / unilatéral)",
"Mollets debout unilatéral","Jambier antérieur"].each do |name|
ec_id = ExerciseCategory.find_by(name: 'Jambes').id
Exercise.create(name: name, exercise_category_id: ec_id)
end

 ["Crunch au sol", "Crunch au sol avec élastique", "Crunch assis à la machine", "Crunch allongé à la machine", "Crunch à la poulie haute", "Crunch obliques (simple / une jambe / 2 jambes)","Relevés de bassin", "Relevés de bassin - la cheville sur le genou opposé", "Relevés de bassin à la chaise romaine", "Relevés de bassin suspendu à la barre fixe", "Relevés de bassin obliques à la barre fixe","Criss - cross", "Rotations de buste au sol",
"Rotations de bassin au sol","Inclinaisons de buste au sol","Inclinaisons de buste au sol avec élastique", "Inclinaisons de buste debout", "Inclinaisons de buste au pupitre","Gainage", "Gainage + rotations de bassin", "Gainage swiss ball sur les avant-bras", "Gainage swiss ball sur les chevilles", "Gainage latéral", "Gainage dos au sol", "Rotations de buste à la poulie","Relevés de bassin inversé au TRX", "Relevés de bassin oblique au TRX", "Gainage au TRX", "Gainage latéral au TRX", "Pendule au TRX",
"Mountain climber au TRX"].each do |name|
ec_id = ExerciseCategory.find_by(name: 'Abdos').id
Exercise.create(name: name, exercise_category_id: ec_id)
end

 ["Burpees", "Mountain climber", "Jumping Jack", "Kettlebell Swing (bilatéral / unilatéral)", "Thruster", "Montées de genoux", "Montées de genoux + extensions de bras", "Sauts groupés", "Ergocycle (rameur)", "Tapis de course", "Tapis de course incurvé", "Escalier", "Vélo", "Elliptique", "Stepper",
"Corde à sauter (simple / avec montées de genoux / double under)"].each do |name|
ec_id = ExerciseCategory.find_by(name: 'Autres').id
Exercise.create(name: name, exercise_category_id: ec_id)
end

Exercise.update_all(published: true)
