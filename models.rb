app evolucoach


rails g model Pro first_name last_name description
rails g model User first_name last_name
rails g model Stat user:references name stat_value:float
rails g model Rating user:references client:references score:integer comment:text published:boolean
rails g model Course user:references client:references start_time:datetime status:integer

rails g model Availability user:references course:boolean start_time:datetime available:boolean taken:boolean

rails g model Pacs user:references name description:text price:integer number_of_courses:integer

# Un programme peut etre envoyé à plusieurs users ? Oui, on fera un truc pour ça, pour l instant on code comme c est maquetté
# Pas clair au niveau de la maquette, manque une page intermediaire où tu nommes le programme, puis page où tu ajoutes les exercices.

rails g model Program user:references client:references name description:text price:integer
# rails g model ProgramHasStep name("exerise/step/info #index") step_type:integer (exerise rest information) user:references program:references published:boolean round (max en 1 min) repetition (max en 1 min) charge (poid de corps ?) cadence
rails g model ExeciseCategory name published:boolean

rails g model Exercise name exercise_category:references published:boolean

rails g model ProgramStep user:references program:references exercise:references name step_type:integer published:boolean round repetition charge cadence

Programme personnalisé

rails g model Pack name user:references description bg_color position:integer color pack_type price:integer nb_of_courses:integer unit_price:integer

t.string "name"
    t.string "description"
    t.string "color"
    t.string "pack_type"
    t.decimal "price", precision: 10, scale: 2
    t.integer "discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "nb_of_courses", default: 1
    t.decimal "unit_price", precision: 10, scale: 2
    t.string "bg_color"
    t.integer "position", default: 0
rails g model Exercise
rails g model Course
rails g model Order client:references user:references status:integer total_price:integer
rails g model OrderHasItem order:references item:references{polymorphic} quantity:integer total_price:integer
# Ca nous permet d'anticiper le système de panier, mais pour l'instant, on créer un order qui créer un order_has_item, et qui redirige vers order_edit pour le paiement.


rails g model Notification
rails g model Crm (ProHasUsers user:references client:references user_type(%w lead client)
