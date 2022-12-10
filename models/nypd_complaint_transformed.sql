FROM nypd_complaints
SELECT 
  RPT_DT AS report_date,
  CMPLNT_NUM AS complaint_number,
  LAW_CAT_CD  AS law_category,
  KY_CD AS offense_code,
  PREM_TYP_DESC AS premise_description,
  COALESCE(LOC_OF_OCCUR_DESC, 'UNKNOWN') AS location_of_occurance,
  COALESCE(REPLACE(BORO_NM, 'PATROL BORO ', ''), 'UNKNOWN') AS location_borough,
  COALESCE(REPLACE(PATROL_BORO, 'PATROL BORO ', ''), 'UNKNOWN') AS patrol_borough,
  STR_SPLIT(PD_DESC, ',')[1] AS description,
  JURIS_DESC AS jurisdiction_description,
  STATION_NAME AS station_address,
  CRM_ATPT_CPTD_CD AS attempt_completed,
  COALESCE(VIC_SEX,'U') AS victim_sex,
  COALESCE(VIC_RACE,'UNKNOWN') AS victim_race,
  CASE WHEN VIC_AGE_GROUP[3] ILIKE '%-%' OR VIC_AGE_GROUP ILIKE '%+%' OR VIC_AGE_GROUP ILIKE '%<%' 
    THEN VIC_AGE_GROUP 
    ELSE 'UNKNOWN' 
    END AS victim_age_group,
  COALESCE(SUSP_SEX,'U') AS suspect_sex,
  COALESCE(SUSP_RACE,'UNKNOWN') AS suspect_race,
  CASE WHEN SUSP_AGE_GROUP[3] ILIKE '%-%' OR SUSP_AGE_GROUP ILIKE '%+%' OR SUSP_AGE_GROUP ILIKE '%<%' 
    THEN SUSP_AGE_GROUP 
    ELSE 'UNKNOWN' 
    END AS suspect_age_group, 
  RPT_DT - CMPLNT_FR_DT AS reporting_latency
GROUP BY ALL
