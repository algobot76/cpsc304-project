# Update queries

- [Update queries](#update-queries)
  - [Add a new entry into `Property` table](#add-a-new-entry-into-property-table)
    - [SQL Statements](#sql-statements)
    - [Result](#result)

## Add a new entry into `Property` table

### SQL Statements


```sql
INSERT INTO PostalCode
VALUES ('M2R 2Z1', 'Toronto', 'ON');

INSERT INTO Property
(property_id, realtor_id, postal_code, property_type, date_built, sq_ft, date_added, num_beds, num_baths, address)
VALUES ('6', '12345', 'M2R 2Z1', 'Apt/Condo', '1990-07-29', 999, '2014-03-01', 1, 1, '305-135 Antibes Drive');
```

### Result

Before

|   |                          |         |           |            |      |            |   |   |       |
|---|--------------------------|---------|-----------|------------|------|------------|---|---|-------|
| 1 | 1A-139 Drake Street      | V6Z 2T7 | Apt/Condo | 1996-04-21 | 1100 | 2016-05-01 | 2 | 2 | 12345 |
| 2 | 409-2101 Mcmullen Avenue | V6L 3B4 | Apt/Condo | 1974-09-12 | 1316 | 2013-12-13 | 2 | 2 | 12345 |
| 3 | 2036 Franklin Street     | V5L 1K3 | Townhouse | 2018-05-29 | 1468 | 2014-08-29 | 3 | 3 | 12346 |
| 4 | 4928 Blenheim Street     | V6N 1N3 | House     | 2016-12-10 | 4132 | 2018-01-03 | 6 | 6 | 12347 |
| 5 | 2034 Franklin Street     | V5L 1K3 | Townhouse | 1998-07-31 | 1445 | 2015-07-29 | 3 | 3 | 12347 |

After

|   |                          |         |           |            |      |            |   |   |       |
|---|--------------------------|---------|-----------|------------|------|------------|---|---|-------|
| 1 | 1A-139 Drake Street      | V6Z 2T7 | Apt/Condo | 1996-04-21 | 1100 | 2016-05-01 | 2 | 2 | 12345 |
| 2 | 409-2101 Mcmullen Avenue | V6L 3B4 | Apt/Condo | 1974-09-12 | 1316 | 2013-12-13 | 2 | 2 | 12345 |
| 3 | 2036 Franklin Street     | V5L 1K3 | Townhouse | 2018-05-29 | 1468 | 2014-08-29 | 3 | 3 | 12346 |
| 4 | 4928 Blenheim Street     | V6N 1N3 | House     | 2016-12-10 | 4132 | 2018-01-03 | 6 | 6 | 12347 |
| 5 | 2034 Franklin Street     | V5L 1K3 | Townhouse | 1998-07-31 | 1445 | 2015-07-29 | 3 | 3 | 12347 |
| 6 | 305-135 Antibes Drive    | M2R 2Z1 | Apt/Condo | 1990-07-29 | 999  | 2014-03-01 | 1 | 1 | 12345 |
