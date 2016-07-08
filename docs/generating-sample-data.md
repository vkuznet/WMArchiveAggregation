# Generating Sample Data

Follow this procedure to generate sample data from the HDFS and import them to your local MongoDB instance for the WMArchive server to display them.

- First obtain a Kerberos token and SSH into the `vocms013` node for access to the HDFS:

	```
	kinit # Obtain a Kerberos token
	klist # Check current tokens
	ssh USERNAME@vocms013
	```
-  This is your mounted AFS user directory. Follow the procedure in `./running-wmarchive-remotely` to setup the WMArchive environment here.
- Run the `WMArchive/bin/myspark` script with the `RecordAggregator` on the data you want to aggregate:

	```
	./bin/myspark --hdir=hdfs:///cms/wmarchive/test/avro/2016/06/28 --schema=hdfs:///cms/wmarchive/test/avro/schemas/current.avsc --script=src/python/WMArchive/PySpark/RecordAggregator.py`
	```
	
	The script will store its result in MongoDB and also produce a JSON file with its output.
	
---

- Your can now copy the JSON file to your local machine:

	```
	scp nifische@vocms013:~/WMArchive/RecordAggregator_result.json .
	```

- Start MongoDB on the port used by WMArchive (see `wmarch_config[_local].py`)

	```
	mongod --port 8230 --dbpath ./data/db
	```
	
- Import the sample data to the `performance` database and `daily` collection:
	
	```
	mongoimport --port 8230 --db performance --collection daily RecordAggregator_result.json
	```
- You can at any time open the MongoDB shell to check the contents of the database:

	```
	mongo --port 8230
	> help # to show useful commands
	> use performance # switch to the performance metrics database
	> show collections
	```
	The WMArchive server reads performance data from the `performance` database.
