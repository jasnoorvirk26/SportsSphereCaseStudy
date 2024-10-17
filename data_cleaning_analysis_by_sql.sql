-- Switch to the appropriate database
USE SportSphere_CustomerInsights;

-- Fetch the first 2 rows from customer_journey table for a preview
SELECT TOP 2 * 
FROM customer_journey;

-- Fetch the first 2 rows from customer_reviews table for a preview
SELECT Top 2 * 
FROM customer_reviews;

-- Fetch the first 2 rows from engagement_data table for a preview
SELECT TOP 2 * 
FROM engagement_data;

-- Fetch the first 2 rows from products table for a preview
SELECT TOP 2 * 
FROM products;

-- Fetch the first 2 rows from customers table for a preview
SELECT TOP 2 * 
FROM customers;

-- --------------------- Customers Table Analysis -------------------------
-- Fetch distinct values for the gender field to understand customer demographics
SELECT DISTINCT gender
FROM customers;

-- Get the minimum and maximum age values to analyze customer age range
SELECT MIN(age) AS min_age, MAX(age) AS max_age
FROM customers;

-- ----------------------- Geography Data ------------------------
-- Fetch all geography records to assess geographical distribution of customers
SELECT * 
FROM [geography];

-- Get distinct country names from geography table for regional analysis
SELECT DISTINCT country
FROM geography;

-- Get distinct city names from geography table for urban segmentation
SELECT DISTINCT city
FROM geography;

-- ------------------------ Join Customers and Geography Tables ------------------------
-- Creating a new table to combine customer and geography data based on geography_id

CREATE TABLE customer_details (
    customer_id TINYINT NOT NULL,         -- Unique identifier for each customer
    customer_name NVARCHAR(50) NOT NULL,  -- Customer's name
    email NVARCHAR(50) NULL,               -- Customer's email, can be NULL
    gender NVARCHAR(50) NULL,              -- Customer's gender, can be NULL
    age TINYINT NOT NULL,                   -- Customer's age
    country NVARCHAR(50) NOT NULL,         -- Customer's country
    city NVARCHAR(50) NOT NULL,            -- Customer's city
    PRIMARY KEY (customer_id)              -- Primary key constraint on customer_id
);

-- Insert data into customer_details by joining customers and geography tables
INSERT INTO customer_details
SELECT 
    c.customer_id,  
    c.customer_name, 
    c.email,  
    c.gender,  
    age,
    g.country,  
    g.city 
FROM
    dbo.customers AS c  
LEFT JOIN
    dbo.geography AS g  
ON 
    c.geography_id = g.geography_id;

-- Preview the new customer_details table
SELECT *
FROM customer_details;

-- ------------------------ Products Table Analysis ------------------------
-- Fetch all records from products table for product insights
SELECT *
FROM products;

-- Get distinct product names to understand the product assortment
SELECT DISTINCT product_name
FROM products;

-- Get distinct product categories to analyze product segmentation
SELECT DISTINCT category
FROM products;

-- Fetch minimum and maximum price values for products to analyze price range
SELECT MIN(price) AS min_price, MAX(price) AS max_price
FROM products;

-- Categorize products based on their price range for better pricing strategy
SELECT product_id,
       product_name,
       category,
       price,
       CASE 
           WHEN price < 80 THEN 'Low'
           WHEN price BETWEEN 80 AND 200 THEN 'Medium'
           ELSE 'High'
       END AS price_category
FROM products;

-- Creating a new table to categorize products by price range
CREATE TABLE products_with_price_category (
    product_id TINYINT NOT NULL,           -- Unique identifier for each product
    product_name NVARCHAR(50) NOT NULL,    -- Product's name
    category NVARCHAR(50) NOT NULL,        -- Product's category
    price FLOAT NULL,                       -- Product's price, can be NULL
    price_category NVARCHAR(20) NOT NULL,  -- Categorized price range
    PRIMARY KEY (product_id)                -- Primary key constraint on product_id
);

-- Insert categorized product data into the new table
INSERT INTO products_with_price_category
SELECT product_id,
       product_name,
       category,
       price,
       CASE 
           WHEN price < 80 THEN 'Low'
           WHEN price BETWEEN 80 AND 200 THEN 'Medium'
           ELSE 'High'
       END AS price_category
FROM products;

-- Preview the new products_with_price_category table
SELECT *
FROM products_with_price_category;

-- --------------------- Customer Reviews Table ------------------------
-- Fetch all customer reviews to analyze customer feedback
SELECT *
FROM customer_reviews;

-- Check for duplicate records in customer_reviews to ensure data quality
WITH cte AS
(
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY customer_id, product_id, review_date, rating, review_text ORDER BY review_id) AS rn
    FROM customer_reviews
)
SELECT * 
FROM cte 
WHERE rn > 1;  -- Identify duplicates

---no duplicates found

-- Clean review text by trimming spaces and replacing double spaces for consistency
SELECT review_id,
       customer_id,
       product_id,
       review_date,
       rating,
       RTRIM(LTRIM(REPLACE(review_text, '  ', ' '))) AS review_text
FROM customer_reviews;

-- Create a cleaned table for customer reviews to ensure data integrity
CREATE TABLE cleaned_customer_reviews (
    review_id SMALLINT NOT NULL,            -- Unique identifier for each review
    customer_id TINYINT NOT NULL,           -- Foreign key referencing customer_id
    product_id TINYINT NOT NULL,            -- Foreign key referencing product_id
    review_date DATE NOT NULL,              -- Date of the review
    rating TINYINT NOT NULL,                -- Rating given by the customer
    review_text NVARCHAR(100) NOT NULL,    -- Cleaned review text
    PRIMARY KEY (review_id),                -- Primary key constraint on review_id
    FOREIGN KEY (customer_id) REFERENCES customer_details(customer_id),  -- Foreign key to customers
    FOREIGN KEY (product_id) REFERENCES products_with_price_category(product_id)  -- Foreign key to products
);

-- Insert cleaned review data into the new table
INSERT INTO cleaned_customer_reviews(review_id, customer_id, product_id, review_date, rating, review_text)
SELECT review_id,
       customer_id,
       product_id,
       review_date,
       rating,
       RTRIM(LTRIM(REPLACE(review_text, '  ', ' '))) AS review_text
FROM customer_reviews;

-- Preview the cleaned_customer_reviews table
SELECT *
FROM cleaned_customer_reviews;



-- ------------------------ Engagement Data Analysis ------------------------
-- Check for duplicates in engagement_data to ensure quality
WITH cte AS
(
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY content_id, engagement_date, campaign_id, product_id ORDER BY engagement_id) AS rn
    FROM engagement_data
)
SELECT * 
FROM cte 
WHERE rn > 1;  -- Identify duplicates
--no duplicates found

-- Fetch all engagement data for further analysis
SELECT * 
FROM engagement_data;

-- Get distinct content types from engagement_data for classification
SELECT DISTINCT content_type
FROM engagement_data;

-- Clean and transform engagement data: adjust content type and extract views and clicks
CREATE TABLE cleaned_engagement_data (
    engagement_id SMALLINT NOT NULL,          -- Unique identifier for each engagement record
    content_id TINYINT NOT NULL,              -- Foreign key referencing content_id
    campaign_id TINYINT NOT NULL,             -- Foreign key referencing campaign_id
    product_id TINYINT NOT NULL,              -- Foreign key referencing product_id
    content_type NVARCHAR(50) NOT NULL,      -- Cleaned content type
    views SMALLINT NOT NULL,                   -- Number of views
    clicks SMALLINT NOT NULL,                  -- Number of clicks
    likes SMALLINT NOT NULL,                   -- Number of likes
    engagement_date DATE NOT NULL,            -- Date of engagement
    PRIMARY KEY (engagement_id),              -- Primary key constraint on engagement_id
    FOREIGN KEY (product_id) REFERENCES products_with_price_category(product_id)  -- Foreign key to products
);

-- Insert cleaned engagement data into the new table
INSERT INTO cleaned_engagement_data
SELECT engagement_id,
       content_id,
       campaign_id,
       product_id,
       UPPER(REPLACE(content_type, 'Socialmedia', 'SOCIAL MEDIA')) AS content_type,
       LEFT(views_clicks_combined, CHARINDEX('-', views_clicks_combined)-1) AS [views],
       RIGHT(views_clicks_combined, LEN(views_clicks_combined)-CHARINDEX('-', views_clicks_combined)) AS clicks,
       likes,
       engagement_date
FROM engagement_data;

-- Preview the cleaned_engagement_data table
SELECT * 
FROM cleaned_engagement_data;

-- ------------------------ Customer Journey Table ------------------------
-- Fetch all records from customer_journey table for analysis
SELECT  *
FROM customer_journey
ORDER BY customer_id;

-- Get distinct stages in the customer journey to identify key phases
SELECT DISTINCT stage
FROM customer_journey;

-- Get distinct actions taken during the customer journey for behavior analysis
SELECT DISTINCT [action]
FROM customer_journey;

-- Find records with null duration values for data quality assessment
SELECT *
FROM customer_journey 
WHERE duration IS NULL;

-- Check for duplicates in customer_journey data based on key fields to maintain data integrity
WITH cte_duplicates AS (
    SELECT journey_id,
           customer_id,
           product_id,
           visit_date,
           stage,
           [action],
           duration,
           ROW_NUMBER() OVER (PARTITION BY customer_id, product_id, visit_date, UPPER(stage), [action] ORDER BY journey_id) AS rn
    FROM customer_journey
)
SELECT *
FROM cte_duplicates
WHERE rn > 1;  -- Identify duplicates

-- Analyzing and fixing duplicate entries in customer_journey by reviewing specific records
SELECT *
FROM customer_journey
WHERE journey_id IN (3930, 2511, 3256)
ORDER BY journey_id;

-- Creating a cleaned customer journey table to store accurate journey data
CREATE TABLE cleaned_customer_journey (
    journey_id SMALLINT NOT NULL,             -- Unique identifier for each journey record
    customer_id TINYINT NOT NULL,             -- Foreign key referencing customer_id
    product_id TINYINT NOT NULL,              -- Foreign key referencing product_id
    visit_date DATE NOT NULL,                 -- Date of the visit
    stage NVARCHAR(50) NOT NULL,              -- Stage in the customer journey
    action NVARCHAR(50) NOT NULL,             -- Action taken by the customer
    duration INT NOT NULL,                     -- Duration of the action
    PRIMARY KEY (journey_id),                 -- Primary key constraint on journey_id
    FOREIGN KEY (customer_id) REFERENCES customer_details(customer_id),  -- Foreign key to customers
    FOREIGN KEY (product_id) REFERENCES products_with_price_category(product_id)  -- Foreign key to products
);

-- Insert cleaned customer journey data into the new table
INSERT INTO customer_journey_data
SELECT journey_id,
       customer_id,
       product_id,
       visit_date,
       UPPER(stage) as stage,
       [action],
       COALESCE(duration, avg_duration) AS duration
FROM
(
    SELECT journey_id,
           customer_id,
           product_id,
           visit_date,
           stage,
           [action],
           duration,
           AVG(duration) OVER (PARTITION BY visit_date) AS avg_duration,
           ROW_NUMBER() OVER (PARTITION BY customer_id, product_id, visit_date, UPPER(stage), [action] ORDER BY journey_id) AS rn
    FROM customer_journey
) AS sq
WHERE rn = 1;

-- Preview the cleaned_customer_journey table
SELECT *
FROM customer_journey_data;


----Number of Drop-offs in each stage
SELECT stage,count(customer_id) as dropoff_count
FROM customer_journey_data
where action='Drop-off'
group by stage;
