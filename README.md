# front-line-concussion-monitoring-system-using-AWS-IoT-and-serverless-data-lakes


A simple, practical, and affordable system for measuring head trauma within the sports environment, subject to the absence of trained medical personnel made using Amazon Kinesis Data Streams, Kinesis Data Analytics, Kinesis Data Firehose, and AWS Lambda




![image](https://user-images.githubusercontent.com/48589838/77403006-8d0b2180-6dd5-11ea-8e4e-54978db892b1.png)



For the purposes of our demonstration, we chose to use heart rate monitoring sensors rather than helmet sensors because they are significantly easier to acquire. Both types of sensors are very similar in how they transmit data. They are also very similar in terms of how they are integrated into a data lake solution.


#### AWS Greengrass set up with a Raspberry Pi 3 to stream heart rate data into the cloud.
#### Data is ingested via Amazon Kinesis Data Streams, and raw data is stored in an Amazon S3 bucket using Kinesis Data Firehose. Find more details about writing to Kinesis Data Firehose using Kinesis Data Streams.
#### Kinesis Data Analytics averages out the heartbeat-per-minute data during stream data ingestion and passes the average to an AWS Lambda
#### AWS Lambda enriches the heartbeat data by comparing the real-time data with baseline information stored in Amazon DynamoDB.
#### AWS Lambda sends SMS/email alerts via an Amazon SNS topic if the heartbeat rate is greater than 120 BPM, for example.
#### AWS Glue runs an extract, transform, and load (ETL) job. This job transforms the data store in a JSON format to a compressed Apache Parquet columnar format and applies that transformed partition for faster query processing. AWS Glue is a fully managed ETL service for crawling data stored in an Amazon S3 bucket and building a metadata catalog.
#### Amazon Athena is used for ad hoc query analysis on the data that is processed by AWS Glue. This data is also available for machine learning processing using predictive analysis to reduce heart disease risk.
#### Amazon QuickSight is a fully managed visualization tool. It uses Amazon Athena as a data source and depicts visual line and pie charts to show the heart rate data in a visual dashboard.


### Remote sensors and IoT devices
You can use commercially available heart rate monitors to collect electrocardiography (ECG) information such as heart rate. The monitor is strapped around the chest area with the sensor placed over the sternum for better accuracy. The monitor measures the heart rate and sends the data over Bluetooth Low Energy (BLE) to a Raspberry Pi 3. The following figure depicts the device-side architecture for our demonstration.


![image](https://user-images.githubusercontent.com/48589838/77403141-ca6faf00-6dd5-11ea-8ff5-bc32e9c45ad1.png)


### Set up AWS Greengrass core software on Raspberry Pi 3



![image](https://user-images.githubusercontent.com/48589838/77403220-eecb8b80-6dd5-11ea-86eb-4b33368de346.png)


### Configure AWS Greengrass and AWS IoT Core


### Simulate heart rate data

### Ingest data using Kinesis and manage alerts with Lambda, DynamoDB, and Amazon SNS


![image](https://user-images.githubusercontent.com/48589838/77403356-25090b00-6dd6-11ea-8033-987de454745a.png)


Create a serverless data lake and explore data using AWS Glue, Amazon Athena, and Amazon QuickSight


you can store heart rate data in an Amazon S3 bucket using Kinesis Data Streams. However, storing data in a repository is not enough. You also need to be able to catalog and store the associated metadata related to your repository so that you can extract the meaningful pieces for analytics.

For a serverless data lake, you can use AWS Glue, which is a fully managed data catalog and ETL (extract, transform, and load) service. AWS Glue simplifies and automates the difficult and time-consuming tasks of data discovery, conversion, and job scheduling. As you get your AWS Glue Data Catalog data partitioned and compressed for optimal performance, you can use Amazon Athena for the direct query to S3 data. You can then visualize the data using Amazon QuickSight.



![image](https://user-images.githubusercontent.com/48589838/77403552-5f72a800-6dd6-11ea-8fc5-e49c10235b06.png)


## AWS Glue features
AWS Glue is a fully managed data catalog and ETL (extract, transform, and load) service that simplifies and automates the difficult and time-consuming tasks of data discovery, conversion, and job scheduling. AWS Glue crawls your data sources and constructs a data catalog using pre-built classifiers for popular data formats and data types, including CSV, Apache Parquet, JSON, and more.

## Amazon S3 data lake
AWS Glue is an essential component of an Amazon S3 data lake, providing the data catalog and transformation services for modern data analytics.



![image](https://user-images.githubusercontent.com/48589838/77404067-27b83000-6dd7-11ea-824b-0cef3cb7fc8a.png)




When you choose Finish, AWS Glue generates a Python script. This script processes your data and stores it in a columnar format in the destination S3 bucket specified in the job configuration.

If you choose Run Job, it takes time to complete depending on the amount of data and data processing units (DPUs) configured. By default, a job is configured with 10 DPUs, which can be increased. A single DPU provides processing capacity that consists of 4 vCPUs of compute and 16 GB of memory.

After the job is complete, inspect your destination S3 bucket, and you will find that your data is now in columnar Parquet format.


You can use this new table for direct queries to reduce costs and to increase the query performance of this demonstration.

## Analyze the data with Amazon Athena
Amazon Athena is an interactive query service that makes it easy to analyze data in Amazon S3 using standard SQL. Athena is capable of querying CSV data. However, the Parquet file format significantly reduces the time and cost of querying the data. 


Because AWS Glue is integrated with Athena, you will find in the Athena console an AWS Glue catalog already available with the table catalog. Fetch 10 rows from Athena in a new Parquet table like you did for the JSON data table in the previous steps.


![image](https://user-images.githubusercontent.com/48589838/77406605-ed509200-6dda-11ea-99d9-8eabb716201b.png)



As the following image shows, we fetched the first 10 rows of heartbeat data from a Parquet format table. This same Athena query scanned only 4.99 KB of data compared to 205 KB of data that was scanned in a raw format. Also, there was a significant improvement in query performance in terms of run time


## Visualize data in Amazon QuickSight

The first step in Amazon QuickSight is to create a new Amazon Athena data source. Choose the heartbeat database created in AWS Glue, and then choose the table that was created by the AWS Glue crawler.



![image](https://user-images.githubusercontent.com/48589838/77406696-0f4a1480-6ddb-11ea-94f5-fd642ef2d0a8.png)



###### Reference Materials:https://aws.amazon.com/blogs/big-data/how-to-build-a-front-line-concussion-monitoring-system-using-aws-iot-and-serverless-data-lakes-part-1/
###### https://aws.amazon.com/blogs/big-data/how-to-build-a-front-line-concussion-monitoring-system-using-aws-iot-and-serverless-data-lakes-part-2/
###### https://aws.amazon.com/blogs/big-data/build-a-data-lake-foundation-with-aws-glue-and-amazon-s3/
###### https://aws.amazon.com/blogs/big-data/analyzing-data-in-s3-using-amazon-athena/
###### https://docs.aws.amazon.com/glue/latest/dg/console-custom-created.html
###### https://docs.aws.amazon.com/quicksight/latest/user/welcome.html

