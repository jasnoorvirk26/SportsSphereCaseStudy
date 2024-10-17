# SportsSphere Marketing Analysis

## Overview
Welcome to the SportsSphere Marketing Analysis project! SportsSphere, an online retailer specializing in sports gear, is currently facing significant challenges. Despite launching new marketing campaigns, customer engagement and conversion rates have been declining. This project aims to analyze their marketing strategies, identify the underlying issues, and propose actionable solutions to help improve performance.
## The Challenge
SportsSphere is grappling with several key issues:
- **Declining Customer Engagement**: Interactions on the website and with marketing content are decreasing, indicating lower user interest.
- **Falling Conversion Rates**: Fewer website visitors are completing purchases, which is negatively impacting sales performance.
- **High Marketing Costs**: Despite significant spending on marketing, the returns are not aligning with expectations, raising concerns about the efficiency of marketing efforts.
- **Lack of Customer Feedback Insights**: Understanding customer opinions about the products and services is essential for boosting engagement and improving conversion rates, but effective analysis of feedback is lacking.

## Our Goals
### 1. Increase Conversion Rates
- **Objective**: Identify the key factors affecting conversion rates and provide actionable recommendations to improve them.
- **Approach**: We will analyze the conversion funnel to determine where potential customers are dropping off and suggest strategies to streamline the purchasing process.
### 2. Enhance Customer Engagement
- **Objective**: Understand which types of marketing content resonate most with customers to drive higher engagement.
- **Approach**: By evaluating engagement levels across various marketing materials, we’ll develop strategies to enhance customer interaction and retention.

### 3. Improve Customer Feedback Scores
- **Objective**: Analyze customer reviews to uncover recurring themes and actionable insights for product and service improvements.
- **Approach**:  We’ll identify common feedback patterns—both positive and negative—that can guide enhancements in product offerings and customer experience.

# Data Description

This analysis utilizes a comprehensive dataset comprising six distinct tables, each capturing various dimensions of customer interactions, product offerings, and geographical data. The structure of these tables is as follows:

## 1. Customer Journey
The `customer_journey` table monitors customer interactions with products throughout different stages of the sales funnel. This data is essential for understanding customer engagement and optimizing marketing strategies.

### Columns:
- **journey_id**: Unique identifier for each customer journey record.
- **customer_id**: Identifier referencing the customer involved in the journey.
- **product_id**: Identifier for the product being interacted with.
- **visit_date**: Date of the customer’s visit.
- **stage**: Stage of the journey (e.g. "HomePage","ProductPage","Checkout" ).
- **action**: Specific action taken by the customer (e.g.,"view", "purchase" ).
- **duration**: Duration (in seconds) that the customer spent at this stage.

## 2. Engagement Data
The `engagement_data` table captures customer interactions with marketing content, including social media posts and blogs. This information is critical for evaluating content effectiveness and its impact on product engagement.

### Columns:
- **engagement_id**: Unique identifier for each engagement record.
- **content_id**: Identifier for the content viewed or clicked.
- **content_type**: Type of content (e.g., "video", "blogs").
- **likes**: Count of likes received by the content.
- **engagement_date**: Date when the engagement took place.
- **campaign_id**: Identifier for the associated marketing campaign.
- **product_id**: Product linked to the engagement.
- **viewsclickscombined**: Combined metric showing views and clicks for the content.

## 3. Customer Reviews
The `customer_reviews` table contains feedback provided by customers for products they have purchased. This data offers valuable insights into customer satisfaction and highlights areas for product improvement.

### Columns:
- **review_id**: Unique identifier for each review.
- **customer_id**: Identifier for the customer who submitted the review.
- **product_id**: Identifier for the product being reviewed.
- **review_date**: Date when the review was submitted.
- **rating**: Customer rating (1-5 stars).
- **review_text**: Textual content of the customer’s review.

## 4. Customers
The `customers` table maintains demographic and geographic information about customers. This data facilitates customer segmentation based on attributes such as age, gender, and location, enhancing targeted marketing efforts and personalized experiences.

### Columns:
- **customer_id**: Unique identifier for each customer.
- **names**: Full name of the customer.
- **email**: Email address of the customer.
- **age**: Age of the customer.
- **gender**: Gender of the customer.
- **geography_id**: Identifier referencing the customer's location in the geography table.

## 5. Geography
The `geography` table associates customer locations with cities and countries, enabling geographic segmentation and analysis of regional customer behavior trends.

### Columns:
- **geography_id**: Unique identifier for each geography record.
- **city**: Name of the city where the customer resides.
- **country**: Name of the country where the customer resides.

## 6. Products
The `products` table provides detailed information about the various products offered, including their names, categories, and pricing. This data is essential for analyzing product performance, developing pricing strategies, and understanding customer preferences.

### Columns:
- **product_id**: Unique identifier for each product.
- **product_name**: Name of the product.
- **category**: Product category (e.g., "Electronics", "Clothing").
- **price**: Price of the product.

# Data Cleaning Process

## Customer Details Table
- Joined the customers and geography tables to create a new table, `customer_details`, ensuring all customer data is linked to their geographical information to avoid a complex data model.

## Products Table
- Categorized products based on price range (Low, Medium, High) and created a new table, `products_with_price_category`, to clarify product pricing strategies.
  - **Low:** Price < 80
  - **Medium:** Price between 80 and 200
  - **High:** Price > 200

## Customer Reviews Table
- Cleaned the review text to remove extra spaces from the `review_text` column and created a new table, `cleaned_customer_reviews`, for standardized reviews.

## Engagement Data Table
- Analyzed the `engagement_data` for duplicates and transformed it into `cleaned_engagement_data`, adjusting inconsistencies in content types and extracting views and clicks from the `viewsclickscombined` column.

## Customer Journey Table
- Assessed duplicates and null values in the `duration` column of the `customer_journey` table, creating a new table, `cleaned_customer_journey`, to maintain accurate journey data.

##Measures in Power BI
###Various measures have been created in Power BI to provide insights into the data:
### 1. Average Rating
- **Description:** Calculates the average rating given by customers for products.
- **Formula:** `AVERAGE(RatingColumn)`

### 2. Clicks
- **Description:** Total number of clicks on promotional content.
- **Formula:** `SUM(ClicksColumn)`

### 3. Conversion Rate
- **Description:** Measures the percentage of visitors who make a purchase after viewing a product.
- **Formula:** `(TotalPurchases / TotalViews) * 100`

### 4. Dropoff Count
- **Description:** Counts the number of users who leave the website, indicating potential areas for improvement.
- **Formula:** `COUNTROWS(DropoffTable)`

### 5. Likes
- **Description:** Total number of likes received by content.
- **Formula:** `SUM(LikesColumn)`

### 6. Total Engagement
- **Description:** Summarizes all forms of user engagement (likes, shares, comments).
- **Formula:** `SUM(LikesColumn) + SUM(CommentsColumn) + SUM(SharesColumn)`

### 7. Normalized Conversion Rate
- **Description:** Adjusts the conversion rate by the number of products to provide a fair comparison across different product offerings.
- **Formula:** `ConversionRate / NoOfProducts`

### 8. Number of Customer Journeys
- **Description:** Counts the distinct customer journeys.
- **Formula:** `DISTINCTCOUNT(CustomerJourneyID)`

### 9. Number of Customer Reviews
- **Description:** Total count of reviews provided by customers for products.
- **Formula:** `COUNT(ReviewColumn)`

### 10. Number of Products
- **Description:** Counts the total number of distinct products available in the dataset.
- **Formula:** `DISTINCTCOUNT(ProductID)`

### 11. Views
- **Description:** Total number of views for content, providing insight into overall interest.
- **Formula:** `SUM(ViewsColumn)`

## Power BI Dashboard Creation

I created a comprehensive dashboard using **Power BI** that provides an overview of key metrics, including conversions, engagements, and ratings. The dashboard includes:

- **Overview Page**: 
  - Displays summary metrics for conversions, engagements, and customer ratings.
  
- **Page Navigation**: 
  - Allows users to easily access detailed sections for:
    - **Conversions Details**: In-depth analysis of conversion rates and trends.
    - **Engagement Details**: Insights into customer engagement levels and interactions.
    - **Customer Review Details**: Summarization of customer feedback and satisfaction ratings.

This dashboard serves as a valuable tool for stakeholders to monitor performance metrics, understand customer behaviors, and drive strategic improvements effectively.

# Insights and Recommendations

## Conversion Rates

### Insights:
1. **Overall Performance:** 
   - The overall conversion rate is recorded at **9.6%**, with notable fluctuations across different months.

2. **Monthly Fluctuations:** 
   - **October** experienced the lowest conversion rate at **6.1%**, indicating a need for reassessing marketing strategies or promotions during this period. Conversely, **December** saw a rebound to **11.4%**, likely due to holiday marketing efforts.
   
   ![Conversion Rate by Month](https://raw.githubusercontent.com/jasnoorvirk26/SportsSphereCaseStudy/main/conversion_rate_by_month.png)

3. **High-Value Products:** 
   - Products priced above **$200** exhibited a significantly lower conversion rate of **1.03%**, suggesting that higher-priced items may require different marketing approaches.
   
![Conversion Rate by Product Category](https://raw.githubusercontent.com/jasnoorvirk26/SportsSphereCaseStudy/main/conversion_rate_by_stage.png?raw=true)
  


4. **Checkout Drop-offs:** 
   - A substantial **96.32%** of drop-offs occur during the checkout stage, highlighting a critical area for improvement.
     
![Conversion Rate by Stage](https://raw.githubusercontent.com/jasnoorvirk26/SportsSphereCaseStudy/main/drop_offs_by_stages.png?raw=true)
   

### Recommendations:
1. **Revamp October Marketing Strategies:** 
   - Analyze and adjust marketing campaigns for October to attract customers, possibly through targeted promotions or discounts.

2. **Capitalize on Seasonal Trends:** 
   - Increase marketing efforts for products with historically high conversions during peak seasons, such as promoting winter sports equipment in December and January.

3. **Optimize Checkout Process:** 
   - Investigate and simplify the checkout flow, possibly implementing guest checkout options and clearer shipping cost communications to reduce cart abandonment.

4. **Target High-Value Customers:** 
   - Develop targeted promotions for high-priced items, including exclusive offers or bundled products that enhance perceived value.
     
## Customer Engagement

### Insights:
- **Declining Views**: There has been a year-long decline in customer engagement, with views generally decreasing, except for a peak in April.
     ![Views by Month](https://raw.githubusercontent.com/jasnoorvirk26/SportsSphereCaseStudy/main/views_by_month.png?raw=true)
  
- **Click-Through Rate**: The click-through rate is at 19.57%, suggesting that engaged users are interacting effectively with certain content despite lower overall clicks and likes.
   ![Views,Clicks,Likes](https://raw.githubusercontent.com/jasnoorvirk26/SportsSphereCaseStudy/main/views_clicks_likes.png?raw=true)
  
 
- **Content Type Performance**: Blogs drove the most views from March to June, while video content peaked in January and February. Engagement on newsletters and videos is notably lower than that on blogs and social media.
  
  ![Views by Content Type](https://raw.githubusercontent.com/jasnoorvirk26/SportsSphereCaseStudy/main/views_by_content_type.png?raw=true)

### Recommendations:
- **Enhance Content Quality**: Focus on creating engaging and compelling content across all formats to combat declining views. Utilize storytelling and visual elements to boost interaction.
- **Strengthen Calls to Action**: Improve CTAs within content to encourage higher interaction rates. Effective CTAs can motivate users to click, like, or share.
- **Leverage High-Performing Content Types**: Increase the frequency of blog posts during peak months and replicate successful topics from the past.
- **Experiment with Formats**: Refresh video and newsletter formats to make them more appealing, possibly incorporating shorter videos and visually engaging newsletters.

## 3. Customer Reviews and Ratings

### Insights:
- **Rating Stability**: Customer ratings have averaged around 3.7, falling short of the target rating of 4.0.
- Positive sentiment prevails with 840 positive reviews, but there are 226 negative reviews indicating areas for improvement.
  
![Reviews by Sentiment Category](https://raw.githubusercontent.com/jasnoorvirk26/SportsSphereCaseStudy/main/sentiment_category.png?raw=true)

- **Common Concerns**: Mixed sentiments are common, with feedback pointing to issues like perceived value for money and unclear instructions.
  ![Reviews in Mixed Sentiments Count By Price Category](https://raw.githubusercontent.com/jasnoorvirk26/SportsSphereCaseStudy/main/mixed_sentiments.png?raw=true)

### Recommendations:
- **Target Improvement Initiatives**: Identify specific issues in products rated below 3.7 and implement necessary improvements to enhance customer satisfaction.
- **Enhance Instruction Clarity**: Revise product instructions to improve clarity, potentially using visual aids or video tutorials.
- **Engage with Customers**: Reach out to customers who left mixed or negative reviews to understand their concerns better and show that their feedback is valued.
- **Communicate Value Proposition**: Clearly communicate product value in marketing materials to address concerns about being "not worth the money."

###Conclusion
-This analysis provides a detailed overview of SportsSphere's current marketing landscape, highlighting challenges and offering actionable solutions. Implementing these strategies can help drive higher customer engagement, improve conversion rates, and ultimately boost sales performance, enabling SportsSphere to regain its competitive edge in the market.
