u1 = User.create(nickname: 'jean', email: 'jean@bertrand.fr', name: 'Jean Le Cuisto', password: 'password')
u2 = User.create(nickname: 'antoine', email: 'antoine@gmail.fr', name: 'Antoine du Nord', password: 'password')
u3 = User.create(nickname: 'honoré', email: 'monmail@mail.fr', name: 'Honoré nash', password: 'password')
u4 = User.create(nickname: 'julien', email: 'julien@hotmail.fr', name: 'Julien', password: 'password')

u1.follow << u2
u1.follow << u3
u4.follow << u1
u3.follow << u1
u3.follow << u2
u3.follow << u4

r1 = u1.recipes.create(
                         description: 'Mes Fajitas maison',
                         price: 1,
                         time: 30,
                         serving: 3,
                         steps: [
                           'Acheter de la sauce',
                           'Acheter des Fajitas',
                           'Mettre la sauce sur les Fajitas',
                           'Manger'
                        ]
                      )
r1.tags << Tag.find_or_create_by(name: 'espagnol')
r1.tags << Tag.find_or_create_by(name: 'healthy')
r1.tags << Tag.find_or_create_by(name: 'homemade')
r1.ingredients << Ingredient.create(label: 'sauce', quantity: '1', unit: 'pot')
r1.ingredients << Ingredient.create(label: 'fajitas', quantity: '6', unit: 'unité')

r2 = u1.recipes.create(
                         description: 'Mes lasagnes du dimanche',
                         price: 2,
                         time: 60,
                         serving: 5,
                         steps: [
                           'Mettre une couche de sauce tomate',
                           'Mettre une couche de viande haché',
                           'Mettre une couche de pates à lasagne pré-cuite',
                           'Répéter jusqu\'à arriver au bord du plat',
                           'Finir avec du fromage pour gratiner'
                        ]
                      )
r2.tags << Tag.find_or_create_by(name: 'italien')
r2.tags << Tag.find_or_create_by(name: 'pascher')
r2.ingredients << Ingredient.create(label: 'sauce', quantity: '1', unit: 'pot')
r2.ingredients << Ingredient.create(label: 'viande', quantity: '700', unit: 'gr')
r2.ingredients << Ingredient.create(label: 'pate à lasagne pré-cuite', quantity: '200', unit: 'gr')

r3 = u2.recipes.create(
                         description: 'Ma choucroute de famille',
                         price: 3,
                         time: 180,
                         serving: 4,
                         steps: [
                           'Laver le chou plusieurs fois',
                           'Déposer le chou au fond du plat',
                           'Mettre la viande par dessus',
                           'Rajouter les pommes de terres',
                           'Laisser cuire 2h',
                           'Déguster avec un bon verre de Riesling'
                        ]
                      )
r3.tags << Tag.find_or_create_by(name: 'alsace')
r3.tags << Tag.find_or_create_by(name: 'dimanche')
r3.tags << Tag.find_or_create_by(name: 'fat')
r3.ingredients << Ingredient.create(label: 'chou', quantity: '500', unit: 'gr')
r3.ingredients << Ingredient.create(label: 'knacks', quantity: '2', unit: 'paires')
r3.ingredients << Ingredient.create(label: 'lard fumé', quantity: '200', unit: 'gr')
r3.ingredients << Ingredient.create(label: 'palette', quantity: '200', unit: 'gr')


r4 = u3.recipes.create(
                         description: 'Les pates pas cher',
                         price: 1,
                         time: 10,
                         serving: 1,
                         steps: [
                           'Prendre des pates cuisson rapide',
                           'Les mettres dans l\'eau 3min',
                           'Egouter',
                           'Rajouter du beurre',
                           'Déguster !'
                        ]
                      )
r4.tags << Tag.find_or_create_by(name: 'pascher')
r4.tags << Tag.find_or_create_by(name: 'pasta')
r4.ingredients << Ingredient.create(label: 'pates', quantity: '150', unit: 'gr')
r4.ingredients << Ingredient.create(label: 'beurre', quantity: '10', unit: 'gr')

r5 = u4.recipes.create(
                         description: 'La tarte aux pommes',
                         price: 1,
                         time: 120,
                         serving: 5,
                         steps: [
                           'Préparer les pommes (6, 7) : couper en 4, entailler les pommes',
                           'Mettre les pommes sur le fond de tarte et mettre au fourd sur l\'étage le plus basse pour 20min à 220°',
                           'Mélanger 1 oeuf avec 2 cuillères à soupe de sucre',
                           'Rajouter de la crème fraiche et mélanger',
                           'Mettre la mixture sur la tarte puis remettre au four 15/20min à 220°'
                        ]
                      )
r5.tags << Tag.find_or_create_by(name: 'dessert')
r5.tags << Tag.find_or_create_by(name: 'dimanche')
r5.tags << Tag.find_or_create_by(name: 'pommes')
r5.ingredients << Ingredient.create(label: 'pates', quantity: '200', unit: 'gr')
r5.ingredients << Ingredient.create(label: 'pommes', quantity: '400', unit: 'gr')
r5.ingredients << Ingredient.create(label: 'sucre', quantity: '20', unit: 'gr')
r5.ingredients << Ingredient.create(label: 'oeuf', quantity: '1', unit: '')
r5.ingredients << Ingredient.create(label: 'crème fraiche', quantity: '30', unit: 'cl')

r6 = u4.recipes.create(
                         description: 'La salade de pommes de terre',
                         price: 1,
                         time: 120,
                         serving: 5,
                         steps: [
                          'faire cuire des pommes de terre (pas trop grosses) en robe des champs dans l\'eau salée ou à la vapeur 20à 30 minutes selon la grosseur des pommes de terre',
                          'les peler et les couper en rondelles de 3 mm d\'épaisseur (se munir d\'un mêtre)',
                          'préparer la vinaigrette moutarde vinaigre huile crème fraiche oignons coupés en petits morceaux',
                          'mélanger les pommes de tere encore tièdes avec la vinaigrette',
                          'rajouter de l\'eau chaude dans laquelle tu as fait cuire des knacks ou du bouillon de boeuf',
                          'laisser reposer au moins 1 h avant de servir',
                          'ne pas mettre au frigo car ça ne se mange pas trop froid'
                        ]
                      )
r6.tags << Tag.find_or_create_by(name: 'pommes')
r6.tags << Tag.find_or_create_by(name: 'salade')
r6.tags << Tag.find_or_create_by(name: 'healthy')
r6.ingredients << Ingredient.create(label: 'pommes de terre', quantity: '200', unit: 'gr')
r6.ingredients << Ingredient.create(label: 'bouillon de boeuf', quantity: '20', unit: 'gr')

u2.likes << r1
u2.likes << r2
u2.likes << r3

u3.books << r1
u3.books << r2
u3.books << r5

u4.books << r1
u4.books << r2
u4.books << r3
u4.books << r4
u4.books << r5
u4.likes << r1
u4.likes << r2
u4.likes << r3
u4.likes << r4
u4.likes << r5

c1 = Comment.create(content: 'Super j\'en ai mangé toutes la semaine !')
c2 = Comment.create(content: 'Simple et efficace, parfait !')
c3 = Comment.create(content: 'Comme dans ma jeunesse')
c4 = Comment.create(content: 'Peut mieux faire :/')
r1.comments << c1
r1.comments << c2
u2.comments << c1
u3.comments << c2
r3.comments << c3
u1.comments << c3
u1.comments << c4
r1.comments << c4
