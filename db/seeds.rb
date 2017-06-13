# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

artists = Artist.create([
    {
        :id => 1,
        :first_name => 'Nadir',
        :last_name => 'Afonso'
    },
    {
        :id => 2,
        :first_name => 'Paul',
        :last_name => 'Cadmus'
    },
    {
        :id => 3,
        :first_name => 'Josef',
        :last_name => 'Čapek',
        :description => 'He was a Czech artist who was best known as a painter, but who was also noted as a writer and a poet. He invented the word robot, which was introduced into literature by his brother, Karel Čapek'
    },
    {
        :id => 4,
        :first_name => 'Alexander',
        :last_name => 'Bogomazov'
    },
])

Artist.find(1).artworks.create({
    :id => 1,
    :title => 'Artwork Title 1',
    :description => 'Some text',
    :price => 1000,
    :width => 5000,
    :height => 3000,
    :is_published => 'false'
});

# Artist.find(2).create({
#     :id => 2,
#     :title => 'Artwork Title 2',
#     :description => 'Some text',
#     :price => 4430,
#     :width => 5430,
#     :height => 4400,
#     :is_published => true
# });