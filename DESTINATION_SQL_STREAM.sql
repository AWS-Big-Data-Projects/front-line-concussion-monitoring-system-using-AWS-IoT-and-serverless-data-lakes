“CREATE OR REPLACE STREAM "DESTINATION_SQL_STREAM" (
                                   VALUEROWTIME TIMESTAMP,
                                   ID INTEGER, 
                                   COLVALUE INTEGER);
CREATE OR REPLACE PUMP "STREAM_PUMP" AS 
  INSERT INTO "DESTINATION_SQL_STREAM" 
SELECT STREAM ROWTIME,
              ID,
              AVG("Value") AS HEARTRATE
FROM     "SOURCE_SQL_STREAM_001"
GROUP BY ID, 
         STEP("SOURCE_SQL_STREAM_001".ROWTIME BY INTERVAL '60' SECOND) HAVING AVG("Value") > 120 OR AVG("Value") < 40;”
         
