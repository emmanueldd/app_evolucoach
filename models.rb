app evolucoach


rails g model Pro first_name last_name description 
rails g model User first_name last_name
rails g model Stat pro:references stat_type stat_value
rails g model Rating pro:references user:references score:integer comment:text
rails g model Availability pro:references user:references (si y a un user, ça n'est pas libre) start_time:datetime available:boolean
rails g model Pack pro:references name description:text price:integer number_of_courses:integer
rails g model Program pro:references name description:text price:integer
rails g model Exercice
rails g model ProgramHasExercice
rails g model Course
rails g model Order user:references pro:references status:integer total_price:integer STRIPE
rails g model OrderHasItem order:references item(program ou pack) quantity:integer price:integer
rails g model Notification
rails g model Crm (ProHasUser) pro:references user:references user_type(%w lead client)
