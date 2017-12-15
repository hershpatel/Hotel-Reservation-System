--
-- Dumping data for table `hotel`
--
#DELETE FROM `hotel`
#WHERE `hotelID` >=1;

#ALTER TABLE `hotel` AUTO_INCREMENT = 1 ;

INSERT INTO `hotel`(`hotel_name`, `country`, `state`, `city`, `address`, `zipcode`)
			VALUES  ('Hyatt','USA','NJ','New Brunswick','102 Woodland Place', 10248),
					('Hilton','USA','NJ','Hoboken','78 Candylane', 89567),
					('Conrad','USA','NY','New York City','578 Cortland Drive', 25368),
					('Marriot','USA','PA','Philadelphia','32 Chocolate Avenue', 37465),
					('Westin','USA','PA','Philadelphia','198 Obama Highway', 78354),
					('Toshali Sands','India','ODA','Puri','Konark Marine Drive', 752002);


--
-- Dumping data for table `HotelPhoneNumbers`
--
DELETE FROM `HotelPhoneNumbers`
WHERE `hotelID` >=1;

INSERT INTO `HotelPhoneNumbers` VALUES (1,'7325678987'),(2,'9085476235'),(3,'6465672345'),(4,'8016785395'),
								(4,'6198234278'),(5,'7513984783'),(5,'9346752837'),(5,'2035837465'),(6,'7324987043'),
                                (6,'8072438062');


--
-- Dumping data for table `myroom`
--
#DELETE FROM `myroom`
#WHERE `hotelID` >=1;

INSERT INTO `myroom` VALUES (101, 1, 99.00, 2, 100, 'parking garage view', 'standard'),(102, 1, 100.02, 2, 100, 'nice couch', 'standard'), 
							(412, 1, 99.78, 4, 400, 'two twin beds', 'double'),(306, 1, 99.02, 4, 300, 'luxery bathrobes', 'double'),
                            (408, 1, 102.42, 4, 400, 'luxery rubber ducks', 'suite'), (105, 1, 99.87, 2, 100, 'free parking included', 'standard'),
                            (203, 1, 104.09, 4, 200, 'wifi package', 'double'), (212, 1, 102.87, 2, 200, 'no smoking', 'deluxe'),
                            (406, 1, 109.82, 2, 400, 'best toothbrushes', 'standard'),(108, 1, 162.98, 4, 100, 'lots of mirrors', 'double'),
							(103, 2, 104.32, 2, 100, 'beautiful view', 'deluxe'),(202, 2, 126.89, 1, 200, 'free coffee machine', 'standard'),
                            (809, 2, 134.67, 2, 800, 'top floor!', 'deluxe'),(604, 2, 145.04, 4, 600, 'four couches', 'suite'),
                            (419, 2, 102.42, 4, 400, 'more fun stuff', 'double'), (403, 2, 87.38, 4, 400, 'fully stocked bar', 'suite'),
                            (302, 2, 186.89, 2, 300, 'beautiful ambiance', 'deluxe'), (209, 2, 114.87, 4, 200, 'jacuzzi', 'deluxe'),
                            (404, 2, 135.04, 4, 400, 'two queens', 'double'),(719, 2, 122.25, 4, 700, 'adults and kids rooms', 'suite'),
                            (999, 2, 555.04, 4, 900, 'two queens', 'double'),(661, 2, 232.25, 4, 600, 'adults and kids rooms', 'suite'),
							(302, 3, 403.53, 2, 300, 'beautiful view', 'double'),(109, 3, 478.54, 2, 100, 'famous art collection', 'deluxe'),
                            (808, 3, 403.29, 4, 800, 'living room', 'deluxe'),(311, 3, 389.76, 2, 300, 'fireplace', 'standard'),
                            (514, 3, 439.45, 2, 500, 'one queen bed', 'standard'), (502, 3, 393.53, 1, 500, 'free water bottles', 'standard'),
                            (209, 3, 448.58, 4, 200, 'good movie selection', 'deluxe'), (308, 3, 413.39, 4, 300, 'multiple bathrooms', 'suite'),
                            (411, 3, 402.72, 4, 400, 'powerful AC', 'double'),(114, 3, 443.45, 2, 100, 'basic bed', 'standard'),
                            (206, 4, 123.42, 2, 200, 'two rooms', 'suite'),(602, 4, 126.87, 4, 600, 'very spacious', 'deluxe'), 
                            (407, 4, 134.89, 2, 400, 'two bathrooms', 'double'),(214, 4, 102.00, 4, 200, 'skyline view', 'standard'),
                            (305, 4, 102.00, 4, 300, 'river view', 'double'), (306, 4, 114.56, 2, 300, 'best DVR', 'suite'),
                            (402, 4, 134.32, 1, 400, 'one queen', 'standard'), (507, 4, 119.87, 2, 500, 'two bedrooms', 'suite'),
                            (414, 4, 120.98, 4, 400, 'colorful wallpaper', 'standard'),(105, 4, 202.20, 4, 100, 'amazing smell', 'suite'),
                            (605, 5, 359.87, 2, 600, 'decent view', 'standard'),(412, 5, 335.78, 4, 400, 'kids friendly', 'double'),
                            (104, 5, 308.90, 2, 100, 'king size bed', 'deluxe'),(118, 5, 392.78, 4, 100, 'three bedrooms', 'suite'),
                            (407, 5, 292.89, 2, 400, 'three bedrooms', 'standard'), (305, 5, 329.78, 4, 300, 'stocked bar', 'suite'),
                            (112, 5, 325.98, 4, 100, 'pajamas included', 'double'), (204, 5, 326.54, 1, 200, 'fit for a king', 'deluxe'),
                            (618, 5, 337.86, 2, 600, 'loud alarms', 'standard'), (507, 5, 327.54, 4, 500, 'safest room', 'suite'),
							(310, 5, 512.00, 4, 300, 'stocked bar', 'suite'),(122, 5, 312.12, 4, 100, 'pajamas included', 'double'),
                            (214, 5, 334.12, 1, 200, 'fit for a king', 'deluxe'),(617, 5, 350.21, 2, 600, 'loud alarms', 'standard'),
                            (523, 5, 311.11, 4, 500, 'safest room', 'suite'),
							(206, 6, 123.42, 2, 200, 'two rooms', 'suite'),(602, 6, 126.87, 4, 600, 'very spacious', 'deluxe'), 
                            (407, 6, 134.89, 2, 400, 'two bathrooms', 'double'),(214, 6, 102.00, 4, 200, 'skyline view', 'standard'),
                            (305, 6, 102.00, 4, 300, 'river view', 'double'), (306, 6, 114.56, 2, 300, 'best DVR', 'suite'),
                            (402, 6, 134.32, 1, 400, 'one queen', 'standard'), (507, 6, 119.87, 2, 500, 'two bedrooms', 'suite'),
                            (414, 6, 120.98, 4, 400, 'colorful wallpaper', 'standard'),(105, 6, 202.20, 4, 100, 'amazing smell', 'suite');


--
-- Dumping data for table `room_discount`
--
#DELETE FROM `room_discount`
#WHERE `hotelID` >=1;

INSERT INTO `room_discount` VALUES (101, 1, 25, '2017-12-19','2018-12-21'), (102, 1, 20, '2018-1-13','2018-2-01'), (105, 1, 35, '2017-12-21','2018-12-29'),(406, 1, 15, '2017-12-24','2018-12-30'),(108, 1, 10, '2018-1-03','2018-1-28'),
                                    (103, 2, 10, '2018-1-13','2018-2-27'), (202, 2, 20, '2018-1-02','2018-4-25'), (809, 2, 10, '2017-12-11','2018-12-29'), (302, 2, 30, '2017-12-21','2018-3-29'),
                                    (302, 3, 10, '2017-12-19','2018-3-11'), (502, 3, 35, '2018-2-09','2018-5-11'), (109, 3, 30, '2018-1-02','2018-2-25'), (308, 3, 15, '2017-12-21','2018-3-29'), 
                                    (206, 4, 25, '2018-2-03','2018-3-01'), (402, 4, 40, '2017-12-23','2018-12-31'), (407, 4, 20, '2018-1-09','2018-5-11'), (414, 4, 10, '2018-1-13','2018-3-01'),
                                    (605, 5, 20, '2018-1-13','2018-4-09'), (204, 5, 15, '2017-12-22','2018-1-29'), (112, 5, 15, '2018-1-13','2018-2-15'), (305, 5, 35, '2018-1-09','2018-5-11'),
                                    (206, 6, 25, '2018-2-03','2018-3-01'), (402, 6, 40, '2017-12-23','2018-4-31'), (407, 6, 20, '2018-1-09','2018-5-11'), (414, 6, 10, '2018-1-13','2018-3-01');


--
-- Dumping data for table `reservation`
--
#DELETE FROM `reservation`
#WHERE `invoiceNo` >=1;

#ALTER TABLE `reservation` AUTO_INCREMENT = 1;

INSERT INTO `reservation` (`CID`, `totalAmt`, `resDate`)
			VALUES (1,309.2199979,NOW()), (1,308.8599973,NOW()), (1,446.3199957,NOW()),(1,261.2999991,NOW()),
			(2,221.039999,NOW()), (2,219.5499986,NOW()), (2,917.9399953,NOW()),(2,570.3099985,NOW()),
			(3,658.4099988,NOW()), (3,468.6999986,NOW()), (3,1301.829996,NOW()),(3,1529.959997,NOW()),
			(4,533.5099975,NOW()), (4,394.7800005,NOW()), (4,737.5700066,NOW()),(4,827.3300002,NOW()),(4,287.4099992,NOW()),(4,712.709996,NOW());


--
-- Dumping data for table `reserves`
--
#DELETE FROM `reserves`
#WHERE `invoiceNo` >=1;

INSERT INTO `reserves` VALUES (1, 101, 1, 2, '2016-12-18','2016-12-21'), (2, 102, 1, 2, '2017-1-01','2017-1-03'), 
							  (3, 105, 1, 3, '2016-12-15','2016-12-19'), (4, 406, 1, 1, '2017-1-14','2017-1-15'),
							  (5, 108, 1, 1, '2017-2-03','2017-2-04'), (6, 103, 2, 1, '2017-1-13','2017-1-14'), 
							  (7, 202, 2, 2, '2016-12-02','2016-12-04'), (8, 809, 2, 1, '2016-12-09','2016-12-10'),
                              (7, 302, 2, 2, '2016-12-02','2016-12-04'), (8, 604, 2, 1, '2016-12-09','2016-12-10'),
							  (9, 302, 2, 3, '2017-1-17','2017-1-19'), (10, 302, 3, 1, '2016-12-29','2016-12-30'), 
							  (11, 502, 3, 3, '2016-12-16','2016-12-18'), (12, 109, 3, 3, '2017-4-02','2017-4-06'), 
							  (13, 308, 3, 1, '2017-1-03','2017-1-04'), (14, 206, 4, 2, '2017-1-03','2017-1-05'), 
							  (15, 402, 4, 4, '2016-12-14','2016-12-17'), (16, 605, 5, 2, '2016-12-13','2016-12-15'),
                              (17, 206, 6, 2, '2016-12-13','2016-12-15'), (18, 402, 6, 4, '2016-12-13','2016-12-15');


--
-- Dumping data for table `breakfast`
--
#DELETE FROM `breakfast`
#WHERE `hotelID` >=1;

INSERT INTO `breakfast` VALUES ('continental', 1, 'bagels, yogurt and granola, fruit, muffins/croissants', 11.79), 
							   ('classic morning', 1, 'fruit, eggs, breakfast potatoes, muffins/croissants', 12.69),
							   ('steak and eggs', 1, 'fruit, eggs, breakfast potatoes, strip steak, muffins/croissants', 16.89),
                               ('continental', 2, 'bagels, yogurt and granola, fruit, muffins/croissants', 12.49),
                               ('classic morning', 2, 'fruit, eggs, breakfast potatoes, muffins/croissants', 14.29),
                               ('steak and eggs', 2, 'fruit, eggs, breakfast potatoes, strip steak, muffins/croissants', 17.49),
                               ('continental', 3, 'bagels, yogurt and granola, fruit, muffins/croissants', 10.99),
                               ('classic morning', 3, 'fruit, eggs, breakfast potatoes, muffins/croissants', 11.15),
                               ('steak and eggs', 3, 'fruit, eggs, breakfast potatoes, strip steak, muffins/croissants', 17.05),
                               ('continental', 4, 'bagels, yogurt and granola, fruit, muffins/croissants', 11.49),
                               ('classic morning', 4, 'fruit, eggs, breakfast potatoes, muffins/croissants', 14.75),
                               ('steak and eggs', 4, 'fruit, eggs, breakfast potatoes, strip steak, muffins/croissants', 19.45),
                               ('continental', 5, 'bagels, yogurt and granola, fruit, muffins/croissants', 14.99),
                               ('classic morning', 5, 'fruit, eggs, breakfast potatoes, muffins/croissants', 14.99),
                               ('steak and eggs', 5, 'fruit, eggs, breakfast potatoes, strip steak, muffins/croissants', 16.65),
                               ('continental', 6, 'bagels, yogurt and granola, fruit, muffins/croissants', 14.99),
                               ('classic morning', 6, 'fruit, eggs, breakfast potatoes, muffins/croissants', 14.99),
                               ('steak and eggs', 6, 'fruit, eggs, breakfast potatoes, strip steak, muffins/croissants', 16.65);


--
-- Dumping data for table `services`
--
#DELETE FROM `services`
#WHERE `hotelID` >=1;

INSERT INTO `services` VALUES ('ironing', 1, 8.79), ('dry cleaning', 1, 7.69), 
							  ('spa', 1, 28.89), ('ironing', 2, 9.49), 
                              ('dry cleaning', 2, 8.29), ('spa', 2, 27.49), 
                              ('ironing', 3, 7.99), ('dry cleaning', 3, 6.15), 
                              ('spa', 3, 29.05), ('ironing', 4, 7.49), 
                              ('dry cleaning', 4, 7.75), ('spa', 4, 29.45), 
                              ('ironing', 5, 7.99), ('dry cleaning', 5, 6.99), 
                              ('spa', 5, 32.65), ('ironing', 6, 7.94), ('dry cleaning', 6, 4.99), 
                              ('spa', 6, 12.65);


--
-- Dumping data for table `review`
--
#DELETE FROM `review`
#WHERE `reviewID` >=1;

#ALTER TABLE `review` AUTO_INCREMENT = 1 ;

INSERT INTO `review` (`CID`, `rating`, `title`, `textcomment`, `review_type`)
			VALUES (1, 1, 'Title 1', 'This was bad - 1/10! I like eating cheese.', 'Breakfast'), (1, 5, 'Title 2', 'This was good - 5/10. I like eating sunflower seeds.', 'Breakfast'), (1, 7, 'Title 3', 'This was good - 7/10. I like eating eel.', 'Breakfast'), (1, 6, 'Title 4', 'This was good - 6/10. I like eating arugula.', 'Breakfast'), (1, 10, 'Title 5', 'This was great - 10/10! I like eating almond butter.', 'Breakfast'), 
            (1, 10, 'Title 6', 'This was great - 10/10! I like eating rum.', 'Breakfast'), (1, 9, 'Title 7', 'This was great - 9/10! I like eating monkfish.', 'Breakfast'), (1, 10, 'Title 8', 'This was great - 10/10! I like eating cherries.', 'Breakfast'), (2, 4, 'Title 9', 'This was okay - 4/10. I like eating angelica.', 'Breakfast'), (2, 6, 'Title 10', 'This was good - 6/10. I like eating brussels sprouts.', 'Breakfast'), 
            (2, 5, 'Title 11', 'This was good - 5/10. I like eating gelatin.', 'Breakfast'), (2, 7, 'Title 12', 'This was good - 7/10. I like eating ginger.', 'Breakfast'), (2, 10, 'Title 13', 'This was great - 10/10! I like eating corn.', 'Breakfast'), (2, 7, 'Title 14', 'This was good - 7/10. I like eating aquavit.', 'Breakfast'), (2, 8, 'Title 15', 'This was great - 8/10! I like eating watermelons.', 'Breakfast'), 
            (2, 5, 'Title 16', 'This was good - 5/10. I like eating chicory.', 'Breakfast'), (2, 6, 'Title 17', 'This was good - 6/10. I like eating wild rice.', 'Breakfast'), (2, 6, 'Title 18', 'This was good - 6/10. I like eating broccoli.', 'Breakfast'), (3, 1, 'Title 19', 'This was bad - 1/10! I like eating tomatoes.', 'Breakfast'), (3, 7, 'Title 20', 'This was good - 7/10. I like eating tomatoes and potatotes.', 'Breakfast'), 
            (3, 10, 'Title 21', 'This was great - 10/10! I like eating barbecue sauce.', 'Service'), (3, 5, 'Title 22', 'This was good - 5/10. I like eating pomegranates.', 'Service'), (3, 9, 'Title 23', 'This was great - 9/10! I like eating sherry.', 'Service'), (3, 3, 'Title 24', 'This was okay - 3/10. I like eating capers.', 'Service'), (3, 5, 'Title 25', 'This was good - 5/10. I like eating barley.', 'Service'), 
            (4, 2, 'Title 26', 'This was bad - 2/10! I like eating parsley.', 'Service'), (4, 5, 'Title 27', 'This was good - 5/10. I like eating shrimp.', 'Service'), (4, 2, 'Title 28', 'This was bad - 2/10! I like eating Brower stir fry.', 'Service'), (4, 4, 'Title 29', 'This was okay - 4/10. I like eating Livi Mongolian grill.', 'Service'), (4, 1, 'Title 30', 'This was bad - 1/10! I like eating cilantro.', 'Service'), 
            (4, 3, 'Title 31', 'This was okay - 3/10. I like eating chai.', 'Service'), (4, 1, 'Title 32', 'This was bad - 1/10! I like eating coffee beans.', 'Service'), (4, 3, 'Title 33', 'This was okay - 3/10. I like eating hot sauce.', 'Service'), (4, 10, 'Title 34', 'This was great - 10/10! I like eating tomato puree.', 'Service'), (1, 9, 'Title 35', 'This was great - 9/10! I like eating half-and-half.', 'Service'), 
            (1, 7, 'Title 36', 'This was good - 7/10. I like eating cashews.', 'Service'), (1, 1, 'Title 37', 'This was bad - 1/10! I like eating almonds.', 'Service'), (2, 8, 'Title 38', 'This was great - 8/10! I like eating Brazil nuts.', 'Service'), (2, 6, 'Title 39', 'This was good - 6/10. I like eating biscuits.', 'Service'), (2, 9, 'Title 40', 'This was great - 9/10! I like eating Lindt chocolates.', 'Service'), 
            (2, 3, 'Title 41', 'This was okay - 3/10. I like eating Ferrero Rochers.', 'Room'), (2, 1, 'Title 42', 'This was bad - 1/10! I like eating Nutella.', 'Room'), (2, 4, 'Title 43', 'This was okay - 4/10. I like eating Peanut Butter.', 'Room'), (2, 8, 'Title 44', 'This was great - 8/10! I like eating Jelly.', 'Room'), (2, 7, 'Title 45', 'This was good - 7/10. I like eating tarragon.', 'Room'), 
            (2, 10, 'Title 46', 'This was great - 10/10! I like eating water chestnuts.', 'Room'), (2, 6, 'Title 47', 'This was good - 6/10. I like eating canola oil.', 'Room'), (3, 1, 'Title 48', 'This was bad - 1/10! I like eating blueberries.', 'Room'), (3, 1, 'Title 49', 'This was bad - 1/10! I like eating salsa.', 'Room'), (3, 5, 'Title 50', 'This was good - 5/10. I like eating rabbits.', 'Room'), 
            (3, 9, 'Title 51', 'This was great - 9/10! I like eating amaretto.', 'Room'), (3, 2, 'Title 52', 'This was bad - 2/10! I like eating quail.', 'Room'), (3, 6, 'Title 53', 'This was good - 6/10. I like eating duck.', 'Room'), (3, 4, 'Title 54', 'This was okay - 4/10. I like eating turkey.', 'Room'), (1, 10, 'Title 55', 'This was great - 10/10! I like eating chicken.', 'Room'), 
            (1, 5, 'Title 56', 'This was good - 5/10. I like eating turducken.', 'Room'), (4, 6, 'Title 57', 'This was good - 6/10. I like eating tofurkey.', 'Room'), (4, 7, 'Title 58', 'This was good - 7/10. I like eating guavas.', 'Room'), (4, 2, 'Title 59', 'This was bad - 2/10! I like eating brandy.', 'Room'), (4, 7, 'Title 60', 'This was good - 7/10. I like eating Havarti cheese.', 'Room');


--
-- Dumping data for table `room_review`
--
#DELETE FROM `room_review`
#WHERE `reviewID` >=1;

INSERT INTO `room_review` VALUES (41, 101, 1), (42, 103, 2), (43, 808, 3), (44, 104, 5), 
								 (45, 202, 2), (46, 407, 4), (47, 102, 1), (48, 118, 5), 
                                 (49, 214, 4), (50, 412, 1), (51, 305, 4), (52, 306, 4), 
                                 (53, 306, 1), (54, 311, 3), (55, 809, 2), (56, 402, 4), 
                                 (57, 408, 1), (58, 407, 5), (59, 514, 3), (60, 105, 1);

--
-- Dumping data for table `breakfast_review`
--
#DELETE FROM `breakfast_review`
#WHERE `reviewID` >=1;

INSERT INTO `breakfast_review` VALUES (1, 'continental', 1), (2, 'continental', 2), 
									  (3, 'continental', 3), (4, 'continental', 4), 
                                      (5, 'continental', 5), (6, 'classic morning', 1), 
                                      (7, 'classic morning', 1), (8, 'classic morning', 2),
                                      (9, 'classic morning', 3), (10, 'classic morning', 4), 
                                      (11, 'classic morning', 5), (12, 'classic morning', 5), 
                                      (13, 'steak and eggs', 1), (14, 'steak and eggs', 2), 
                                      (15, 'steak and eggs', 2), (16, 'steak and eggs', 3), 
                                      (17, 'steak and eggs', 3), (18, 'steak and eggs', 4), 
                                      (19, 'steak and eggs', 5),(20, 'steak and eggs', 4);

-- Dumping data for table `service_review`
--
#DELETE FROM `service_review`
#WHERE `reviewID` >=1;

INSERT INTO `service_review` VALUES (21, 'spa', 1), (22, 'spa', 2), (23, 'spa', 3), 
									(24, 'spa', 4), (25, 'spa', 5), (26, 'spa', 5), 
                                    (27, 'dry cleaning', 1), (28, 'dry cleaning', 2), 
                                    (29, 'dry cleaning', 2), (30, 'dry cleaning', 3), 
                                    (31, 'dry cleaning', 4), (32, 'dry cleaning', 5), 
                                    (33, 'ironing', 1), (34, 'ironing', 2), 
                                    (35, 'ironing', 3), (36, 'ironing', 3), 
                                    (37, 'ironing', 4), (38, 'ironing', 4), 
                                    (39, 'ironing', 5), (40, 'ironing', 5);

--
-- Dumping data for table `contains`
--
#DELETE FROM `contains`
#WHERE `invoiceNo` >=1;

INSERT INTO `contains` VALUES (1, 2, 1, 'spa'), (1, 3, 1, 'dry cleaning'), (1, 4, 1, 'ironing'), 
							  (2, 2, 1, 'dry cleaning'), 
							  (3, 1, 1, 'ironing'), (4, 5, 1, 'spa'),
							  (5, 6, 1, 'dry cleaning'), (6, 7, 2, 'ironing'), 
							  (7, 8, 2, 'spa'), (8, 2, 2, 'dry cleaning'),
							  (9, 1, 2, 'ironing'), (10, 4, 3, 'spa'), 
							  (11, 5, 3, 'ironing'), (12, 6, 3, 'dry cleaning'), 
							  (13, 8, 3, 'spa'), (14, 11, 4, 'ironing'), 
							  (15, 3, 4, 'ironing'), (16, 4, 5, 'spa'),
                              (17, 1, 6, 'dry cleaning'), (18, 2, 6, 'ironing');


--
-- Dumping data for table `includes`
--
#DELETE FROM `includes`
#WHERE `invoiceNo` >=1;

INSERT INTO `includes` VALUES (1, 2, 1, 'classic morning'), (1, 1, 1, 'steak and eggs'), (1, 2, 1, 'continental'), (2, 5, 1, 'classic morning'), 
							  (3, 6, 1, 'steak and eggs'), (4, 9, 1, 'continental'),
							  (5, 1, 1, 'classic morning'), (6, 4, 2, 'steak and eggs'), 
							  (7, 8, 2, 'continental'), (8, 7, 2, 'classic morning'),
							  (9, 3, 2, 'steak and eggs'), (10, 2, 3, 'continental'), 
							  (11, 7, 3, 'classic morning'), (12, 3, 3, 'steak and eggs'), 
							  (13, 7, 3, 'continental'), (14, 7, 4, 'classic morning'), 
							  (15, 8, 4, 'steak and eggs'), (16, 4, 5, 'continental'),
                              (17, 1, 6, 'classic morning'), (18, 9, 6, 'steak and eggs');


--
-- Dumping data for table `creditcard`
--
#DELETE FROM `creditcard`
#WHERE `InvoiceNo` >=1;

INSERT INTO `creditcard` VALUES ();