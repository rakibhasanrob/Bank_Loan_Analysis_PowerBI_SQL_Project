select * from BankLoan

-- Total Loan Applications

select count(id) as total_loan_applications
from BankLoan

-- Month to date total loan applications, where month is the latest (december)
-- The query have a fucntion day (issue date) although it should be month. But because of the data type error we have to consider date represnts month in this query

select count(id) as MTD_total_loan_applications
from BankLoan
where day(issue_date) = 12 and year(issue_date) = 2021

-- Previous MTD total applications, previous month is november, day(issue_date) represnts month(issue_date) in all of this query

select count(id) as PMTD_total_loan_applications
from BankLoan
where day(issue_date) = 11 and year(issue_date) = 2021

-- Total funded amount (total loan amount)

select sum(loan_amount) AS Total_funded_amount
from BankLoan

select sum(loan_amount) AS MTD_Total_funded_amount
from BankLoan
where day(issue_date) = 12 and year(issue_date) = 2021

select sum(loan_amount) AS PMTD_Total_funded_amount
from BankLoan
where day(issue_date) = 11 and year(issue_date) = 2021

-- Total Recived Amount (total payment amount)

select sum(total_payment) AS Total_recived_amount
from BankLoan

select sum(total_payment) AS MTD_Total_recived_amount
from BankLoan
where day(issue_date) = 12 and year(issue_date) = 2021

select sum(total_payment) AS PMTD_Total_recived_amount
from BankLoan
where day(issue_date) = 11 and year(issue_date) = 2021

-- Average internest rate

select round(avg(int_rate)*100, 4) AS average_interest_rate
from BankLoan

select round(avg(int_rate)*100, 4) AS MTD_average_interest_rate
from BankLoan
where day(issue_date) = 12 and year(issue_date) = 2021

select round(avg(int_rate)*100, 4) AS PMTD_average_interest_rate
from BankLoan
where day(issue_date) = 11 and year(issue_date) = 2021

-- Average Debt to income

select round(avg(dti)*100, 4) AS average_dti_rate
from BankLoan

select round(avg(dti)*100, 4) AS MTD_average_dti_rate
from BankLoan
where day(issue_date) = 12 and year(issue_date) = 2021

select round(avg(dti)*100, 4) AS PMTD_average_dti_rate
from BankLoan
where day(issue_date) = 11 and year(issue_date) = 2021

-- Good vs Bad Loan

select distinct loan_status
from BankLoan

-- Good Loan

select (count( case when loan_status = 'Fully Paid' or loan_status = 'Current' then id end)*100.0) / count (id) as good_loan_percentage
from BankLoan

select count(id) as total_good_loan_application
from BankLoan
where loan_status = 'Fully Paid' or loan_status = 'Current'

select sum(loan_amount) as total_goodloan_funded
from BankLoan
where loan_status = 'Fully Paid' or loan_status = 'Current'

select sum(total_payment) as total_goodloan_recived
from BankLoan
where loan_status = 'Fully Paid' or loan_status = 'Current'

-- Bad loan

select (count( case when loan_status = 'Charged Off' then id end)*100.0) / count (id) as bad_loan_percentage
from BankLoan

select count(id) as total_bad_loan_application
from BankLoan
where loan_status = 'Charged Off'

select sum(loan_amount) as total_badloan_funded
from BankLoan
where loan_status = 'Charged Off'

select sum(total_payment) as total_badloan_recived
from BankLoan
where loan_status = 'Charged Off'

-- Loan Status Grid Lines

select
loan_status,
count(id) as Loan_Count,
sum(total_payment) as Totol_Amount_Recived,
sum(loan_amount) as Total_Amount_Funded,
round(avg(int_rate)*100 , 2) as Average_Interest_Rate,
round(avg(dti)*100 , 2) as Average_DTI
from BankLoan
Group by loan_status

select
loan_status,
count(id) as Loan_Count,
sum(total_payment) as Totol_Amount_Recived,
sum(loan_amount) as Total_Amount_Funded,
round(avg(int_rate)*100 , 2) as Average_Interest_Rate,
round(avg(dti)*100 , 2) as Average_DTI
from BankLoan
where day(issue_date)=12
Group by loan_status

-- Monthly Trend by Issue date (There is a whole issue in issue_date column, so this query might not be correct. Have to contact with the data engineer related to this dataset or source of information)

select 
datename(day, issue_date) as Month_Serial,
count(id) as Total_Application_Count,
sum(total_payment) as Totol_Amount_Recived,
sum(loan_amount) as Total_Amount_Funded
from BankLoan
group by datename(day, issue_date)
order by datename(day, issue_date)

-- Regional Analysis by State

select
address_state as State,
count(id) as Total_Application_Count,
sum(total_payment) as Totol_Amount_Recived,
sum(loan_amount) as Total_Amount_Funded
from BankLoan
group by address_state
order by count(id) desc

-- Loan term analysis

select
term as Loan_Term,
count(id) as Total_Application_Count,
sum(total_payment) as Totol_Amount_Recived,
sum(loan_amount) as Total_Amount_Funded
from BankLoan
group by term
order by term

-- Employee Length Analysis

select
emp_length as Employee_Lenght,
count(id) as Total_Application_Count,
sum(total_payment) as Totol_Amount_Recived,
sum(loan_amount) as Total_Amount_Funded
from BankLoan
group by emp_length
order by count(id) desc

-- Loan Purpose Breakdown

select
purpose as Loan_Purpose,
count(id) as Total_Application_Count,
sum(total_payment) as Totol_Amount_Recived,
sum(loan_amount) as Total_Amount_Funded
from BankLoan
group by purpose
order by count(id) desc

-- Home Ownership Analysis

select
home_ownership as Home_Ownership_Status,
count(id) as Total_Application_Count,
sum(total_payment) as Totol_Amount_Recived,
sum(loan_amount) as Total_Amount_Funded
from BankLoan
--where home_ownership <> 'NONE'
group by home_ownership
order by count(id)

-- Grid View, its nothing but the entire dataset

select *
from BankLoan

