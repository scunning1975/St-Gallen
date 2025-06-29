* name: equivalence.do
* author: scott cunningham
* description: OLS and Manual are the same

clear 
capture log close

use https://github.com/scunning1975/mixtape/raw/master/castle.dta, clear
xtset sid year

drop if effyear==2005 | effyear==2007 | effyear==2008 | effyear==2009

drop 	post
gen 	post = 0
replace post = 1 if year>=2006

gen 	treat = 0
replace treat = 1 if effyear==2006

keep if year==2006 | year==2005

* Manual
egen y11 = mean(l_homicide) if post==1 & treat==1
egen y10 = mean(l_homicide) if post==0 & treat==1
egen ey11 = max(y11)
egen ey10 = max(y10)

egen y01 = mean(l_homicide) if post==1 & treat==0
egen y00 = mean(l_homicide) if post==0 & treat==0
egen ey01 = max(y01)
egen ey00 = max(y00)

gen did = (ey11 - ey10) - (ey01 - ey00)
sum did

* Example 1: OLS regression with interactions
reg l_homicide post##treat, cluster(sid)

* Example 2: Twoway fixed effects (state and year fixed effects)
xtreg l_homicide c.treat#c.post i.year, fe vce(cluster sid)

* Example 3: Regress "long difference" onto treatment dummy
preserve
    keep sid year l_homicide treat
    reshape wide l_homicide, i(sid) j(year)
    gen diff = l_homicide2006 - l_homicide2005
    reg diff treat, vce(cluster sid)
restore

* Now calculate the same thing using population weights as below

* Example 1: OLS regression with interactions and population weights
reg l_homicide post##treat [aweight=popwt], cluster(sid) 

* Example 2: Twoway fixed effects (state and year fixed effects)
xtreg l_homicide c.treat#c.post i.year [aw=popwt], fe vce(cluster sid)

* Example 3: Regress "long difference" onto treatment dummy
preserve
    keep sid year l_homicide popwt treat
    reshape wide l_homicide popwt, i(sid) j(year)
    gen diff = l_homicide2006 - l_homicide2005
    reg diff treat [aw=popwt2005], vce(cluster sid)
restore

