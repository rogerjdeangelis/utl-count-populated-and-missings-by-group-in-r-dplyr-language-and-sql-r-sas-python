%let pgm=utl-count-populated-and-missings-by-group-in-r-dplyr-language-and-sql-r-sas-python;

%stop_submission;

Count populated and missings by group in r and sql r sas python


github
https://tinyurl.com/7d4zajcc
https://github.com/rogerjdeangelis/utl-count-populated-and-missings-by-group-in-r-dplyr-language-and-sql-r-sas-python

stackoverflow
https://tinyurl.com/3ajr9w4c
https://stackoverflow.com/questions/79065739/use-of-conditionals-with-group-by

        SOLUTIONS

           1 sas sql
           2 r sql
           3 python sql
           4 r dplyr language
             https://stackoverflow.com/users/12586249/mikebader

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

/**************************************************************************************************************************/
/*                               |                                                  |                                     */
/*       INPUT                   |           PROCESS                                |         OUTPUT                      */
/*       =====                   |           =======                                |         ======                      */
/*                               |                                                  |                                     */
/*   ITEM    TIME     PPT        |        SELF EXPLANATORY SQL                      |  ITEM    PPT  POPULATED MISSING     */
/*                               |        SAME CODE IN SAS, R AND PYTHON            |                                     */
/*    1               ppt1       |        ==============================            |   1      ppt1     1         9       */
/*    1               ppt1       |                                                  |   2      ppt1     0        10       */
/*    1               ppt1       |        select                                    |   3      ppt1     0        10       */
/*    1               ppt1       |           item                                   |   4      ppt1     1         9       */
/*    1      1.456    ppt1       |           ,ppt                                   |                                     */
/*    1               ppt1       |           ,sum(not missing(time)) as populated   |                                     */
/*    1               ppt1       |           ,sum(    missing(time)) as missing     |                                     */
/*    1               ppt1       |        from                                      |                                     */
/*    1               ppt1       |          sd1.have                                |                                     */
/*    1               ppt1       |        group                                     |                                     */
/*    2               ppt1       |          by item,  ppt                           |                                     */
/*    2               ppt1       |                                                  |                                     */
/*    2               ppt1       |                                                  |                                     */
/*    2               ppt1       |        R USING DPLYR LANGUAGE (MUTATE,== & %>%)  |                                     */
/*    2               ppt1       |        ========================================  |                                     */
/*    2               ppt1       |                                                  |                                     */
/*    2               ppt1       |        mutate(time_mi =                          |                                     */
/*    2               ppt1       |         if_else(TIME == "", "NA", "Value")) %>%  |                                     */
/*    2               ppt1       |        group_by(PPT, ITEM) %>%                   |                                     */
/*    2               ppt1       |        summarize(                                |                                     */
/*    3               ppt1       |            N_NAs = sum(time_mi == "NA"),         |                                     */
/*    3               ppt1       |            N_Values = sum(time_mi == "Value")    |                                     */
/*    3               ppt1       |                                                  |                                     */
/*    3               ppt1       |                                                  |                                     */
/*    3               ppt1       |                                                  |                                     */
/*    3               ppt1       |   ITEM    TIME     PPT   9 MISSING, 1 POPULATED  |                                     */
/*    3               ppt1       |                                                  |                                     */
/*    3               ppt1       |    1               ppt1   Missing                |                                     */
/*    3               ppt1       |    1               ppt1   Missing                |                                     */
/*    3               ppt1       |    1               ppt1   Missing                |                                     */
/*    4               ppt1       |    1               ppt1   Missing                |                                     */
/*    4               ppt1       |    1      1.456    ppt1   Populated              |                                     */
/*    4               ppt1       |    1               ppt1   Missing                |                                     */
/*    4               ppt1       |    1               ppt1   Missing                |                                     */
/*    4      3.722    ppt1       |    1               ppt1   Missing                |                                     */
/*    4               ppt1       |    1               ppt1   Missing                |                                     */
/*    4               ppt1       |    1               ppt1   Missing                |                                     */
/*    4               ppt1       |                                                  |                                     */
/*    4               ppt1       |                                                  |                                     */
/*    4               ppt1       |                                                  |                                     */
/*                               |                                                  |                                     */
/**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;
 input  item$  Time$   ppt$;
cards4;
1 .         ppt1
1 .         ppt1
1 .         ppt1
1 .         ppt1
1 1.456     ppt1
1 .         ppt1
1 .         ppt1
1 .         ppt1
1 .         ppt1
1 .         ppt1
2 .         ppt1
2 .         ppt1
2 .         ppt1
2 .         ppt1
2 .         ppt1
2 .         ppt1
2 .         ppt1
2 .         ppt1
2 .         ppt1
2 .         ppt1
3 .         ppt1
3 .         ppt1
3 .         ppt1
3 .         ppt1
3 .         ppt1
3 .         ppt1
3 .         ppt1
3 .         ppt1
3 .         ppt1
3 .         ppt1
4 .         ppt1
4 .         ppt1
4 .         ppt1
4 .         ppt1
4 3.722     ppt1
4 .         ppt1
4 .         ppt1
4 .         ppt1
4 .         ppt1
4 .         ppt1
;;;;
run;quit;

/*                             _
/ |  ___  __ _ ___   ___  __ _| |
| | / __|/ _` / __| / __|/ _` | |
| | \__ \ (_| \__ \ \__ \ (_| | |
|_| |___/\__,_|___/ |___/\__, |_|
                            |_|
*/
proc sql;
   create
      table want as
   select
      item
      ,ppt
      ,sum(not missing(time)) as populated
      ,sum(    missing(time)) as missing
   from
     sd1.have
   group
     by item,  ppt
;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  WANT total obs=4                                                                                                      */
/*                                                                                                                        */
/*   ITEM    PPT     POPULATED    MISSING                                                                                 */
/*                                                                                                                        */
/*    1      ppt1        1            9                                                                                   */
/*    2      ppt1        0           10                                                                                   */
/*    3      ppt1        0           10                                                                                   */
/*    4      ppt1        1            9                                                                                   */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*___                     _
|___ \   _ __   ___  __ _| |
  __) | | `__| / __|/ _` | |
 / __/  | |    \__ \ (_| | |
|_____| |_|    |___/\__, |_|
                       |_|
*/

%utl_rbeginx;
parmcards4;
library(haven)
library(dplyr)
source("c:/oto/fn_tosas9x.R")
have<-read_sas("d:/sd1/have.sas7bdat")
want<- have %>%
    mutate(time_mi =
     if_else(TIME == "", "NA", "Value")) %>%
    group_by(PPT, ITEM) %>%
    summarize(
        N_NAs = sum(time_mi == "NA"),
        N_Values = sum(time_mi == "Value")
    )
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="rwant"
     )
;;;;
%utl_rendx;

proc print data=sd1.rwant;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* R dataframe                                                                                                            */
/*                                                                                                                        */
/*  # Groups:   PPT [1]                                                                                                   */
/*    PPT   ITEM  N_NAs N_Values                                                                                          */
/*    <chr> <chr> <int>    <int>                                                                                          */
/*  1 ppt1  1         9        1                                                                                          */
/*  2 ppt1  2        10        0                                                                                          */
/*  3 ppt1  3        10        0                                                                                          */
/*  4 ppt1  4         9        1                                                                                          */
/*                                                                                                                        */
/* BACK TO SAS                                                                                                            */
/*                                                                                                                        */
/*  ROWNAMES    PPT     ITEM    N_NAS    N_VALUES                                                                         */
/*                                                                                                                        */
/*      1       ppt1     1         9         1                                                                            */
/*      2       ppt1     2        10         0                                                                            */
/*      3       ppt1     3        10         0                                                                            */
/*      4       ppt1     4         9         1                                                                            */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*____               _   _                             _
|___ /   _ __  _   _| |_| |__   ___  _ __    ___  __ _| |
  |_ \  | `_ \| | | | __| `_ \ / _ \| `_ \  / __|/ _` | |
 ___) | | |_) | |_| | |_| | | | (_) | | | | \__ \ (_| | |
|____/  | .__/ \__, |\__|_| |_|\___/|_| |_| |___/\__, |_|
        |_|    |___/                                |_|
*/

%utl_pybeginx;
parmcards4;
exec(open('c:/oto/fn_python.py').read());
have, meta = ps.read_sas7bdat('d:/sd1/have.sas7bdat');
want=pdsql('''
   select
      item
      ,ppt
      ,sum( time = ''  ) as populated
      ,sum( time <> '' ) as missing
   from
     have
   group
     by item,  ppt
   ''');
print(want);
fn_tosas9x(want,outlib='d:/sd1/',outdsn='pywant',timeest=3);
;;;;
%utl_pyendx;

proc print data=sd1.pywant;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  PYTHON                                                                                                                */
/*                                                                                                                        */
/*     ITEM   PPT  populated  missing                                                                                     */
/*   0    1  ppt1          9        1                                                                                     */
/*   1    2  ppt1         10        0                                                                                     */
/*   2    3  ppt1         10        0                                                                                     */
/*   3    4  ppt1          9        1                                                                                     */
/*                                                                                                                        */
/*  SAS                                                                                                                   */
/*                                                                                                                        */
/*  ITEM    PPT     POPULATED    MISSING                                                                                  */
/*                                                                                                                        */
/*   1      ppt1         9          1                                                                                     */
/*   2      ppt1        10          0                                                                                     */
/*   3      ppt1        10          0                                                                                     */
/*   4      ppt1         9          1                                                                                     */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*  _                _       _             _
| || |    _ __    __| |_ __ | |_   _ _ __ | | __ _ _ __   __ _ _   _  __ _  __ _  ___
| || |_  | `__|  / _` | `_ \| | | | | `__|| |/ _` | `_ \ / _` | | | |/ _` |/ _` |/ _ \
|__   _| | |    | (_| | |_) | | |_| | |   | | (_| | | | | (_| | |_| | (_| | (_| |  __/
   |_|   |_|     \__,_| .__/|_|\__, |_|   |_|\__,_|_| |_|\__, |\__,_|\__,_|\__, |\___|
                      |_|      |___/                     |___/             |___/
*/

proc datasets lib=sd1 nodetals nolist;
  delete pywant;
run;quit;

%utl_rbeginx;
parmcards4;
library(haven)
library(dplyr)
source("c:/oto/fn_tosas9x.R")
have<-read_sas("d:/sd1/have.sas7bdat")
want<- have %>%
    mutate(time_mi = if_else(TIME == "", "NA", "Value")) %>%
    group_by(PPT, ITEM) %>%
    summarize(
        N_NAs = sum(time_mi == "NA"),
        N_Values = sum(time_mi == "Value")
    )
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="pywant"
     )
;;;;
%utl_rendx;

proc print data=sd1.pywant;
run;quit;
/**************************************************************************************************************************/
/*                                                                                                                        */
/*  R                                                                                                                     */
/*                                                                                                                        */
/*     PPT   ITEM  N_NAs N_Values                                                                                         */
/*     <chr> <chr> <int>    <int>                                                                                         */
/*   1 ppt1  1         9        1                                                                                         */
/*   2 ppt1  2        10        0                                                                                         */
/*   3 ppt1  3        10        0                                                                                         */
/*   4 ppt1  4         9        1                                                                                         */
/*                                                                                                                        */
/*  SAS                                                                                                                   */
/*                                                                                                                        */
/*  ITEM    PPT     POPULATED    MISSING                                                                                  */
/*                                                                                                                        */
/*   1      ppt1         9          1                                                                                     */
/*   2      ppt1        10          0                                                                                     */
/*   3      ppt1        10          0                                                                                     */
/*   4      ppt1         9          1                                                                                     */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
