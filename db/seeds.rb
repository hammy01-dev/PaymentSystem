# frozen_string_literal: true

User.create({ email: 'devsinc@gmail.com', password: '123456', role: 0 , name:'admin'})
User1 = User.create({ email: 'devsinc1@gmail.com', password: '123456', role: 1, name: 'hamza' })
User2 = User.create({ email: 'devsinc2@gmail.com', password: '123456', role: 1, name: 'hassan' })
User3 = User.create({ email: 'devsinc3@gmail.com', password: '123456', role: 1, name: 'haris' })

Plan1 = Plan.create({name: "Advanced " , monthly_fee: '900'})
Plan2 = Plan.create({name: "Basic " , monthly_fee: '200'})
Plan3 = Plan.create({name: "Premium " , monthly_fee: '600'})
Plan4 = Plan.create({name: "Advanced Premium " , monthly_fee: '1200'})

Feature1 = Feature.create({name: '100GB Data',code:1,unit_price:200, max_unit_limit:20, plan_id: Plan1.id})
Feature2 = Feature.create({name: '1080px Display',code:2,unit_price:300, max_unit_limit:150, plan_id: Plan1.id})
Feature3 = Feature.create({name: '5GB Data',code:3,unit_price:500, max_unit_limit:120, plan_id: Plan2.id})
Feature4 = Feature.create({name: '440px Display',code:4,unit_price:600, max_unit_limit:230, plan_id: Plan2.id})
Feature5 = Feature.create({name: '15GB Data',code:5,unit_price:700, max_unit_limit:220, plan_id: Plan3.id})
Feature6 = Feature.create({name: '1440px Display',code:6,unit_price:800, max_unit_limit:320, plan_id: Plan3.id})
Feature7 = Feature.create({name: '20GB Data',code:7,unit_price:1200, max_unit_limit:420, plan_id: Plan4.id})
Feature8 = Feature.create({name: '4k Dsisplay',code:8,unit_price:2100, max_unit_limit:520, plan_id: Plan4.id})

Subscription1 = Subscription.create({plan_id:Plan1.id,user_id:User1.id})
Subscription2 = Subscription.create({plan_id:Plan2.id,user_id:User2.id})
Subscription3 = Subscription.create({plan_id:Plan3.id,user_id:User3.id})


