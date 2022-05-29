# SH-Cart - shopping list generator.
### Allows the user to create:
- a shopping list manually or based on the weekly nutritional plan,
- favorite shopping products,
- favorite recipes and calculate its calories,
- a weekly nutritional plan,
- group/family with other users and share information.
### Additionally:
- to export shopping list to PDF, CSV and XLSX format,
- to schedule sending shopping list by email.

## Tech
- Ruby version 3.1.0
- Rails 7.0.0
- Database PostgreSQL
- Bootstrap 5

## Demo: [SH-Card Heroku](http://sh-cart.herokuapp.com/)

## Environment Variables
To run this project, you will need to add the following environment variables to your config/credentials.yml.enc file
`nutritionix, api_key`;
`nutritionix, app_id`;
`sendgrid, api_key`;

## Lessons Learned
#### I'm a junior Ruby Developer and the SH-Cart is the place where I practise new skills:
- Export data to different formats
- Write API requests
- Send email with data
- Schedule tasks
- Check the code with rubocop
