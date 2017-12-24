#queries to insert reviews into corresponding tables

#room_Review
INSERT INTO `review` (`CID`, `rating`, `textcomment`, `review_type`)
			VALUES (/*input CID*/ CID, /*user rating*/ 10, /*user comment*/ 'was dope','Room');

INSERT INTO `room_review` VALUES ((SELECT MAX(reviewID) AS revID FROM review), /*user room_num*/ 101, /*user hotelID*/ 1);


#breakfast_Review
INSERT INTO `review` (`CID`, `rating`, `textcomment`, `review_type`)
			VALUES (/*input CID*/ CID, /*user rating*/ 9, /*user comment*/ 'was great','Breakfast');
            
INSERT INTO `breakfast_review` VALUES ((SELECT MAX(reviewID) AS revID FROM review), /*user b_type*/ 'steak and eggs', /*user hotelID*/ 2);



#service_Review
INSERT INTO `review` (`CID`, `rating`, `textcomment`, `review_type`)
			VALUES (/*input CID*/ CID, /*user rating*/ 2, /*user comment*/ 'was terrible','Service');
            
INSERT INTO `service_review` VALUES ((SELECT MAX(reviewID) AS revID FROM review), /*user s_type*/ 'spa', /*user hotelID*/ 3);
