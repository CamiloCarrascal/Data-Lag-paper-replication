*-------------------------------------------------------*
*                        GII 2025                       *
*-------------------------------------------------------*

cls
clear all

import excel ///
    "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Tabla_Final_2025.xlsx", ///
    sheet("Sheet1") firstrow clear

ds ECONOMY_NAME, not
local allvars `r(varlist)'

egen promedio_anio = rowmean(`allvars')

local varlist_in ""
foreach v of varlist `allvars' {
    if strpos("`v'", "IN") > 0 {
        local varlist_in "`varlist_in' `v'"
    }
}

if wordcount("`varlist_in'") > 0 {
    egen promedio_IN_2025 = rowmean(`varlist_in')
}
else {
    display "No se encontraron variables que contengan 'IN' en su nombre."
}

local varlist_out ""
foreach v of varlist `allvars' {
    if strpos("`v'", "OUT") > 0 {
        local varlist_out "`varlist_out' `v'"
    }
}

if wordcount("`varlist_out'") > 0 {
    egen promedio_OUT_2025 = rowmean(`varlist_out')
}
else {
    display "No se encontraron variables que contengan 'OUT' en su nombre."
}


save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Datos_Parciales_2025.dta", replace

*-------------- Limpieza Base Original ----------------------*

cls
clear all

import excel "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/wipo-pub-2000-2025-tech1.xlsx", sheet("Data") firstrow clear

describe
list in 1/20

keep if NAME == "Global Innovation Index"

keep ISO3 ECONOMY_NAME SCORE RANK

rename SCORE GII_Score
rename RANK GII_Rank

save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/GII_only_2025.dta", replace

*-------------- Merge - Base Final  ----------------------*

cls
clear all

use "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Datos_Parciales_2025.dta", clear

merge 1:1 ECONOMY_NAME using "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/GII_only_2025.dta"

tab _merge
drop _merge

save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_2025.dta", replace

*-------------------------------------------------------*
*                        GII 2024                       *
*-------------------------------------------------------*

cls
clear all

import excel ///
    "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Tabla_Final_2024.xlsx", ///
    sheet("Sheet1") firstrow clear

ds ECONOMY_NAME, not
local allvars `r(varlist)'

egen promedio_anio = rowmean(`allvars')

local varlist_in ""
foreach v of varlist `allvars' {
    if strpos("`v'", "IN") > 0 {
        local varlist_in "`varlist_in' `v'"
    }
}

if wordcount("`varlist_in'") > 0 {
    egen promedio_IN_2024 = rowmean(`varlist_in')
}
else {
    display "No se encontraron variables que contengan 'IN' en su nombre."
}

local varlist_out ""
foreach v of varlist `allvars' {
    if strpos("`v'", "OUT") > 0 {
        local varlist_out "`varlist_out' `v'"
    }
}

if wordcount("`varlist_out'") > 0 {
    egen promedio_OUT_2024 = rowmean(`varlist_out')
}
else {
    display "No se encontraron variables que contengan 'OUT' en su nombre."
}


save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Datos_Parciales_2024.dta", replace

*-------------- Limpieza Base Original ----------------------*

cls
clear all

import excel "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/wipo-pub-2000-2024-tech1.xlsx", sheet("Data") firstrow clear

describe
list in 1/20

keep if NAME == "Global Innovation Index"

keep ISO3 ECONOMY_NAME SCORE RANK

rename SCORE GII_Score
rename RANK GII_Rank

save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/GII_only_2024.dta", replace

*-------------- Merge - Base Final  ----------------------*

cls
clear all

use "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Datos_Parciales_2024.dta", clear

merge 1:1 ECONOMY_NAME using "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/GII_only_2024.dta"

tab _merge
drop _merge

save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_2024.dta", replace


*-------------------------------------------------------*
*                        GII 2023                       *
*-------------------------------------------------------*

cls 
clear all

import excel "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Tabla_Final_2023.xlsx", sheet("Sheet1") firstrow clear

describe

ds ECONOMY_NAME, not
local allvars `r(varlist)'

egen promedio_anio = rowmean(`allvars')

local varlist_in ""
foreach v of varlist `allvars' {
    if strpos("`v'", "IN") > 0 {
        local varlist_in "`varlist_in' `v'"
    }
}

if wordcount("`varlist_in'") > 0 {
    egen promedio_IN_2023 = rowmean(`varlist_in')
}
else {
    display "No se encontraron variables que contengan 'IN' en su nombre."
}

local varlist_out ""
foreach v of varlist `allvars' {
    if strpos("`v'", "OUT") > 0 {
        local varlist_out "`varlist_out' `v'"
    }
}

if wordcount("`varlist_out'") > 0 {
    egen promedio_OUT_2023 = rowmean(`varlist_out')
}
else {
    display "No se encontraron variables que contengan 'OUT' en su nombre."
}


save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Datos_Parciales_2023.dta", replace

*-------------- Limpieza Base Original ----------------------*

cls
clear all

import excel "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/wipo-pub-2000-2023-tech1.xlsx", sheet("Data") firstrow clear

describe
list in 1/20

keep if NAME == "Global Innovation Index"

keep ISO3 ECONOMY_NAME SCORE RANK

rename SCORE GII_Score
rename RANK GII_Rank

save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/GII_only_2023.dta", replace

*-------------- Merge - Base Final  ----------------------*

cls
clear all

use "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Datos_Parciales_2023.dta", clear

merge 1:1 ECONOMY_NAME using "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/GII_only_2023.dta"

tab _merge
drop _merge

save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_2023.dta", replace

	   
*-------------------------------------------------------*
*                        GII 2022                       *
*-------------------------------------------------------*

cls 
clear all

import excel "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Tabla_Final_2022.xlsx", sheet("Sheet1") firstrow clear

describe

ds ECONOMY_NAME, not
local allvars `r(varlist)'

egen promedio_anio = rowmean(`allvars')

local varlist_in ""
foreach v of varlist `allvars' {
    if strpos("`v'", "IN") > 0 {
        local varlist_in "`varlist_in' `v'"
    }
}

if wordcount("`varlist_in'") > 0 {
    egen promedio_IN_2022 = rowmean(`varlist_in')
}
else {
    display "No se encontraron variables que contengan 'IN' en su nombre."
}

local varlist_out ""
foreach v of varlist `allvars' {
    if strpos("`v'", "OUT") > 0 {
        local varlist_out "`varlist_out' `v'"
    }
}

if wordcount("`varlist_out'") > 0 {
    egen promedio_OUT_2022 = rowmean(`varlist_out')
}
else {
    display "No se encontraron variables que contengan 'OUT' en su nombre."
}


save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Datos_Parciales_2022.dta", replace

*-------------- Limpieza Base Original ----------------------*

cls
clear all

import excel "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/wipo-pub-2000-2022-tech1.xlsx", sheet("Data") firstrow clear

describe
list in 1/20

keep if NAME == "Global Innovation Index"

keep ISO3 ECONOMY_NAME SCORE RANK

rename SCORE GII_Score
rename RANK GII_Rank

save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/GII_only_2022.dta", replace

*-------------- Merge - Base Final  ----------------------*

cls
clear all

use "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Datos_Parciales_2022.dta", clear

merge 1:1 ECONOMY_NAME using "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/GII_only_2022.dta"

tab _merge
drop _merge

save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_2022.dta", replace

*-------------------------------------------------------*
*                        GII 2021                       *
*-------------------------------------------------------*

cls 
clear all

import excel "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Tabla_Final_2021.xlsx", sheet("Sheet1") firstrow clear 

rename Economy ECONOMY_NAME


ds ECONOMY_NAME, not
local allvars `r(varlist)'

egen promedio_anio = rowmean(`allvars')

local varlist_in ""
foreach v of varlist `allvars' {
    if strpos("`v'", "IN") > 0 {
        local varlist_in "`varlist_in' `v'"
    }
}

if wordcount("`varlist_in'") > 0 {
    egen promedio_IN_2021 = rowmean(`varlist_in')
}
else {
    display "No se encontraron variables que contengan 'IN' en su nombre."
}

local varlist_out ""
foreach v of varlist `allvars' {
    if strpos("`v'", "OUT") > 0 {
        local varlist_out "`varlist_out' `v'"
    }
}

if wordcount("`varlist_out'") > 0 {
    egen promedio_OUT_2021 = rowmean(`varlist_out')
}
else {
    display "No se encontraron variables que contengan 'OUT' en su nombre."
}




save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Datos_Parciales_2021.dta", replace

*-------------- Limpieza Base Original ----------------------*

cls
clear all

import excel "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/wipo-pub-2000-2021-tech1.xlsx", sheet("GII 2021 Data") firstrow clear

describe
list in 1/20

keep if IndName == "Global Innovation Index"

keep ISO2 Economy Rank Score

rename Score GII_Score
rename Rank GII_Rank
rename Economy ECONOMY_NAME
rename ISO2 ISO3

save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/GII_only_2021.dta", replace

*-------------- Merge - Base Final  ----------------------*

cls
clear all

use "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Datos_Parciales_2021.dta", clear

merge 1:1 ECONOMY_NAME using "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/GII_only_2021.dta"

tab _merge
drop _merge

save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_2021.dta", replace

*-------------------------------------------------------*
*         Consolidación de la Base Final del GII        *
*-------------------------------------------------------*

cls
clear all

local years 2021 2022 2023 2024 2025

use "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_2021.dta", clear

replace ECONOMY_NAME = "Côte d'Ivoire" if ECONOMY_NAME == "Cote dIvoire" | ECONOMY_NAME == "CÃ´te d'Ivoire"
replace ECONOMY_NAME = "Netherlands" if ECONOMY_NAME == "Netherlands (Kingdom of the)"
replace ECONOMY_NAME = "Hong Kong, China" if ECONOMY_NAME == "Hong Kong"
replace ECONOMY_NAME = "Turkey" if ECONOMY_NAME == "Türkiye" | ECONOMY_NAME == "TÃ¼rkiye"
replace ECONOMY_NAME = "United States" if ECONOMY_NAME == "United States of America"
replace ECONOMY_NAME = "United Kingdom" if ECONOMY_NAME == "United Kingdom of Great Britain and Northern Ireland"
replace ECONOMY_NAME = "United Arab Emirates" if ECONOMY_NAME == "UAE"
replace ECONOMY_NAME = "South Korea" if ECONOMY_NAME == "Republic of Korea"
replace ECONOMY_NAME = "Russia" if ECONOMY_NAME == "Russian Federation"
replace ECONOMY_NAME = "Iran" if ECONOMY_NAME == "Iran (Islamic Republic of)"
replace ECONOMY_NAME = "Viet Nam" if ECONOMY_NAME == "Vietnam"
replace ECONOMY_NAME = "Tanzania" if ECONOMY_NAME == "United Republic of Tanzania"
replace ECONOMY_NAME = "Moldova" if ECONOMY_NAME == "Republic of Moldova"

keep ECONOMY_NAME GII_Score GII_Rank promedio_anio promedio_IN_2021 promedio_OUT_2021 ISO3
rename GII_Score GII_Score_2021
rename GII_Rank GII_Rank_2021
rename promedio_anio promedio_anio_2021

save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_Consolidada.dta", replace


foreach year of local years {
    if `year' == 2021 continue  
    
    use "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_`year'.dta", clear
	
	replace ECONOMY_NAME = "Côte d'Ivoire" if ECONOMY_NAME == "Cote dIvoire" | ECONOMY_NAME == "CÃ´te d'Ivoire"
	replace ECONOMY_NAME = "Netherlands" if ECONOMY_NAME == "Netherlands (Kingdom of the)"
	replace ECONOMY_NAME = "Hong Kong, China" if ECONOMY_NAME == "Hong Kong"
	replace ECONOMY_NAME = "Turkey" if ECONOMY_NAME == "Türkiye" | ECONOMY_NAME == "TÃ¼rkiye"
	replace ECONOMY_NAME = "United States" if ECONOMY_NAME == "United States of America"
	replace ECONOMY_NAME = "United Kingdom" if ECONOMY_NAME == "United Kingdom of Great Britain and Northern Ireland"
	replace ECONOMY_NAME = "United Arab Emirates" if ECONOMY_NAME == "UAE"
	replace ECONOMY_NAME = "South Korea" if ECONOMY_NAME == "Republic of Korea"
	replace ECONOMY_NAME = "Russia" if ECONOMY_NAME == "Russian Federation"
	replace ECONOMY_NAME = "Iran" if ECONOMY_NAME == "Iran (Islamic Republic of)"
	replace ECONOMY_NAME = "Viet Nam" if ECONOMY_NAME == "Vietnam"
	replace ECONOMY_NAME = "Tanzania" if ECONOMY_NAME == "United Republic of Tanzania"
	replace ECONOMY_NAME = "Moldova" if ECONOMY_NAME == "Republic of Moldova"

    keep ECONOMY_NAME GII_Score GII_Rank promedio_anio ISO3 promedio_IN_`year' promedio_OUT_`year' 
    rename GII_Score GII_Score_`year'
    rename GII_Rank GII_Rank_`year'
    rename promedio_anio promedio_anio_`year'

    merge 1:1 ECONOMY_NAME using "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_Consolidada.dta"

    tab _merge 
    drop _merge  

    save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_Consolidada.dta", replace

}

*--------- Adición de controles ---------------*

*2025*

cls
clear all

import excel "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/wipo-pub-2000-2025-tech1.xlsx", sheet("Economies") firstrow clear

replace ECONOMY_NAME = "Côte d'Ivoire" if ECONOMY_NAME == "Cote dIvoire" | ECONOMY_NAME == "CÃ´te d'Ivoire"
replace ECONOMY_NAME = "Netherlands" if ECONOMY_NAME == "Netherlands (Kingdom of the)"
replace ECONOMY_NAME = "Hong Kong, China" if ECONOMY_NAME == "Hong Kong"
replace ECONOMY_NAME = "Turkey" if ECONOMY_NAME == "Türkiye" | ECONOMY_NAME == "TÃ¼rkiye"
replace ECONOMY_NAME = "United States" if ECONOMY_NAME == "United States of America"
replace ECONOMY_NAME = "United Kingdom" if ECONOMY_NAME == "United Kingdom of Great Britain and Northern Ireland"
replace ECONOMY_NAME = "United Arab Emirates" if ECONOMY_NAME == "UAE"
replace ECONOMY_NAME = "South Korea" if ECONOMY_NAME == "Republic of Korea"
replace ECONOMY_NAME = "Russia" if ECONOMY_NAME == "Russian Federation"
replace ECONOMY_NAME = "Iran" if ECONOMY_NAME == "Iran (Islamic Republic of)"
replace ECONOMY_NAME = "Viet Nam" if ECONOMY_NAME == "Vietnam"
replace ECONOMY_NAME = "Tanzania" if ECONOMY_NAME == "United Republic of Tanzania"
replace ECONOMY_NAME = "Moldova" if ECONOMY_NAME == "Republic of Moldova"
 

keep ECONOMY_NAME ISO3 PPPGDP PPPPC POP 

rename PPPGDP PPPGDP_2025
rename PPPPC PPPPC_2025
rename POP POP_2025

save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/PPPGDP_2025.dta", replace

cls
clear all

use "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_Consolidada.dta", clear

merge 1:1 ECONOMY_NAME using "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/PPPGDP_2025.dta"

tab _merge  
drop _merge

save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_Consolidada.dta", replace

*2024*

cls
clear all

import excel "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/wipo-pub-2000-2024-tech1.xlsx", sheet("Economies") firstrow clear

replace ECONOMY_NAME = "Côte d'Ivoire" if ECONOMY_NAME == "Cote dIvoire" | ECONOMY_NAME == "CÃ´te d'Ivoire"
replace ECONOMY_NAME = "Netherlands" if ECONOMY_NAME == "Netherlands (Kingdom of the)"
replace ECONOMY_NAME = "Hong Kong, China" if ECONOMY_NAME == "Hong Kong"
replace ECONOMY_NAME = "Turkey" if ECONOMY_NAME == "Türkiye" | ECONOMY_NAME == "TÃ¼rkiye"
replace ECONOMY_NAME = "United States" if ECONOMY_NAME == "United States of America"
replace ECONOMY_NAME = "United Kingdom" if ECONOMY_NAME == "United Kingdom of Great Britain and Northern Ireland"
replace ECONOMY_NAME = "United Arab Emirates" if ECONOMY_NAME == "UAE"
replace ECONOMY_NAME = "South Korea" if ECONOMY_NAME == "Republic of Korea"
replace ECONOMY_NAME = "Russia" if ECONOMY_NAME == "Russian Federation"
replace ECONOMY_NAME = "Iran" if ECONOMY_NAME == "Iran (Islamic Republic of)"
replace ECONOMY_NAME = "Viet Nam" if ECONOMY_NAME == "Vietnam"
replace ECONOMY_NAME = "Tanzania" if ECONOMY_NAME == "United Republic of Tanzania"
replace ECONOMY_NAME = "Moldova" if ECONOMY_NAME == "Republic of Moldova"
 

keep ECONOMY_NAME ISO3 PPPGDP PPPPC POP 

rename PPPGDP PPPGDP_2024
rename PPPPC PPPPC_2024
rename POP POP_2024

save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/PPPGDP_2024.dta", replace

cls
clear all

use "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_Consolidada.dta", clear

merge 1:1 ECONOMY_NAME using "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/PPPGDP_2024.dta"

tab _merge  
drop _merge

save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_Consolidada.dta", replace

*2023*

cls
clear all

import excel "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/wipo-pub-2000-2023-tech1.xlsx", sheet("Economies") firstrow clear

replace ECONOMY_NAME = "Côte d'Ivoire" if ECONOMY_NAME == "Cote dIvoire" | ECONOMY_NAME == "CÃ´te d'Ivoire"
replace ECONOMY_NAME = "Netherlands" if ECONOMY_NAME == "Netherlands (Kingdom of the)"
replace ECONOMY_NAME = "Hong Kong, China" if ECONOMY_NAME == "Hong Kong"
replace ECONOMY_NAME = "Turkey" if ECONOMY_NAME == "Türkiye" | ECONOMY_NAME == "TÃ¼rkiye"
replace ECONOMY_NAME = "United States" if ECONOMY_NAME == "United States of America"
replace ECONOMY_NAME = "United Kingdom" if ECONOMY_NAME == "United Kingdom of Great Britain and Northern Ireland"
replace ECONOMY_NAME = "United Arab Emirates" if ECONOMY_NAME == "UAE"
replace ECONOMY_NAME = "South Korea" if ECONOMY_NAME == "Republic of Korea"
replace ECONOMY_NAME = "Russia" if ECONOMY_NAME == "Russian Federation"
replace ECONOMY_NAME = "Iran" if ECONOMY_NAME == "Iran (Islamic Republic of)"
replace ECONOMY_NAME = "Viet Nam" if ECONOMY_NAME == "Vietnam"
replace ECONOMY_NAME = "Tanzania" if ECONOMY_NAME == "United Republic of Tanzania"
replace ECONOMY_NAME = "Moldova" if ECONOMY_NAME == "Republic of Moldova"


keep ECONOMY_NAME ISO3 PPPGDP PPPPC POP 

rename PPPGDP PPPGDP_2023
rename PPPPC PPPPC_2023
rename POP POP_2023

save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/PPPGDP_2023.dta", replace

cls
clear all

use "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_Consolidada.dta", clear

merge 1:1 ECONOMY_NAME using "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/PPPGDP_2023.dta"

tab _merge  
drop _merge

save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_Consolidada.dta", replace

*2022*

cls
clear all

import excel "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/wipo-pub-2000-2022-tech1.xlsx", sheet("Economies") firstrow clear

replace ECONOMY_NAME = "Côte d'Ivoire" if ECONOMY_NAME == "Cote dIvoire" | ECONOMY_NAME == "CÃ´te d'Ivoire"
replace ECONOMY_NAME = "Netherlands" if ECONOMY_NAME == "Netherlands (Kingdom of the)"
replace ECONOMY_NAME = "Hong Kong, China" if ECONOMY_NAME == "Hong Kong"
replace ECONOMY_NAME = "Turkey" if ECONOMY_NAME == "Türkiye" | ECONOMY_NAME == "TÃ¼rkiye"
replace ECONOMY_NAME = "United States" if ECONOMY_NAME == "United States of America"
replace ECONOMY_NAME = "United Kingdom" if ECONOMY_NAME == "United Kingdom of Great Britain and Northern Ireland"
replace ECONOMY_NAME = "United Arab Emirates" if ECONOMY_NAME == "UAE"
replace ECONOMY_NAME = "South Korea" if ECONOMY_NAME == "Republic of Korea"
replace ECONOMY_NAME = "Russia" if ECONOMY_NAME == "Russian Federation"
replace ECONOMY_NAME = "Iran" if ECONOMY_NAME == "Iran (Islamic Republic of)"
replace ECONOMY_NAME = "Viet Nam" if ECONOMY_NAME == "Vietnam"
replace ECONOMY_NAME = "Tanzania" if ECONOMY_NAME == "United Republic of Tanzania"
replace ECONOMY_NAME = "Moldova" if ECONOMY_NAME == "Republic of Moldova"


keep ECONOMY_NAME ISO3 PPPGDP PPPPC POP 

rename PPPGDP PPPGDP_2022
rename PPPPC PPPPC_2022
rename POP POP_2022

save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/PPPGDP_2022.dta", replace

cls
clear all

use "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_Consolidada.dta", clear

merge 1:1 ECONOMY_NAME using "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/PPPGDP_2022.dta"

tab _merge  
drop _merge

save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_Consolidada.dta", replace	   
	   

*2021*

cls
clear all

import excel "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/wipo-pub-2000-2021-tech1.xlsx", sheet("Economies in Context") firstrow clear

rename Economy ECONOMY_NAME


replace ECONOMY_NAME = "Côte d'Ivoire" if ECONOMY_NAME == "Cote dIvoire" | ECONOMY_NAME == "CÃ´te d'Ivoire"
replace ECONOMY_NAME = "Netherlands" if ECONOMY_NAME == "Netherlands (Kingdom of the)"
replace ECONOMY_NAME = "Hong Kong, China" if ECONOMY_NAME == "Hong Kong"
replace ECONOMY_NAME = "Turkey" if ECONOMY_NAME == "Türkiye" | ECONOMY_NAME == "TÃ¼rkiye"
replace ECONOMY_NAME = "United States" if ECONOMY_NAME == "United States of America"
replace ECONOMY_NAME = "United Kingdom" if ECONOMY_NAME == "United Kingdom of Great Britain and Northern Ireland"
replace ECONOMY_NAME = "United Arab Emirates" if ECONOMY_NAME == "UAE"
replace ECONOMY_NAME = "South Korea" if ECONOMY_NAME == "Republic of Korea"
replace ECONOMY_NAME = "Russia" if ECONOMY_NAME == "Russian Federation"
replace ECONOMY_NAME = "Iran" if ECONOMY_NAME == "Iran (Islamic Republic of)"
replace ECONOMY_NAME = "Viet Nam" if ECONOMY_NAME == "Vietnam"
replace ECONOMY_NAME = "Tanzania" if ECONOMY_NAME == "United Republic of Tanzania"
replace ECONOMY_NAME = "Moldova" if ECONOMY_NAME == "Republic of Moldova"


keep ECONOMY_NAME ISO3 PPPPC POP 

rename PPPPC PPPPC_2021
rename POP POP_2021

save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/PPPGDP_2021.dta", replace

cls
clear all

use "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_Consolidada.dta", clear

merge 1:1 ECONOMY_NAME using "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/PPPGDP_2021.dta"

tab _merge  
drop _merge

save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_Consolidada.dta", replace	

export delimited using "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_Consolidada.csv", replace


*-------------------------------------------------------*
*                       Estimaciones                    *
*-------------------------------------------------------*

cls
clear all

use "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_Consolidada.dta", clear
   
order ISO3 ECONOMY_NAME ///
      GII_Rank_2021 GII_Rank_2022 GII_Rank_2023 GII_Rank_2024 ///
      GII_Score_2021 GII_Score_2022 GII_Score_2023 GII_Score_2024 ///
      promedio_anio_2021 promedio_anio_2022 promedio_anio_2023 promedio_anio_2024 ///
      POP_2021 POP_2022 POP_2023 POP_2024 ///
      PPPPC_2021 PPPGDP_2022 PPPPC_2022 PPPGDP_2023 PPPPC_2023 PPPGDP_2024 PPPPC_2024

	  

* Regresión para 2021
reg GII_Score_2021 promedio_IN_2021 promedio_OUT_2021 PPPPC_2021, robust
estimates store reg2021

* Regresión para 2022
reg GII_Score_2022 promedio_IN_2022 promedio_OUT_2022 PPPPC_2022, robust
estimates store reg2022

* Regresión para 2023
reg GII_Score_2023 promedio_IN_2023 promedio_OUT_2023 PPPPC_2023, robust
estimates store reg2023

* Regresión para 2024
reg GII_Score_2024 promedio_IN_2024 promedio_OUT_2024 PPPPC_2024, robust
estimates store reg2024

* Gráfico para 2021
coefplot reg2021, keep(promedio_IN_2021 promedio_OUT_2021) ///
    vertical msymbol(O) ciopts(lcolor(black)) ///
    title("Coeficientes de IN y OUT - 2021") ///
    ytitle("Coeficiente estimado") xlabel(, labsize(medlarge)) ///
    legend(order(1 "Input" 2 "Output"))

graph export coef_2021.png, replace

* Gráfico para 2022
coefplot reg2022, keep(promedio_IN_2022 promedio_OUT_2022) ///
    vertical msymbol(O) ciopts(lcolor(black)) ///
    title("Coeficientes de IN y OUT - 2022") ///
    ytitle("Coeficiente estimado") xlabel(, labsize(medlarge)) ///
    legend(order(1 "Input" 2 "Output"))

graph export coef_2022.png, replace

* Gráfico para 2023
coefplot reg2023, keep(promedio_IN_2023 promedio_OUT_2023) ///
    vertical msymbol(O) ciopts(lcolor(black)) ///
    title("Coeficientes de IN y OUT - 2023") ///
    ytitle("Coeficiente estimado") xlabel(, labsize(medlarge)) ///
    legend(order(1 "Input" 2 "Output"))

graph export coef_2023.png, replace

* Gráfico para 2024
coefplot reg2024, keep(promedio_IN_2024 promedio_OUT_2024) ///
    vertical msymbol(O) ciopts(lcolor(black)) ///
    title("Coeficientes de IN y OUT - 2024") ///
    ytitle("Coeficiente estimado") xlabel(, labsize(medlarge)) ///
    legend(order(1 "Input" 2 "Output"))

graph export coef_2024.png, replace



*-------------------------------------------------------*
*                       Datos Panel                     *
*-------------------------------------------------------*

clear all
cls

use "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_Consolidada.dta", clear

describe

reshape long ///
    GII_Rank_ ///
    GII_Score_ ///
    promedio_anio_ ///
    POP_ ///
    PPPPC_ ///
    PPPGDP_ ///
    promedio_IN_ ///
    promedio_OUT_, ///
    i(ISO3) j(year)

rename GII_Rank_ GII_Rank
rename GII_Score_ GII_Score
rename promedio_anio_ promedio_anio
rename POP_ pop
rename PPPPC_ ppppc
rename PPPGDP_ pppgdp
rename promedio_IN_ promedio_IN
rename promedio_OUT_ promedio_OUT

destring year, replace


gen T_anio = year - promedio_anio
gen T_IN = year - promedio_IN
gen T_OUT = year - promedio_OUT

save "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_Consolidada_Datos_Panel.dta", replace

*-------------------------------------------------------*
*             Estimaciones -  Datos Panel               *
*-------------------------------------------------------*


cls
clear all

use "/Users/camilojose/Desktop/2025/Tesis Doctorado /Contrucción de la base de datos 2024/Base_Final_Consolidada_Datos_Panel.dta", clear


encode ISO3, gen(country_id)

xtset country_id year
xtreg GII_Score T_IN T_OUT, fe

xtreg GII_Score T_IN T_OUT, fe vce(robust)

* - _cons (o la constante) no se interpreta como el promedio global,
*   porque con FE se centra en cada país.
* - T_IN: cuánto varía GII_Score cuando T_IN aumenta en 1 unidad.
* - T_OUT: cuánto varía GII_Score cuando T_OUT aumenta en 1 unidad.















