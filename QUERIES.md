# Queries

- [Queries](#queries)
  - [Queries for Updating Tables](#queries-for-updating-tables)
    - [Add entries](#add-entries)
      - [Add a new entry into `Property` table](#add-a-new-entry-into-property-table)
      - [Add a new entry into `ForRent` table](#add-a-new-entry-into-forrent-table)
      - [Add a new entry into `ForSale` table](#add-a-new-entry-into-forsale-table)
      - [Add a new entry into `Sold` table](#add-a-new-entry-into-sold-table)
      - [Add a new entry into `Feature` table](#add-a-new-entry-into-feature-table)
    - [Delete entries](#delete-entries)
      - [Delete an entry from `Property` table](#delete-an-entry-from-property-table)
  - [Division Query](#division-query)
    - [Find the customers who has contacted all the realtors](#find-the-customers-who-has-contacted-all-the-realtors)
  - [Aggregation Query](#aggregation-query)
    - [For each property, find the property of lowest rental price](#for-each-property-find-the-property-of-lowest-rental-price)
  - [Nested Aggregation with Group-by](#nested-aggregation-with-group-by)
    - [Find the highest/lowest average price of `ForSale` properties](#find-the-highestlowest-average-price-of-forsale-properties)
      - [Using `MAX()`](#using-max)
      - [Using `MIN()`](#using-min)

## Queries for Updating Tables

### Add entries

#### Add a new entry into `Property` table

```sql
INSERT INTO PostalCode
VALUES ('M2R 2Z1', 'Toronto', 'ON');

INSERT INTO Property
(property_id, realtor_id, postal_code, property_type, date_built, sq_ft, date_added, num_beds, num_baths, address)
VALUES ('6', '12345', 'M2R 2Z1', 'Apt/Condo', '1990-07-29', 999, '2014-03-01', 1, 1, '305-135 Antibes Drive');
```

#### Add a new entry into `ForRent` table

```sql
INSERT INTO ForRent
VALUES ('6', 1250);
```

#### Add a new entry into `ForSale` table

```sql
INSERT INTO ForSale
VALUES('3','4500000');
```

#### Add a new entry into `Sold` table

```sql
INSERT INTO Sold
VALUES('1', '23456800','2012-03-07','4');
```

#### Add a new entry into `Feature` table

```sql
INSERT INTO Feature
VALUES('half furnished', 'The whole house/apt\r half furnished', '2');
```

### Delete entries

#### Delete an entry from `Property` table

```sql
DELETE FROM Property
WHERE property_id = '3';
```

Any SQL statement that deletes an entry from the `Property` table will also delete the corresponding entry from  the `ForSale`, `ForRent`, `Sold`, or `Rented` table.

## Division Query

### Find the customers who has contacted all the realtors

```sql
SELECT DISTINCT CCR1.customer_id
FROM CustomerContactRealtor CCR1
WHERE NOT EXISTS(
    SELECT CCR2.realtor_id
    FROM CustomerContactRealtor CCR2
    WHERE CCR2.realtor_id NOT IN
          (SELECT CCR3.realtor_id
           FROM CustomerContactRealtor CCR3
           WHERE CCR3.customer_id = CCR1.customer_id)
);
```

## Aggregation Query

### For each property, find the property of lowest rental price

```sql
SELECT property_id MIN(rent)
FROM property P ForRent R
WHERE P.property_id = R.property_id
GROUP BY property_id
```

## Nested Aggregation with Group-by

### Find the highest/lowest average price of `ForSale` properties

#### Using `MAX()`

```sql
SELECT MAX(AvgPrices.avg_price) AS max_avg_price
FROM (SELECT AVG(S.price) AS avg_price
      FROM Property P, ForSale S, PostalCode PC
      WHERE S.property_id = P.property_id AND P.postal_code = PC.postal_code
      GROUP BY PC.province) AS AvgPrices;
```

#### Using `MIN()`

```sql
SELECT MIN(AvgPrices.avg_price) AS min_avg_price
FROM (SELECT AVG(S.price) AS avg_price
      FROM Property P, ForSale S, PostalCode PC
      WHERE S.property_id = P.property_id AND P.postal_code = PC.postal_code
      GROUP BY PC.province) AS AvgPrices;
```
