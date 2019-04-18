-- 
-- OLAP for OTRS v6
-- This is script create a database OLAP for a proccess ETL
-- 

create database otrs_olap charset utf8;

use otrs_olap;

-- Dimensions tables
drop table if exists dm_time;
create table dm_time(
	sk_time bigint(20) NOT NULL AUTO_INCREMENT,
	dt_date datetime DEFAULT '0001-01-01 00:00:00',
	year int(11) DEFAULT NULL,
	month int(11) DEFAULT NULL,
	day int (11) DEFAULT NULL,
	day_of_week int(11) DEFAULT NULL,
	bimonth int(11) DEFAULT NULL,
	bimonth_name varchar(20) DEFAULT NULL,
	quarter int(11) DEFAULT NULL,
	quarter_name varchar(20) DEFAULT NULL,
	halfmonth int(11) DEFAULT NULL,
	halfmonth_name varchar(20) DEFAULT NULL,
	month_short varchar(5) DEFAULT NULL,
	month_name varchar(20) DEFAULT NULL,
	dayweek_short varchar(5) DEFAULT NULL,
	dayweek_name varchar(20) DEFAULT NULL,
	day_in_year int(11) DEFAULT NULL,
    

	PRIMARY KEY (sk_time),
	KEY idx_dt_date (dt_date)
);
drop table if exists dm_state;
create table dm_state(
	sk_state bigint(20) NOT NULL AUTO_INCREMENT,
	version int(11) DEFAULT NULL,
	date_from datetime DEFAULT NULL,
	date_to datetime DEFAULT NULL,
	id_state int(11) DEFAULT NULL,
	name_state varchar(200) DEFAULT NULL,
	id_valid int(11) DEFAULT NULL,

	PRIMARY KEY (sk_state),
	KEY idx_id_state (id_state)
);
drop table if exists dm_type;
create table dm_type(
	sk_type bigint(20) NOT NULL AUTO_INCREMENT,
	version int(11) DEFAULT NULL,
	date_from datetime DEFAULT NULL,
	date_to datetime DEFAULT NULL,
	id_type int(11) DEFAULT NULL,
	name_type varchar(200) DEFAULT NULL,
	id_valid int(11) DEFAULT NULL,

	PRIMARY KEY (sk_type),
	KEY idx_id_type (id_type)
);
drop table if exists dm_priority;
create table dm_priority(
	sk_priority bigint(20) NOT NULL AUTO_INCREMENT,
	version int(11) DEFAULT NULL,
	date_from datetime DEFAULT NULL,
	date_to datetime DEFAULT NULL,
	id_priority int(11) DEFAULT NULL,
	name_priority varchar(200) DEFAULT NULL,
	id_valid int(11) DEFAULT NULL,

	PRIMARY KEY (sk_priority),
	KEY idx_id_priority (id_priority)
);
drop table if exists dm_service;
create table dm_service(
	sk_service bigint(20) NOT NULL AUTO_INCREMENT,
	version int(11) DEFAULT NULL,
	date_from datetime DEFAULT NULL,
	date_to datetime DEFAULT NULL,
	id_service int(11) DEFAULT NULL,
	name_service varchar(200) DEFAULT NULL,
	criticality varchar(200) DEFAULT NULL,
	type_catalog varchar(200) DEFAULT NULL,
	id_valid int(11) DEFAULT NULL,

	PRIMARY KEY (sk_service),
	KEY idx_id_service (id_service)
);
drop table if exists dm_sla;
create table dm_sla(
	sk_sla bigint(20) NOT NULL AUTO_INCREMENT,
	version int(11) DEFAULT NULL,
	date_from datetime DEFAULT NULL,
	date_to datetime DEFAULT NULL,
	id_sla int(11) DEFAULT NULL,
	name_sla varchar(200) DEFAULT NULL,
	calendar_name varchar(200) DEFAULT NULL,
	first_time int(11) DEFAULT NULL,
	update_time int(11) DEFAULT NULL,
	solution_time int(11) DEFAULT NULL,
    time_incidents int(11) DEFAULT NULL,
    type_catalog varchar(200) DEFAULT NULL,
	id_valid int(11) DEFAULT NULL,

	PRIMARY KEY (sk_sla),
	KEY idx_id_sla (id_sla)
);
drop table if exists dm_queue;
create table dm_queue(
	sk_queue bigint(20) NOT NULL AUTO_INCREMENT,
	version int(11) DEFAULT NULL,
	date_from datetime DEFAULT NULL,
	date_to datetime DEFAULT NULL,
	id_queue int(11) DEFAULT NULL,
	name_queue varchar(200) DEFAULT NULL,
	calendar_name varchar(200) DEFAULT NULL,
	first_time int(11) DEFAULT NULL,
	update_time int(11) DEFAULT NULL,
	solution_time int(11) DEFAULT NULL,
	id_valid int(11) DEFAULT NULL,

    PRIMARY KEY (sk_queue),
    KEY idx_id_queue (id_queue)
);
drop table if exists dm_customer;
create table dm_customer(
	sk_customer bigint(20) NOT NULL AUTO_INCREMENT,
	version int(11) DEFAULT NULL,
	date_from datetime DEFAULT NULL,
	date_to datetime DEFAULT NULL,
	id_customer int(11) DEFAULT NULL,
	login varchar(200) DEFAULT NULL,
	name_customer varchar(200) DEFAULT NULL,
    email varchar(200) DEFAULT NULL,
	id_valid int(11) DEFAULT NULL,

    PRIMARY KEY (sk_customer),
    KEY idx_id_customer (id_customer)
);
drop table if exists dm_user;
create table dm_user(
	sk_user bigint(20) NOT NULL AUTO_INCREMENT,
	version int(11) DEFAULT NULL,
	date_from datetime DEFAULT NULL,
	date_to datetime DEFAULT NULL,
	id_user int(11) DEFAULT NULL,
	login varchar(200) DEFAULT NULL,
	name_user varchar(200) DEFAULT NULL,
    email varchar(200) DEFAULT NULL,
	id_valid int(11) DEFAULT NULL,

    PRIMARY KEY (sk_user),
    KEY idx_id_user (id_user)
);
drop table if exists dm_ticket;
create table dm_ticket(
	sk_ticket bigint(20) NOT NULL AUTO_INCREMENT,
	version int(11) DEFAULT NULL,
	date_from datetime DEFAULT NULL,
	date_to datetime DEFAULT NULL,
	id_ticket int(11) DEFAULT NULL,
	ticket_number varchar(50) DEFAULT NULL,
	title varchar(255) DEFAULT NULL,
	communication_channel varchar(200) DEFAULT NULL,

    PRIMARY KEY (sk_ticket),
    KEY idx_id_ticket (id_ticket),
    KEY idx_ticket_number (ticket_number),
    KEY idx_communication_channel (communication_channel)
);

-- Fact tables
drop table if exists fc_ticket;
create table fc_ticket(
	id_ticket int(11) DEFAULT NULL,
	qt_reopened int(11) DEFAULT NULL,
	time_opened int(11) DEFAULT NULL,
	time_pending int(11) DEFAULT NULL,
	time_solution int(11) DEFAULT NULL,
	survey_send int(11) DEFAULT NULL,
	survey_receive int(11) DEFAULT NULL,
	-- SK
	sk_type int(11) DEFAULT NULL,
	sk_state int(11) DEFAULT NULL,
	sk_dt_opened int(11) DEFAULT NULL,
	sk_queue_opened int(11) DEFAULT NULL,
	sk_dt_finish int(11) DEFAULT NULL,
	sk_queue_finish int(11) DEFAULT NULL,
	sk_priority int(11) DEFAULT NULL,
	sk_service int(11) DEFAULT NULL,
	sk_sla int(11) DEFAULT NULL,
	sk_customer int(11) DEFAULT NULL,
	sk_user_create int(11) DEFAULT NULL,
	sk_user_finish int(11) DEFAULT NULL,
    -- Indexes
    KEY idx_id_ticket (id_ticket)
);

