//do file for processing first round of HBTC
//created by Sussie
//modified in a error  branch
//edited locally
import delimited "C:\Users\dkwaro\Documents\data dictionary\hivssrd1.csv", varnames(1) 
generate index=_n
order index
drop if missing( group_variable) & missing( group_variablelabels_codes) & missing( length)&missing( choices)
regexm("[A-Z][1-9]+.", "Q7.")
help regexm
regexm("Q7.","[A-Z][1-9]+.")
display regexm("Q7.","[A-Z][1-9]+.")
help regexs
generate group =regexs(1) if  regexm("Q7.","[A-Z][1-9]+.")
generate group =regexs(1) if  regexm( group_variable ,"[A-Z][1-9]+.")
help regex
generate str group =regexs(1) if  regexm( group_variable ,"[A-Z][1-9]+.")
list index group_variable if  regexm( group_variable ,"[A-Z][1-9]+.")
list index group_variable if  regexm( group_variable ,"[A-Z][1-9]+\.")
gen group= group_variable if  regexm( group_variable ,"[A-Z][1-9]+\.")
order index group group_variable
sort group
sort group_variable
replace group= group_variable if group_variable=="Calculated Variable"
gen length_group_variable=length( group_variable)
order index group group_variable length_group_variable
sort length_group_variable
drop if length_group_variable>197 & length_group_variable<206
drop if group_variable==20|21
drop if group_variable=="20"|"21"
drop if group_variable="20"|"21"
drop if group_variable=20|21
drop if group_variable>19 & group_variable<22
drop if length_group_variable >19 & length_group_variable <22
sort index
gen group_description= group_variable[_n+1] if length_group_variable[_n+1]> length_group_variable & !missing(group_variable[_n+1])
order index group group_variable length_group_variable group_variablelabels_codes group_description
sort length_group_variable
drop if index=5153|2770
drop if index==5153|2770
clear
import delimited "C:\Users\dkwaro\Documents\data dictionary\hivssrd1.csv", varnames(1) 
generate index=_n
drop if missing( group_variable) & missing( group_variablelabels_codes) & missing( length)&missing( choices)
gen group= group_variable if  regexm( group_variable ,"[A-Z][1-9]+\.")
replace group= group_variable if group_variable=="Calculated Variable"
gen length_group_variable=length( group_variable)
drop if length_group_variable>197 & length_group_variable<206
drop if length_group_variable >19 & length_group_variable <22
gen group_description= group_variable[_n+1] if length_group_variable[_n+1]> length_group_variable & !missing(group_variable[_n+1])
order index group group_variable length_group_variable group_variablelabels_codes group_description
sort length_group_variable
sort index
replace group_variablelabels_codes = "To a random sample of 1 out of every 10 participants: may I see the safe water system?" in 4851
drop if index=5735
drop if index==5735
drop if index==5153
replace group_variablelabels_codes = "How many times in the last one week did you have sex with this partner [nickname]?" in 1490
drop if index==1776
drop if index==2770
replace group_variablelabels_codes = "How many times in the last one week did you have sex with this partner [nickname]?" in 940
drop if index==1127
replace group_variablelabels_codes = "How many times in the last one week did you have sex with this partner [nickname]?" in 2036
drop if index==2423
replace group_variablelabels_codes = "you have mentioned having recieved a safe water system:How often do you use the safe water system(container and tablets to make your drinking water safe)?" in 4831
drop if index==5718
sort length_group_variable
sort index
save "C:\Users\dkwaro\Documents\data dictionary\hivssrd1.dta"
replace group=group[_n-1] if missing(group)
clear
use "C:\Users\dkwaro\Documents\data dictionary\hivssrd1.dta"
rep group= group_variable if  regexm( group_variable ,"[A-Z][0-9]+\.") & missing(group)
replace group= group_variable if  regexm( group_variable ,"[A-Z][0-9]+\.") & missing(group)
replace group=group[_n-1] if missing(group)
gen group_desc= group_variablelabels_codes if group== group_variable
order index group group_desc
replace group_desc =group_desc[_n-1] if missing(group_desc)
save "C:\Users\dkwaro\Documents\data dictionary\hivssrd1.dta", replace
drop if group== group_variable
rename group_variable variable
replace variable=variable{_n-1] if missing(variable)
replace variable=variable[_n-1] if missing(variable)
replace variable = "" in 4543
replace variable = "" in 4545
replace variable=variable{_n-1] if missing(variable)
replace variable=variable[_n-1] if missing(variable)
sort variable
replace variable = "" in 1
replace variable = "" in 2
replace variable = "" in 3
replace variable = "" in 4
replace variable = "" in 5
replace variable = "" in 6
sort index
replace variable=variable[_n-1] if missing(variable)
sort variable
by variable:gen order=_n
order index group group_desc variable order
drop order
bysort variable index:gen rank=_n
order index group group_desc variable index
order index
drop length_group_variable
order index group group_desc variable rank
order index
sort index
drop rank
help egen
rename variable question
bysort question  index:gen rank=_n
drop rank
bysort question  index:egen rank=rank()
help egen
bysort question  index:egen rank=rank( question)
by question:gen rank=_n
drop rank
sort index
by question:gen rank=_n
bysort question index:gen rank=_n
drop rank
sort index
by question:gen rank=_n
bysort index question:gen rank=_n
drop rank
help by
sort question index
by question:gen rank=_n
gen question_desc= group_variablelabels_codes if rank==1
rep question_desc== question_desc[_n-1] if missing( question_desc)
replace question_desc== question_desc[_n-1] if missing( question_desc)
replace question_desc= question_desc[_n-1] if missing( question_desc)
drop if rank=1
drop if rank==1
sort index
drop group_description length
order index group group_desc question question_desc choices
rename group_variablelabels_codes code
drop rank
save "C:\Users\dkwaro\Documents\data dictionary\hivssrd1.dta", replace
export excel using "C:\Users\dkwaro\Documents\data dictionary\editedrd1hivss.xls", firstrow(variables)
