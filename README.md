# Payment System APP
## A Saas Based Application Feature



[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)
## Introduction
In this project we build a Recurring Payment System based on the users subscribed plans and feature usage of respective plans. It is an essential feature of any saas based applications. We used stripe for payment integeration. It contains two types of users

- Admin can create, edit, delete plans, features and usages
- Buyer can subscribe to plans
## Features

- A Buyer can subscribe to many plans and plans can have many features
- Each feature has usage-limit and unit price
- Each plan has a monthly fee
- Each subscription has billing date on which user subscribed to particular plan
- Based on the subscription admin can create the usage of each user for a particular feature
- Based on the usage table we calculate the overusage of feature (if any ) and charge the buyer after one month according to biiling date. Used the crone job for this feature which runs everyday.




## Tech

Dillinger uses a number of open source projects to work properly:

- RubyOnRails - For habdling MVC!
- VS Code Editor - awesome web-based text editor
- PG - PostgreSql database
-  Bootstrap - great UI boilerplate for modern web apps





## Models
- User has buyers and one admin
- Plans has plans created by admins
- Subscriptions store which buyer has subscribed to whcih plan and stores billing date
- Features have features associated to plans
- Usage has the record of usages of features of particular subscriptions
- Transactions record all the transactions of particular subscriptions and their usages.

## Installation

- Use Git clone to clone the repository to the local machine
- bundle install
-    Use rake db/setup to create db and seed add into it
 -   Start server using rails s
 -   Run loaclhost:3000
 -   Login as a admin, You can invite others as buyers to your application
 -   Login as Buyer, Subscribe to Plans
 -   Add stripe card details to subscribe to a plan
whatever port was exposed in the Dockerfile):

