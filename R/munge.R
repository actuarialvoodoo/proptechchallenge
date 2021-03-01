
library(readxl)
library(dplyr)
library(lubridate)

electric <- read_excel('ConEd_Electric.xlsx') %>%
    mutate(date_time = mdy_hms(date_time, tz = "EST"))

steam <- read_excel('ConEd_Steam.xlsx') %>%
    mutate(date_time = mdy_hms(date_time, tz = "EST"))

occupancy <- read_excel("Occupancy.xlsx")

usage_sheet_names <- excel_sheets('Tenant_Usage.xlsx')
names(usage_sheet_names) <- stringr::str_remove(usage_sheet_names, "^Interval Data ")

usage_raw <- purrr::map(usage_sheet_names, ~ read_excel('Tenant_Usage.xlsx', sheet = .x))

meter_info <- usage_raw[[1]]
usage <- bind_rows(usage_raw[-1]) %>% 
    mutate(date_time = mdy_hms(date_time, tz = "EST"))



