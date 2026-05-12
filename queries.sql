-- Display all student enquiries.

select * from enquiry_master;


---------------------------------------------------------------------------------------------------

 
-- Display fresher enquiries.

select enquiry_id,name 
from   enquiry_master 
where  job_profile = 'Fresher';


---------------------------------------------------------------------------------------------------


-- Display Count total enquiries

select count(*) as total_enquiries 
from   enquiry_master;


---------------------------------------------------------------------------------------------------


-- Display enquiry details with city information.

select e.enquiry_id,e.name,c.city_name
from   enquiry_master e join city c
using  (city_id);


---------------------------------------------------------------------------------------------------


-- Display enquiries name with fee_suggested and staff_name.

select e.name,eh.fee_suggested,s.staff_name
from   enquiry_master e join enquiry_handled eh
using  (enquiry_id)
                        join staff s
using  (staff_id);


---------------------------------------------------------------------------------------------------


-- Display all enquiries with city, state, country.

select e.enquiry_id,e.name,e.phone_no,c.city_name,s.state_name,co.country_name
from   enquiry_master e join city c
using  (city_id)
                        join state s
using  (state_id)
                        join country co
using  (country_id);


---------------------------------------------------------------------------------------------------


-- Display count total enquiries city wise.

select   c.city_name,count(enquiry_id) as total_enquiries
from     enquiry_master e join city c
  on     e.city_id = c.city_id
group by c.city_name
order by total_enquiries desc;


---------------------------------------------------------------------------------------------------


-- Display assigned and not assigned enquiries.

select   staff_status,count(*) as total
from     enquiry_handled
group by staff_status;


---------------------------------------------------------------------------------------------------


-- Display all closed enquiries.

select * from enquiry_handled
where  enquiry_status = 'Closed';


---------------------------------------------------------------------------------------------------


-- Display students registered for course.

select e.name,c.course_name,eh.registered_status
from   enquiry_master e join enquiry_handled eh
  on   e.enquiry_id = eh.enquiry_id
                        join course c
  on   eh.course_id = c.course_id
where   eh.registered_status = 'Yes';


---------------------------------------------------------------------------------------------------


-- Display highest fee suggested.

select max(fee_suggested) as highest_fee
from   enquiry_handled;


---------------------------------------------------------------------------------------------------


-- Display average suggested fee course wise.

select   c.course_name,avg(eh.fee_suggested) AS average_fee
from     enquiry_handled eh join course c
   on    eh.course_id = c.course_id
group by c.course_name;


---------------------------------------------------------------------------------------------------


-- Display student college history.

select e.name,col.college_name,cs.sem_name,cy.year_name,q.degree_name,st.stream_name
from   college_history ch join enquiry_master e 
using  (enquiry_id)
                          join college col 
using  (college_id)
                          join college_sem cs 
using  (sem_id)
                          join college_year cy 
using  (year_id)
                          join qualification q 
using  (qid)
                          join stream st 
using  (stream_id);


---------------------------------------------------------------------------------------------------


-- Display staff wise handled enquiries.

select   s.staff_name,count(eh.enquiry_id) as handled_enquiries
from     enquiry_handled eh join staff s
  on     eh.staff_id = s.staff_id
group by s.staff_name;


---------------------------------------------------------------------------------------------------


-- Display top 3 courses by enquiries.

select *
from   (select    c.course_name,count(*) as total_enquiries
          from    enquiry_handled eh join course c
            on    eh.course_id = c.course_id
        group by  c.course_name
        order by  total_enquiries desc)
where  rownum <= 3;


---------------------------------------------------------------------------------------------------


-- Case statement Example.

select enquiry_id,fee_suggested,
  case when fee_suggested >= 15000 then 'High_Fee'
       when fee_suggested >= 5000  then 'Medium_Fee'
  else 'Low Fee'
  end  as fee_category
from   enquiry_handled;


---------------------------------------------------------------------------------------------------


-- Subquery Example.

select *
from   enquiry_master
where  enquiry_id IN (select enquiry_id
                      from   enquiry_handled
                      where  registered_status = 'Yes');


---------------------------------------------------------------------------------------------------


-- Display rank students by fees.

select enquiry_id,fee_suggested,rank() OVER (ORDER BY fee_suggested DESC) as ranking
from   enquiry_handled;


+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++







































































































































































































































































