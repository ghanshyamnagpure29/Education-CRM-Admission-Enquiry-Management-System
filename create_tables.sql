First table : COLLEGE

create table COLLEGE (college_id number primary key,
                      college_name varchar2(45));          

--------------------------------------------------------------------------------------------------------------------------------------

Second table : QUALIFICATION

create table QUALIFICATION (qid number primary key,
                            degree_name varchar2(30));       

--------------------------------------------------------------------------------------------------------------------------------------

Third table : STREAM

create table STREAM (stream_id number primary key,
                     stream_name varchar2(30));   

--------------------------------------------------------------------------------------------------------------------------------------           

Fourth table : SOURCE_MASTER

create table SOURCE_MASTER (source_id number primary key,
                            source_name varchar2(20) unique); 

--------------------------------------------------------------------------------------------------------------------------------------

Fifth table : COLLEGE_SEM

create table COLLEGE_SEM (sem_id number primary key,
                          sem_name varchar2(10) unique);

--------------------------------------------------------------------------------------------------------------------------------------

Sixth table : COLLEGE_YEAR

 create table COLLEGE_YEAR (year_id number primary key,
                            year_name varchar2(20) unique);

--------------------------------------------------------------------------------------------------------------------------------------

Seventh table : COUNTRY

create table COUNTRY (country_id number primary key,
                      country_name varchar2(10) unique);

--------------------------------------------------------------------------------------------------------------------------------------

Eighth table :  STATE

create table STATE (state_id number primary key,
                    state_name varchar2(20),
                    country_id number constraint state_country_id_fk references country(country_id));

--------------------------------------------------------------------------------------------------------------------------------------

Nineth table : CITY

create table CITY (city_id number primary key,
                   city_name varchar2(30),
                   state_id number constraint city_state_id_fk references state(state_id));

--------------------------------------------------------------------------------------------------------------------------------------

Tenth table : ENQUIRY_MASTER

create table ENQUIRY_MASTER (enquiry_id number primary key,
                             name varchar2(20) not null,
                             phone_no number(10) check (length(phone_no)=10) unique,
                             email varchar2(25) not null check(email like '%@%.%'),
                             address varchar2(15) null,
                             gender varchar2(2) not null,
                             age number(3) not null,
                             working varchar2(10) null,
                             work_experiance varchar2(2) null,
                             job_profile varchar2(10),
                             city_id number constraint enquiry_master_city_id_fk references city(city_id));

--------------------------------------------------------------------------------------------------------------------------------------

Eleventh table : COLLEGE_HISTORY

create table COLLEGE_HISTORY (enquiry_id number constraint coll_hist_enquiry_id_fk references enquiry_master(enquiry_id),
                              college_id number constraint coll_hist_college_id_fk references college(college_id),
                              date_of_change date null,
                              sem_id     number constraint coll_hist_sem_id_fk     references college_sem(sem_id),
                              year_id    number constraint coll_hist_year_id_fk    references college_year(year_id),
                              qid        number constraint coll_hist_qid_fk        references qualification(qid),
                              stream_id  number constraint coll_hist_stream_id_fk  references stream(stream_id));

--------------------------------------------------------------------------------------------------------------------------------------

Twelveth table : SOURCE_HISTORY
 
create table SOURCE_HISTORY (source_id number constraint source_hist_source_id_fk references source_master(source_id),
                            enquiry_id number constraint source_hist_enquiry_id_fk references enquiry_master(enquiry_id),
                            source_date_of_enquiry date not null);

--------------------------------------------------------------------------------------------------------------------------------------

Thirteenth table  : COURSE

create table COURSE (course_id number primary key,
                     course_name varchar2(30) not null unique,
                     fee number not null);

--------------------------------------------------------------------------------------------------------------------------------------

Fourteenth table : STAFF

create table STAFF (staff_id number primary key,
                    staff_name varchar2(20) not null);

--------------------------------------------------------------------------------------------------------------------------------------

Sequence for Sixteenth table : create sequence followup_id_seq;
             
             Sixteenth table : FOLLOW_UP

create table FOLLOW_UP (followup_id number default followup_id_seq.nextval primary key,
                        staff_id number constraint followup_staff_id references staff(staff_id),
                        enquiry_id number constraint followup_enquiry_id references enquiry_master(enquiry_id),
                        status varchar2(15),
                        date_of_followup date not null,
                        remark varchar2(50),
                        next_followup_date date not null);

--------------------------------------------------------------------------------------------------------------------------------------

Seventeenth table : ENQUIRY_HANDLED

create table ENQUIRY_HANDLED (enquiry_id number,
                              assigned_date_to_staff date not null,
                              handled_enquiry_date date,
                              fee_suggested number,
                              staff_status varchar2(15),
                              enquiry_status varchar2(8),
                              course_id number,
                              staff_id  number,
                              visited_status varchar2(5),
                              registered_status varchar2(5),
                              close_date_of_enquiry date,
                              close_enquiry_status varchar2(8),
                              constraint eh_enquiry_fk foreign key (enquiry_id) references enquiry_master(enquiry_id),
                              constraint eh_course_fk  foreign key (course_id ) references course(course_id),
                              constraint eh_staff_fk   foreign key (staff_id  ) references staff(staff_id));

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++





