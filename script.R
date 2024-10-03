library(tidyverse)
library(here)

raw_data <- readRDS(here("data", "accidents.rds"))

#weekday (day_of_week) (will group by it for weekend and weekday), time, severity, number of accidents (casualties)

filtered_data <- raw_data %>% 
  select(day_of_week, time, severity, casualties)

weekday <- filtered_data %>% 
  filter(day_of_week %in% c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday"))
  
weekend <- filtered_data %>% 
  filter(day_of_week %in% c("Saturday", "Sunday"))

combined_df <- bind_rows(
  weekday %>% mutate(dataset = "Weekday"),  # Add 'dataset' column to df1
  weekend %>% mutate(dataset = "Weekend")   # Add 'dataset' column to df2
)

ggplot(combined_df, aes(x = time, fill = severity)) +
  geom_density(alpha = 0.6) +
  facet_wrap(~dataset, nrow = 2, ncol = 1) +
  theme_minimal() +
  xlab("Time of Day") +
  ylab("Density") +
  scale_fill_manual(values = c("Fatal" = "#77677b", "Serious" = "#6f8d8c", "Slight" = "#fef39f")) +
  labs(title = "Number of accidents throughout the day", 
       subtitle = "By day of week and severity")
  

 
   




