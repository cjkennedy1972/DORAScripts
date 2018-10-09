# mysqlds3_create_all.sh
# start in ./ds3/mysqlds3
cd build
echo Warning messgaes about using password via command line are normal......
echo Creating database
mysql -h fb-mysql-service -u root --password=root < mysqlds3_create_db.sql
echo Creating Indexes
mysql -h fb-mysql-service -u root --password=root < mysqlds3_create_ind.sql
echo Creating Stored Procedures
mysql -h fb-mysql-service -u root --password=root < mysqlds3_create_sp.sql
cd ../load/cust
echo Loading Customer Data
mysql -h fb-mysql-service -u root --password=root < mysqlds3_load_cust.sql
cd ../orders
echo Loading Orders Data
mysql -h fb-mysql-service -u root --password=root < mysqlds3_load_orders.sql 
echo Loading Orderlines Data
mysql -h fb-mysql-service -u root --password=root < mysqlds3_load_orderlines.sql 
echo Loading Customer History Data
mysql -h fb-mysql-service -u root --password=root < mysqlds3_load_cust_hist.sql 
cd ../prod
echo Loading Products Data
mysql -h fb-mysql-service -u root --password=root < mysqlds3_load_prod.sql 
echo Loading Inventory Data
mysql -h fb-mysql-service -u root --password=root < mysqlds3_load_inv.sql 
cd ../membership
echo Loading Membership data
mysql -h fb-mysql-service -u root --password=root < mysqlds3_load_member.sql
cd ../reviews
echo Loading Reviews data
mysql -h fb-mysql-service -u root --password=root < mysqlds3_load_reviews.sql
echo Loading Reviews Helpfulness Ratings Data
mysql -h fb-mysql-service -u root --password=root < mysqlds3_load_review_helpfulness.sql
