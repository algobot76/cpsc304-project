# Update queries

- [Update queries](#update-queries)
  - [Add a new entry into `Property` table](#add-a-new-entry-into-property-table)
    - [SQL Statements](#sql-statements)
    - [Result](#result)
  - [Add a new entry into `ForRent` table](#add-a-new-entry-into-forrent-table)
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

property_id|address|postal_code|property_type|date_built|sq_ft|date_added|num_beds|num_baths|realtor_id
|---|--------------------------|---------|-----------|------------|------|------------|---|---|-------|
| 1 | 1A-139 Drake Street      | V6Z 2T7 | Apt/Condo | 1996-04-21 | 1100 | 2016-05-01 | 2 | 2 | 12345 |
| 2 | 409-2101 Mcmullen Avenue | V6L 3B4 | Apt/Condo | 1974-09-12 | 1316 | 2013-12-13 | 2 | 2 | 12345 |
| 3 | 2036 Franklin Street     | V5L 1K3 | Townhouse | 2018-05-29 | 1468 | 2014-08-29 | 3 | 3 | 12346 |
| 4 | 4928 Blenheim Street     | V6N 1N3 | House     | 2016-12-10 | 4132 | 2018-01-03 | 6 | 6 | 12347 |
| 5 | 2034 Franklin Street     | V5L 1K3 | Townhouse | 1998-07-31 | 1445 | 2015-07-29 | 3 | 3 | 12347 |

After

property_id|address|postal_code|property_type|date_built|sq_ft|date_added|num_beds|num_baths|realtor_id
|---|--------------------------|---------|-----------|------------|------|------------|---|---|-------|
| 1 | 1A-139 Drake Street      | V6Z 2T7 | Apt/Condo | 1996-04-21 | 1100 | 2016-05-01 | 2 | 2 | 12345 |
| 2 | 409-2101 Mcmullen Avenue | V6L 3B4 | Apt/Condo | 1974-09-12 | 1316 | 2013-12-13 | 2 | 2 | 12345 |
| 3 | 2036 Franklin Street     | V5L 1K3 | Townhouse | 2018-05-29 | 1468 | 2014-08-29 | 3 | 3 | 12346 |
| 4 | 4928 Blenheim Street     | V6N 1N3 | House     | 2016-12-10 | 4132 | 2018-01-03 | 6 | 6 | 12347 |
| 5 | 2034 Franklin Street     | V5L 1K3 | Townhouse | 1998-07-31 | 1445 | 2015-07-29 | 3 | 3 | 12347 |
| 6 | 305-135 Antibes Drive    | M2R 2Z1 | Apt/Condo | 1990-07-29 | 999  | 2014-03-01 | 1 | 1 | 12345 |

## Add a new entry into `ForRent` table

### SQL Statements

```sql
INSERT INTO ForRent
VALUES ('6', 1250);
```

### Result

Before

|property_id|rent|
|---|------|
| 1 | 3000 |
| 2 | 4000 |
| 3 | 5000 |

After

|property_id|rent|
|---|------|
| 1 | 3000 |
| 2 | 4000 |
| 3 | 5000 |
| 6 | 1250 |

## Add a new entry into `Customer` table

### SQL Statements

```sql
INSERT INTO Customer
VALUES ('90560292222', 'Mercy@armyspy.com', 'Mary.Happy', '2');
```
Before

|phone       | email                 |name                 | customer_id|
|------------|-----------------------|---------------------|---|
| 5195850524 | Marcy@armyspy.com     | Marcy R. Plascencia | 1 |
| 9056029275 | Wilson@teleworm.us    | Stephanie D. Wilson | 2 |
| 7809200082 | Watts@teleworm.us     | Molly B. Watts      | 3 |
| 2503564541 | YongHsiung@dayrep.com | Yong Hsiung         | 4 |

After

|phone        | email                 |name                 |customer_id  |
|-------------|-----------------------|---------------------|---|
| 5195850524  | Marcy@armyspy.com     | Marcy R. Plascencia | 1 |
| 9056029275  | Wilson@teleworm.us    | Stephanie D. Wilson | 2 |
| 7809200082  | Watts@teleworm.us     | Molly B. Watts      | 3 |
| 2503564541  | YongHsiung@dayrep.com | Yong Hsiung         | 4 |
| 90560292222 | Mercy@armyspy.com     | Mary.Happy          | 5 |


## Add a new entry into `Sold` table

### SQL Statements

```sql
INSERT INTO Sold
VALUES('1', '23456800','2012-03-07','4');
```

Before

|property_id |final_price            |date_sold            | customer_id|
|------------|-----------------------|---------------------|---|

After

| property_id  |    final_price      |         date_sold   |  customer_id |
|---|----------|------------|---|
| 1 | 23456800 | 2012-03-07 | 4 |


## Add a new entry into `ForSale` table

### SQL Statements

```sql
INSERT INTO ForSale
VALUES('3','4500000');
```

Before

|property_id   | price    |
|---|---------|
| 1 | 2000000 |
| 4 | 3400000 |


After

|  property_id |  price       |
|---|---------|
| 1 | 2000000 |
| 3 | 4500000 |
| 4 | 3400000 |


## Add a new entry into `ForSale` table

### SQL Statements

```sql
INSERT INTO Feature
VALUES('half furnished', 'The whole house/apt\r half furnished', '2');
```

Before


| feature_name        | description                | property_id|
|---------------------|----------------------------|---|
| fully_furnished     | The_whorehouse/aptfurnished| 4  |
| parking             | street parking             | 2 |
| partially_furnished | kitchen_has_been_furnished | 1 |

After


| feature_name        | description                |property_id  |
|---------------------|----------------------------|---|
| fully_furnished     | The_whorehouse/apt         | 4 |
| half furnished      | The whole house/apt        | 3 |
| parking             | street parking             | 2 |
| partially_furnished | kitchen_has_been_furnished | 1 |
