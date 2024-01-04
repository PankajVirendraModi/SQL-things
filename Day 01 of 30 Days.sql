create schema shakra;

set search_path to shakra;

create table A(
id int);
insert into A values(1),(1),(1),(2),(2),(NULL),(3),(4),(NULL),(NULL);


create table B(
id int);
insert into B values(1),(1),(2),(2),(2),(3),(3),(NULL),(4),(NULL),(NULL),(5),(5);

select * from A;
select * from B;

select count(*) as rows_cnt from A left join B on A.id = B.id;
/*
The three '1’s in A match with the two '1’s in B, generating 6 rows.
The two '2’s in A match with the three '2’s in B, generating 6 rows.
The ‘3’ in A matches with the two '3’s in B, generating 2 rows.
The ‘4’ in A matches with the ‘4’ in B, generating 1 row.
The three NULLs in A do not match with anything in B (even the NULLs), generating 3 rows.
So, the total number of rows returned by the LEFT JOIN operation is
6(from ‘1’) + 6(from ‘2’) + 2(from ‘3’) + 1(from ‘4’) + 3(from NULL) = 18 rows.
*/

select count(*) as rows_cnt from A right join B on A.id = B.id;
/*
The two '1’s in B match with the three '1’s in A, generating 6 rows.
The three '2’s in B match with the two '2’s in A, generating 6 rows.
The two '3’s in B match with the ‘3’ in A, generating 2 rows.
The ‘4’ in B matches with the ‘4’ in A, generating 1 row.
The three NULLs in B do not match with anything in A (even the NULLs), generating 3 rows.
The two '5’s in B do not match with anything in A, generating 2 rows.
So, the total number of rows returned by the RIGHT JOIN operation is
6(from ‘1’) + 6(from ‘2’) + 2(from ‘3’) + 1(from ‘4’) + 3(from NULL) + 2(from ‘5’) = 20 rows.
*/

select count(*) as rows_cnt from A inner join B on A.id = B.id;
/*
The three '1’s in A match with the two '1’s in B, generating 6 rows.
The two '2’s in A match with the three '2’s in B, generating 6 rows.
The ‘3’ in A matches with the two '3’s in B, generating 2 rows.
The ‘4’ in A matches with the ‘4’ in B, generating 1 row.
So, the total number of rows returned by the INNER JOIN operation is
6(from ‘1’) + 6(from ‘2’) + 2(from ‘3’) + 1(from ‘4’) = 15 rows.
*/
select count(*) as rows_cnt from A full outer join B on A.id = B.id;
/* The three '1’s in A match with the two '1’s in B, generating 6 rows.
The two '2’s in A match with the three '2’s in B, generating 6 rows.
The ‘3’ in A matches with the two '3’s in B, generating 2 rows.
The ‘4’ in A matches with the ‘4’ in B, generating 1 row.
The three NULLs in A do not match with anything in B (even the NULLs), generating 3 rows.
The two '5’s in B do not match with anything in A, generating 2 rows.
The three NULLs in B do not match with anything in A (even the NULLs), generating 3 additional rows.
So, the total number of rows returned by the FULL OUTER JOIN operation is
6(from ‘1’) + 6(from ‘2’) + 2(from ‘3’) + 1(from ‘4’) + 3(from NULL in A) + 2(from ‘5’ in B) + 3(from NULL in B) = 23 rows */