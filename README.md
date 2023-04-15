# DayNightProject
set echo on
set feedback on
set linesize 150
set pagesize 50
drop table maintain cascade constraints;
drop table incident cascade constraints;
drop table shift cascade constraints;
drop table qualification cascade constraints;
drop table fueluse cascade constraints;
drop table cab cascade constraints;
drop table driver cascade constraints;
create table cab (Ca_cabnum varchar2(3) primary key, Ca_make varchar2(10) not null,
Ca_model varchar2(15) not null, Ca_year varchar2(2) not null, Ca_purdate date not null,
Ca_licnum varchar2(8) not null, Ca_condition varchar2(38) not null, Ca_cabstatus varchar2(1) 
not null, Ca_fuelcapacity varchar2(5) not null, Ca_basefare number not null, 
Ca_mileagecharge number not null);
drop table driver;
create table driver (Dr_drvnum varchar2(4) primary key, Dr_drvname varchar2(30) not null, 
Dr_drvstreet varchar2(30) not null, Dr_drvcity varchar2(15) not null, Dr_drvstate varchar2(2) not null,
Dr_drvzip varchar2(5) not null, Dr_drvphone varchar2(10) not null, Dr_drvlic varchar2(10) not null,
Dr_drvlicdate date not null, Dr_drvstatus varchar2(20) not null, Dr_brthdate date not null, 
Dr_jobcode number not null, Dr_salary number not null, Dr_hiredate date not null);
create table maintain (Ma_cabnum varchar2(3), Ma_maindate date not null, Ma_maintype varchar2(30)
not null, Ma_mainodom number not null, Ma_cost number(10,2) not null, Ma_lastdrvnum varchar2(4) 
not null,
primary key (Ma_cabnum, Ma_maindate, Ma_maintype), 
foreign key (Ma_cabnum) references cab (Ca_cabnum) on delete cascade, 
foreign key (Ma_lastdrvnum) references driver (Dr_drvnum) on delete cascade);
create table shift (Sh_wkdate date, Sh_wkshift varchar2(3), Sh_cabnum varchar2(3), Sh_drvnum varchar2(4)
not null, Sh_wkflag varchar2(1), Sh_odomrdg1 number, Sh_odomrdg2 number, 
Sh_numfares number, 
primary key (Sh_wkdate, Sh_wkshift, Sh_cabnum),
foreign key (Sh_cabnum) references cab(Ca_cabnum) on delete cascade,
foreign key (Sh_drvnum) references driver (Dr_drvnum) on delete cascade,
check (Sh_odomrdg2 > Sh_odomrdg1));
create table incident (Ic_cabnum varchar2(3) not null, Ic_wkdate date, Ic_wkshift varchar2(3), 
Ic_incitype varchar2(15) not null, Ic_details varchar2(200),
foreign key (Ic_cabnum, Ic_wkdate, Ic_wkshift) references shift (Sh_cabnum, Sh_wkdate, Sh_wkshift) on delete cascade);
create table qualification (Qu_drvnum varchar2(4), Qu_cabnum varchar2(3), 
primary key (Qu_drvnum, Qu_cabnum), 
foreign key (Qu_cabnum) references cab (Ca_cabnum) on delete cascade,
foreign key (Qu_drvnum) references driver (Dr_drvnum) on delete cascade);
create table fueluse (Ful_cabnum varchar2(3), Ful_fueldate date not null, Ful_numgal number not null,
Ful_fuelcode varchar2(1) not null, Ful_pricegal number (6,2) not null, Ful_fuelbrand varchar2(10) not null,
primary key (Ful_cabnum, Ful_fueldate), foreign key (Ful_cabnum) references cab (Ca_cabnum)
on delete cascade);
insert into cab values ('006', 'Checker', '4-Door Sedan', '92', '17-JUL-2007', 'TX997IUF', 
  'Needs New Brake Pads', 'F', '25Gal', 2.50, 1.09);
insert into cab values ('105', 'Checker', '4-Door Sedan', '96', '12-JUL-2011', 'LA867PDP', 
  'Excellent', 'T', '28Gal', 2.50, 1.09);
insert into cab values ('144', 'Ford', '4-Door Sedan', '93', '23-JUL-2010', 'TX324UED', 
  'Excellent', 'T', '23Gal', 2.25, 0.99);
insert into cab values ('215', 'Ford', '4-Door Sedan', '99', '12-SEP-2014', 'TX290ZPZ',
  'Needs Major Body Works', 'F', '23Gal', 1.52, .89);
insert into cab values ('619', 'Chrysler', '4-Door Sedan', '00', '03-MAR-2016', 'FLQWE567',
  'Back Seat Chewed By Alligator', 'T', '23Gal', 2.76, 1.18);
insert into cab values ('108', 'Ford', '4-Door Sedan', '96', '09-DEC-2015', 'LA456WQQ',
  'Needs New Tires Soon', 'T', '20Gal', 1.97, 1.03);
insert into cab values ('778', 'Dodge', 'Minivan', '02', '02-JUL-2019', 'TXURR123',
  'Needs New Radio', 'T', '28Gal', 5.25, 1.50);
insert into cab values ('241', 'Cadillac', 'Stretch Limo', '02', '14-MAR-2019', 'TXBEW100',
  'Excellent', 'T', '40Gal', 20.00, 4.25);
insert into cab values ('452', 'Chevrolet', '4-Door Sedan', '02', '06-JUN-2019', 'CATOW125',
  'Should Be Repainted', 'T', '26Gal', 2.25, 1.08);
insert into cab values ('777', 'Dodge', 'Minivan', '02', '09-DEC-2006', 'NJ234UEL',
  'Needs Minor Tune Up', 'T', '28Gal', 6.09, 2.09);
insert into cab values ('083', 'Checker', '4-Door Sedan', '97', '25-JAN-2015', 'TXGMS412',
  'No Spare Tire', 'F', '25Gal', 1.95, 1.05);
insert into cab values ('479', 'Chrysler', '4-Door Sedan', '01', '08-OCT-2016', 'TXVLC562', 
  'Right Side Rear View Mirror Missing', 'T', '27Gal', 2.50, 1.19);
insert into cab values ('404', 'Dodge', '4-Door Sedan', '00', '08-OCT-2014', 'ARYTP231', 
  'Needs Bright Lights Repaired', 'T', '23Gal', 2.09, 1.09);
insert into cab values ('455', 'Chevrolet', '4-Door Sedan', '02', '16-OCT-2019', 'TXF63RWQ',
  'Excellent - Brand New', 'T', '25Gal', 2.57, 1.36);
insert into cab values ('433', 'Mercedes', '4-Door Sedan', '99', '17-MAR-2015', 'ORRWQ043',
  'Needs Lubrication', 'T', '28Gal', 5.00, 1.50);
insert into cab values ('106', 'Lincoln', '4-Door Sedan', '94', '23-JUL-2010', 'NY123BWW',
  'Rear View Mirror Missing', 'F', '27Gal', 4.75, 1.20);
insert into cab values ('064', 'Mercedes', 'Stretch Limo', '98', '01-JUN-2016', 'TXTWQ490',
  'Excellent', 'T', '43Gal', 22.00, 5.49);
insert into driver values ('0001', 'Cooper, Randolph B.', '12452 Rollingwood', 'Houston',
  'TX', '77024', '7134654667', 'TX56734512', '12-DEC-2019', 'Pay After', '03-MAR-1975', 
  52, 55000, '01-MAR-2000');
insert into driver values ('0002', 'Parks, Michael S.', '3602 Aberdeen', 'Houston',
  'TX', '77025', '7135216790', 'TX71233300', '15-DEC-2019', 'Pay Before', '03-APR-1974',
   53, 58500, '19-MAR-2000');
insert into driver values ('0003', 'Mitchell, A. Cameron', '6230 Teal', 'Bellaire', 
  'TX', '77401', '7136224876', 'TX87734231', '03-DEC-2019', 'Pay Before', '30-APR-1960', 
   53, 52000, '23-JUL-2001');
insert into driver values ('0005', 'Hirschheim, Rudolph', '7234 Collingsworth', 'Houston',
  'TX', '77034', '2814783278', 'NY12398421', '17-DEC-2022', 'Pay After', '23-OCT-1973', 
  52, 70000, '20-JUL-2005');
insert into driver values ('0006', 'Adams, Dennis A.', '345 Willowbend Trail', 'Kemah',
  'TX', '77498', '2816782356', 'TX50562311', '17-DEC-2022', 'Pay After', '09-DEC-1977',
  52, 60000, '21-JAN-2003');
insert into driver values ('0007', 'Silva, Leiser', '125 Bay Oaks Boulevard', 'Houston',
  'TX', '77062', '2813425672', 'TX09932341', '23-JUL-2022', 'Pay Before', '30-SEP-1984',
  53, 49000, '26-AUG-2018);
insert into driver values ('0008', 'Chin, Wynne', '3476 Windswept Drive', 'Houston',
  'TX', '77005', '7135673278', 'MI21367320', '16-DEC-2022', 'Pay After', '04-MAY-1981',
  53, 66000, '04-JUL-2013);
insert into driver values ('0010', 'Ives, Blake', '230 Inwood', 'Houston',
  'TX', '77019', '7135220912', 'LA27612098', '23-JAN-2022', 'Pay Before', '09-JUN-1965',
  52, 87500, '26-AUG-2016');
insert into driver values ('0011', 'Stinson, James B.', '44 Thornhill Trail', 'Houston',
  'TX', '77024', '7134652313', 'TX70023150', '21-DEC-2022', 'Pay After', '02-MAR-1968',
  55, 63500, '21-DEC-2016');
insert into driver values ('0012', 'McGillis, William', '325 Mockingbird Circle', 'Bellaire',
  'TX', '77401', '7136642381', 'NM49012600', '01-DEC-2022', 'Do Not Reserve', '03-DEC-1985',
  55, 52000, '03-JUL-2011');
insert into driver values ('0013', 'Pettit, R. Richardson', '712 Sunburst', 'Humble',
  'TX', '77312', '2817823098', 'WA21689012', '14-DEC-2022', 'Pay After', '23-AUG-1962',
  52, 80000, '02-FEB-1999');
insert into driver values ('0014', 'Keller, Robert T.', '234 Columbia Lakes', 'Houston',
  'TX', '77024', '7134653200', 'TX43456709', '11-DEC-2022', 'Pay Before', '09-SEP-1965',
  53, 60523, '03-MAR-1997');
insert into driver values ('0015', 'Scamell, Richard W.', '64 Rhoda Avenue', 'Nutley',
  'NJ', '07123', '2014532367', 'NJ02311145', '13-NOV-2022', 'Do Not Reserve', '04-Mar-1929',
  53, 25000, '09-JUN-1947');
insert into driver values ('0016', 'Thomas, Wes', '3421 Amherst', 'Houston', 
  'TX', '77030', '7135632255', 'TX79043245', '23-DEC-2022', 'Pay Before', '25-NOV-1974',
  52, 59000, '04-JUL-2018');
insert into driver values ('0018', 'Brewer, Elaine', '7523 Quail Valley', 'Houston',
  'TX', '77075', '2817703434', 'TX72390912', '18-DEC-2022', 'Pay After', '03-MAR-1986',
  53, 52500, '08-JUL-2000');
insert into driver values ('0019', 'Curl, Joe', '2314 Robinwood Parkway', 'Nassau Bay',
  'TX', '77623', '4092343200', 'MI62314590', '18-DEC-2022', 'Pay After', '06-JUL-1973',
  54, 61300, '02-MAR-2014');
insert into driver values ('0030', 'Stansbury, M. Todd', '1011 Banks', 'Houston',
  'TX', '77005', '7135246008', 'GA90534234', '03-DEC-2022', 'Do Not Reserve', '12-DEC-1980',
  52, 55000, '06-JUL-2022');
insert into driver values ('0031', 'Szilagyi, Andrew S.', '4400 Woodland Estates', 'Houston',
  'TX', '77070', '2813702170', 'TX12045623', '16-DEC-2022', 'Pay After', '02-JUL-1968',
  55, 65000, '23-JAN-1995');
insert into driver values ('0004', 'Newman, Andrew W.', '12507 Coronado Valley', 
  'San Diego', 'CA', '95231', '2144892607', 'CA71209704', '19-DEC-2022', 'Do Not Reserve', 
  '16-JAN-1990', 55, 52000, '12-JUL-2013');
insert into driver values ('0017', 'Hickman, Ronald S.', '9341 Greensward', 'Houston',
  'TX', '77080', '7134651200', 'TX00843412', '21-FEB-2022', 'Pay Before', '03-SEP-1962',
  52, 58400, '20-APR-1996');
insert into driver values ('0040', 'Mehta, Rahul B.', '14423 Old Oaks', 'Houston',
  'TX', '77079', '2814617893', 'TX33312789', '10-DEC-2022', 'Pay After', '24-SEP-1980',
  55, 90000, '10-MAY-2015');
insert into driver values ('0041', 'Taylor, David S.', '6243 Brompton Boulevard', 'Houston',
  'TX', '77005', '7135237890', 'NJ30098523', '17-DEC-2022', 'Pay Before', '12-JUL-1981',
  55, 51500, '12-JUL-2011');
insert into driver values ('0026', 'Newman, Christopher P.', '723 Sampson', 'Houston',
  'TX', '77008', '7135204578', 'TX23167802', '12-NOV-2022', 'Do Not Reserve', '09-SEP-1988',
  52, 50000, '20-AUG-2016');
insert into maintain values ('105', '15-JUL-2022', 'Tune-Up', 40342, 125.42, '0002');
insert into maintain values ('105', '01-OCT-2022', 'Adjust Front End', 42120, 246.12, '0006');
insert into maintain values ('215', '01-SEP-2022', 'Replace Battery', 96453, 75, '0016');
insert into maintain values ('215', '01-SEP-2022', 'Tune-Up', 96453, 145, '0016');
insert into maintain values ('215', '20-SEP-2022', 'New Transmission', 98342, 875.90, '0019');
insert into maintain values ('083', '12-OCT-2022', 'Replace Radiator', 55434, 650.00, '0015');
insert into maintain values ('619', '12-SEP-2022', 'Tune-Up and Lubrication', 86023, 214.25, '0004');
insert into maintain values ('778', '15-AUG-2022', 'Replace Carpets', 85023, 1250.00, '0006');
insert into maintain values ('241', '28-AUG-2022', 'Replace Wet Bar', 25034, 750.00, '0005');
insert into maintain values ('006', '09-OCT-2022', 'New Paint Job', 85212, 450.00, '0030');
insert into maintain values ('777', '22-AUG-2022', 'Repair Oil Leak', 74378, 170.00, '0031');
insert into maintain values ('108', '30-AUG-2022', 'Install New Air Conditioner', 68903, 850.00, '0001');
insert into maintain values ('108', '03-OCT-2022', 'Replace Headliner', 70452, 350.00, '0001');
insert into maintain values ('108', '06-OCT-2022', 'Adjust Headliner', 71902, 12.50, '0001');
insert into maintain values ('241', '04-SEP-2022', 'Complete Detail', 26900, 375.50, '0005');
insert into maintain values ('777', '12-OCT-2022', 'Replace Left Rear Tire', 79324, 25, '0011');
insert into maintain values ('619', '15-OCT-2022', 'Install Rebuilt Transmission', 91145, 1259.99, '0004');
insert into maintain values ('778', '29-SEP-2022', 'Replace Front Seat Cover', 91032, 525.00, '0014');
insert into maintain values ('619', '23-AUG-2022', 'Replace Front Windshield', 83128, 757.43, '0004');
insert into maintain values ('452', '13-OCT-2022', 'Install Four New Tires', 92043, 552.09, '0019');
insert into maintain values ('404', '19-OCT-2022', 'Lubrication', 100454, 45.21, '0040');
insert into shift values ('15-NOV-2022', 'DAY', '404', '0011', 'T', 102250, 102275, 3);
insert into shift values ('15-NOV-2022', 'EVE', '404', '0012', 'T', 102275, 102482, 8);
insert into shift values ('15-NOV-2022', 'DAY', '455', '0019', 'T', 60105, 60199, 10);
insert into shift values ('15-NOV-2022', 'NIG', '404', '0001', 'T', 102482, 102720, 14);
insert into shift values ('15-NOV-2022', 'DAY', '479', '0013', 'T', 75111, 75423, 6);
insert into shift values ('15-NOV-2022', 'EVE', '455', '0017', 'T', 60340, 60420, 5);
insert into shift values ('15-NOV-2022', 'EVE', '144', '0001', 'T', 96100, 96140, 3);
insert into shift values ('15-NOV-2022', 'NIG', '144', '0002', 'T', 96140, 96540, 18);
insert into shift values ('15-NOV-2022', 'DAY', '006', '0018', 'T', 88430, 88510, 12);
insert into shift values ('15-NOV-2022', 'NIG', '215', '0005', 'F', NULL, NULL, NULL);
insert into shift values ('16-NOV-2022', 'DAY', '006', '0018', 'T', 88510, 88590, 4);
insert into shift values ('16-NOV-2022', 'EVE', '778', '0018', 'T', 90590, 90603, 6);
insert into shift values ('16-NOV-2022', 'DAY', '215', '0014', 'T', 97006, 97105, 7);
insert into shift values ('16-NOV-2022', 'NIG', '006', '0006', 'T', 90212, 90423, 11);
insert into shift values ('16-NOV-2022', 'EVE', '006', '0001', 'T', 89002, 89212, 6);
insert into shift values ('16-NOV-2022', 'EVE', '777', '0017', 'T', 80230, 80356, 6);
insert into shift values ('16-NOV-2022', 'NIG', '777', '0015', 'T', 80356, 80452, 9);
insert into shift values ('16-NOV-2022', 'DAY', '241', '0014', 'T', 26892, 26999, 8);
insert into shift values ('16-NOV-2022', 'DAY', '619', '0008', 'F', NULL, NULL, NULL);
insert into shift values ('16-NOV-2022', 'DAY', '777', '0008', 'F', NULL, NULL, NULL);
insert into shift values ('16-NOV-2022', 'DAY', '479', '0004', 'T', 75423, 75586, 7);
insert into shift values ('16-NOV-2022', 'DAY', '083', '0017', 'T', 54231, 54298, 4);
insert into shift values ('16-NOV-2022', 'EVE', '479', '0013', 'T', 75586, 75693, 9);
insert into shift values ('17-NOV-2022', 'DAY', '083', '0017', 'T', 59654, 59685, 1);
insert into shift values ('17-NOV-2022', 'DAY', '215', '0014', 'T', 97105, 97245, 6);
insert into shift values ('17-NOV-2022', 'DAY', '144', '0018', 'T', 96540, 96683, 8);
insert into shift values ('17-NOV-2022', 'EVE', '108', '0006', 'F', NULL, NULL, NULL); 
insert into shift values ('17-NOV-2022', 'EVE', '619', '0010', 'T', 93235, 93282, 2);
insert into shift values ('17-NOV-2022', 'NIG', '215', '0010', 'T', 97199, 97399, 3);
insert into shift values ('17-NOV-2022', 'NIG', '619', '0010', 'T', 93282, 93498, 8);
insert into shift values ('17-NOV-2022', 'NIG', '083', '0017', 'T', 59685, 59755, 3);
insert into shift values ('17-NOV-2022', 'DAY', '778', '0015', 'F', NULL, NULL, NULL);
insert into shift values ('17-NOV-2022', 'DAY', '105', '0008', 'T', 45123, 45213, 7);
insert into shift values ('17-NOV-2022', 'EVE', '778', '0012', 'T', 92112, 92420, 15);
insert into shift values ('17-NOV-2022', 'EVE', '006', '0030', 'T', 88603, 88723, 5);
insert into shift values ('17-NOV-2022', 'EVE', '083', '0017', 'T', 59526, 59685, 4);
insert into shift values ('18-NOV-2022', 'DAY', '006', '0018', 'T', 88723, 88912, 6);
insert into shift values ('18-NOV-2022', 'EVE', '777', '0031', 'T', 80452, 80644, 4);
insert into shift values ('18-NOV-2022', 'DAY', '215', '0040', 'T', 97399, 97612, 8);
insert into shift values ('18-NOV-2022', 'NIG', '083', '0026', 'T', 59685, 59912, 10);
insert into shift values ('18-NOV-2022', 'NIG', '144', '0004', 'T', 96683, 97012, 8);
insert into shift values ('18-NOV-2022', 'DAY', '241', '0007', 'T', 26999, 27210, 9);
insert into shift values ('18-NOV-2022', 'DAY', '083', '0014', 'T', 79245, 79462, 5);
insert into shift values ('18-NOV-2022', 'EVE', '108', '0010', 'T', 78121, 78352, 7);
insert into shift values ('18-NOV-2022', 'NIG', '479', '0019', 'F', NULL, NULL, NULL);
insert into shift values ('18-NOV-2022', 'DAY', '404', '0018', 'T', 102720, 102812, 5);
insert into qualification values ('0001', '006');
insert into qualification values ('0001', '144');
insert into qualification values ('0001', '404');
insert into qualification values ('0001', '777');
insert into qualification values ('0002', '144');
insert into qualification values ('0002', '455');
insert into qualification values ('0002', '105');
insert into qualification values ('0002', '006');
insert into qualification values ('0002', '241');
insert into qualification values ('0002', '778');
insert into qualification values ('0003', '083');
insert into qualification values ('0003', '404');
insert into qualification values ('0003', '215');
insert into qualification values ('0004', '479');
insert into qualification values ('0004', '619');
insert into qualification values ('0004', '777');
insert into qualification values ('0005', '144');
insert into qualification values ('0005', '404');
insert into qualification values ('0005', '452');
insert into qualification values ('0005', '455');
insert into qualification values ('0005', '479');
insert into qualification values ('0006', '006');
insert into qualification values ('0006', '619');
insert into qualification values ('0008', '105');
insert into qualification values ('0008', '215');
insert into qualification values ('0008', '452');
insert into qualification values ('0008', '455');
insert into qualification values ('0010', '105');
insert into qualification values ('0010', '108');
insert into qualification values ('0010', '144');
insert into qualification values ('0010', '215');
insert into qualification values ('0010', '241');
insert into qualification values ('0010', '619');
insert into qualification values ('0011', '083');
insert into qualification values ('0012', '083');
insert into qualification values ('0012', '108');
insert into qualification values ('0012', '778');
insert into qualification values ('0013', '479');
insert into qualification values ('0013', '619');
insert into qualification values ('0014', '215');
insert into qualification values ('0014', '241');
insert into qualification values ('0014', '452');

insert into qualification values ('0015', '006');
insert into qualification values ('0015', '144');
insert into qualification values ('0015', '777');
insert into qualification values ('0015', '404');
insert into qualification values ('0017', '006');
insert into qualification values ('0017', '083');
insert into qualification values ('0017', '105');
insert into qualification values ('0017', '108');
insert into qualification values ('0017', '144');
insert into qualification values ('0017', '215');
insert into qualification values ('0017', '241');
insert into qualification values ('0017', '404');
insert into qualification values ('0017', '452');
insert into qualification values ('0017', '455');
insert into qualification values ('0017', '479');
insert into qualification values ('0017', '619'); 
insert into qualification values ('0017', '778');
insert into qualification values ('0017', '777');
insert into qualification values ('0017', '433');
insert into qualification values ('0017', '106');
insert into qualification values ('0017', '064');
insert into qualification values ('0018', '006');
insert into qualification values ('0017', '777');
insert into qualification values ('0018', '108');
insert into qualification values ('0018', '144');
insert into qualification values ('0018', '404');
insert into qualification values ('0018', '452');
insert into qualification values ('0018', '778');
insert into qualification values ('0019', '083');
insert into qualification values ('0019', '105');
insert into qualification values ('0019', '215');
insert into qualification values ('0019', '241');
insert into qualification values ('0019', '455');
insert into qualification values ('0019', '479');
insert into qualification values ('0019', '619');
insert into qualification values ('0019', '777');
insert into qualification values ('0030', '006');
insert into qualification values ('0030', '144');
insert into qualification values ('0030', '404');
insert into qualification values ('0030', '455');
insert into qualification values ('0030', '777');
insert into qualification values ('0030', '778');
insert into fueluse values ('006', '12-OCT-2022', 23, 'R', 1.44, 'SHELL');
insert into fueluse values ('105', '12-OCT-2022', 24.5, 'R', 1.42, 'EXXONMOBIL');
insert into fueluse values ('144', '13-OCT-2022', 20, 'R', '1.43', 'SHELL');
insert into fueluse values ('215', '13-OCT-2022', 15.3, 'R', 1.43, 'SHELL');
insert into fueluse values ('619', '13-OCT-2022', 17.4, 'S', 1.52, 'TEXACO');
insert into fueluse values ('108', '13-OCT-2022', 18.6, 'R', 1.44, 'MOBIL');
insert into fueluse values ('778', '13-OCT-2022', 25, 'S', 1.55, 'EXXONMOBIL');
insert into fueluse values ('241', '14-OCT-2022', 42.5, 'P', 1.67, 'EXXONMOBIL');
insert into fueluse values ('452', '14-OCT-2022',23.1, 'R', 1.41, 'STOP-GO');
insert into fueluse values ('777', '14-OCT-2022',17.5, 'R', 1.43, 'TEXACO');
insert into fueluse values ('083', '14-OCT-2022',10.4, 'R', 1.47, 'CHEVRON');
insert into fueluse values ('479', '14-OCT-2022',26.2, 'S', 1.58, 'EXXONMOBIL');
insert into fueluse values ('404', '14-OCT-2022',20, 'R', 1.42, 'STOP-GO');
insert into fueluse values ('455', '14-OCT-2022',21.5, 'R', 1.45,'TEXACO'); 
insert into fueluse values ('455', '17-OCT-2022',19.8, 'R', 1.43, 'EXXONMOBIL');
insert into fueluse values ('452', '17-OCT-2022',15.2, 'R', 1.42, 'TEXACO');
insert into fueluse values ('006', '18-OCT-2022', 20.2, 'R', 1.44, 'MOBIL');
insert into fueluse values ('144', '19-OCT-2022', 18.3, 'R', 1.4, 'CHEVRON');
insert into fueluse values ('108', '20-OCT-2022', 19.9, 'R', 1.43, 'EXXONMOBIL'); 
insert into fueluse values ('083', '20-OCT-2022', 17.3, 'R', 1.46, 'SHELL');
insert into fueluse values ('404', '21-OCT-2022', 19.2, 'R', 1.45, 'SHELL');
insert into fueluse values ('105', '23-OCT-2022', 25, 'R', 1.41, 'EXXONMOBIL');
insert into fueluse values ('215', '23-OCT-2022', 20.7, 'R', 1.72, 'STOP-GO');
insert into fueluse values ('006', '25-OCT-2022', 27.3, 'R', 1.59, 'CHEVRON');
insert into fueluse values ('452', '26-OCT-2022', 15.3, 'R', 1.57, 'TEXACO');
insert into fueluse values ('241', '27-OCT-2022', 40, 'R', 1.45, 'SHELL');
insert into fueluse values ('479', '28-OCT-2022', 25.2, 'S', 1.55, 'TEXACO');
insert into fueluse values ('215', '28-OCT-2022', 22.2, 'S', 1.42, 'STOP-GO');
insert into fueluse values ('241', '01-NOV-2022', 36.2, 'P', 1.71, 'EXXONMOBIL');
insert into fueluse values ('006', '02-NOV-2022', 23.7, 'S', 1.6, 'EXXONMOBIL');
insert into fueluse values ('404', '03-NOV-2022', 19.3, 'R', 1.41, 'TEXACO');
insert into fueluse values ('144', '03-NOV-2022', 20.1, 'R', 1.39, 'CHEVRON');
insert into fueluse values ('215', '04-NOV-2022', 4.5, 'R', 1.42, 'SHELL');

insert into fueluse values ('778', '05-NOV-2022', 24, 'S', 1.56, 'MOBIL');
insert into fueluse values ('083', '06-NOV-2022', 17.4, 'R', 1.44, 'EXXONMOBIL');
insert into fueluse values ('083', '08-NOV-2022', 3.2, 'R', 1.43, 'CHEVRON');
insert into fueluse values ('144', '06-NOV-2022', 20.5, 'R', 1.43, 'SHELL');
insert into fueluse values ('144', '07-NOV-2022', 10.8, 'R', 1.41, 'STOP-GO');
insert into fueluse values ('144', '08-NOV-2022', 7.4, 'R', 1.46, 'SHELL'); 
insert into fueluse values ('452', '09-NOV-2022', 24.2, 'R', 1.42, 'SHELL');
insert into fueluse values ('619', '10-NOV-2022', 19.6, 'S', 1.59, 'MOBIL');
insert into fueluse values ('105', '11-NOV-2022', 20.1, 'R', 1.42, 'EXXONMOBIL');
insert into fueluse values ('006', '12-NOV-2022', 24.2, 'R', 1.39, 'STOP-GO');
insert into fueluse values ('778', '13-NOV-2022', 23, 'S', 1.56, 'TEXACO');
insert into fueluse values ('241', '14-NOV-2022', 46, 'P', 1.73, 'EXXONMOBIL');
insert into fueluse values ('455', '15-NOV-2022', 22, 'R', 1.45, 'SHELL');
insert into fueluse values ('144', '16-NOV-2022', 19.1, 'R', 1.42, 'SHELL');
insert into fueluse values ('452', '17-NOV-2022', 18.5, 'R', 1.4, 'TEXACO');
insert into fueluse values ('241', '18-NOV-2022', 42, 'P', 1.69, 'EXXONMOBIL');
insert into fueluse values ('479', '19-NOV-2022', 23, 'S', 1.61, 'CHEVRON');
insert into fueluse values ('006', '20-NOV-2022', 23.3, 'R', 1.41, 'STOP-GO');
insert into fueluse values ('215', '21-NOV-2022', 18.3, 'R', 1.45, 'EXXONMOBIL');
insert into fueluse values ('215', '22-NOV-2022', 7.3, 'R', 1.43, 'TEXACO');
insert into fueluse values ('083', '22-NOV-2022', 19.2, 'R', 1.43, 'TEXACO');
insert into fueluse values ('006', '23-NOV-2022', 16.2, 'R', 1.45, 'EXXONMOBIL');
insert into fueluse values ('455', '24-NOV-2022', 21.9, 'R', 1.4, 'SHELL');

insert into fueluse values ('777', '25-NOV-2022', 30, 'S', 1.56, 'CHEVRON');
insert into fueluse values ('777', '26-NOV-2022', 20.4, 'S', 1.57, 'EXXONMOBIL');
insert into fueluse values ('479', '27-NOV-2022', 18.4, 'S', 1.58, 'EXXONMOBIL');
insert into fueluse values ('452', '28-NOV-2022', 13.5, 'R', 1.56, 'CHEVRON');
insert into fueluse values ('108', '29-NOV-2022', 18.3, 'R', 1.48, 'MOBIL');
insert into fueluse values ('105', '30-NOV-2022', 29.4, 'R', 1.41, 'SHELL');
insert into fueluse values ('619', '01-DEC-2022', 15.9, 'S', 1.43, 'STOP-GO');
insert into fueluse values ('479', '02-DEC-2022', 27, 'S', 1.44, 'EXXONMOBIL');
insert into fueluse values ('778', '03-DEC-2022', 15.6, 'R', 1.48, 'CHEVRON');
insert into fueluse values ('452', '04-DEC-2022', 13.5, 'R', 1.59, 'TEXACO');
insert into incident values ('215', '15-NOV-2022', 'NIG', 'TICKET', 'SPEEDING');
insert into incident values ('215', '15-NOV-2022', 'NIG', 'TICKET', 'SPEEDING');
insert into incident values ('215', '15-NOV-2022', 'NIG', 'TICKET', 'SPEEDING');
insert into incident values ('215', '18-NOV-2022', 'DAY', 'ACCIDENT', 'CAB PARKED IN FRONT OF TOWERS DORM 
ON THE UNIVERSITY OF HOUSTON CAMPUS.  REAR-ENDED BY CAR DRIVEN BY FACULTY MEMBER SPEEDING DOWN
THE STREET.  NO ONE INJURED.');
insert into incident values ('144', '15-NOV-2022', 'NIG', 'TICKET', 'ILLEGAL PARKING');
insert into incident values ('144', '15-NOV-2022', 'EVE', 'TICKET', 'FAILURE TO STOP AT STOP SIGN');
insert into incident values ('215', '16-NOV-2022', 'DAY', 'ACCIDENT', 'DROVE INTO DRAINAGE DITCH ALONG 
GRANT ROAD.  LITTLE DAMAGE.  NO ONE INJURED');
insert into incident values ('777', '16-NOV-2022', 'EVE', 'TICKET', 'SPEEDING');
insert into incident values ('778', '17-NOV-2022', 'EVE', 'TICKET', 'READING BURRELL AND MORGAN 
WHILE DRIVING THROUGH RED LIGHT ON LEXINGTON BLVD');
insert into incident values ('083', '17-NOV-2022', 'EVE', 'TICKET', 'DRIVING WITH ONLY ONE HEADLIGHT');
insert into incident values ('215', '18-NOV-2022', 'DAY', 'TICKET', 'FAILURE TO SIGNAL WHEN 
 CHANGING LANES ON BUFFALO SPEEDWAY');
insert into incident values ('777', '16-NOV-2022', 'EVE', 'TICKET', 'SPEEDING');
insert into incident values ('144', '15-NOV-2022', 'EVE', 'TICKET', 'SPEEDING');
insert into incident values ('108', '17-NOV-2022', 'EVE', 'ACCIDENT', 'CAR HIT BY LIGHTING WHILE 
PARKED IN COMPANY PARKING LOT');
insert into incident values ('619', '17-NOV-2022', 'EVE', 'TICKET', 'ILLEGAL PARKING');
insert into incident values ('083', '17-NOV-2022', 'NIG', 'TICKET', 'RAN RED LIGHT AT CORNER OF BUFFALO SPEEDWAY AND UNIVERSITY BOULEVARD');
insert into incident values ('006', '16-NOV-2022', 'DAY', 'TICKET', 'SPEEDING');
insert into incident values ('006', '18-NOV-2022', 'DAY', 'TICKET', 'PARKED IN FRONT OF FIRE HYDRANT');
insert into incident values ('455', '15-NOV-2022', 'DAY', 'TICKET', 'SPEEDING');
commit;
column ca_cabnum format a9
column ca_year format a7
Column ca_purdate format a10
column ca_licnum format a9
column ca_cabstatus format a12
column ca_fuelcapacity format a20
describe cab
select * from cab;

column dr_drvnum format a9
column dr_drvstate format a12
column dr_drvzip format a9
column dr_drvphone format a12
column dr_drvlicdate format a15
column dr_brthdate format a12
column dr_hiredate format a12
describe driver;
select * from driver;

column sh_wkshift format a10
column sh_cabnum format a9
column sh_drvnum format a9
column sh_wkflag format a9
describe shift
select * from shift;

column ma_cabnum format a9
column ma_maindate format a11
column ma_lastdrvnum format a15
desc maintain
Select * from maintain;

column ic_cabnum format a9
column ic_wkshift format a10
column ic_details format a100
describe incident
Select * from incident;

column qu_drvnum format a12
column qu_cabnum format a12
describe qualification
Select * from qualification;

column ful_cabnum format a10
column ful_fueldate format a13
column ful_fuelcode format a13
column ful_fuelbrand format a15
describe fueluse
Select * from fueluse;
