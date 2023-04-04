/*1. Select director name together with each film the director made*/

select DirectorName, [dbo].[tblFilm].FilmName
from [dbo].[tblDirector]
join [dbo].[tblFilm]
on [dbo].[tblDirector].DirectorID = [dbo].[tblFilm].FilmDirectorID ;


/*2. Select Film id together with name of director who made the film*/

select [dbo].[tblFilm].FilmID , [dbo].[tblDirector].DirectorName
from [dbo].[tblFilm]
join [dbo].[tblDirector]
on [dbo].[tblDirector].DirectorID = [dbo].[tblFilm].FilmDirectorID
order by [dbo].[tblFilm].FilmID ;

/*3. Select director who did not win any oscar yet for all the films he/she made*/

select [dbo].[tblDirector].DirectorName,count(FilmOscarWins) as Total_oscar_wins, FilmName
from [dbo].[tblFilm]
left join [dbo].[tblDirector]
on [dbo].[tblDirector].DirectorID = [dbo].[tblFilm].FilmDirectorID
group by DirectorName, FilmOscarWins, FilmName
having count(FilmOscarWins) = 0

/*4. Select Certificate together with the name of Directors*/

select distinct([dbo].[tblDirector].DirectorName), tblCertificate.Certificate 
from [dbo].[tblFilm]
join [dbo].[tblCertificate]
on [dbo].[tblCertificate].CertificateID = [dbo].[tblFilm].FilmCertificateID
join [dbo].[tblDirector]
on [dbo].[tblDirector].DirectorID = [dbo].[tblFilm].FilmDirectorID
group by tblCertificate.Certificate, [dbo].[tblDirector].DirectorName
order by [dbo].[tblDirector].DirectorName 

/*4a. Select Director together with the No certificate value*/

select [dbo].[tblDirector].DirectorName, tblCertificate.Certificate,  tblCertificate.CertificateID
from [dbo].[tblFilm]
left join [dbo].[tblCertificate]
on [dbo].[tblCertificate].CertificateID = [dbo].[tblFilm].FilmCertificateID
join [dbo].[tblDirector]
on [dbo].[tblDirector].DirectorID = [dbo].[tblFilm].FilmDirectorID
where tblCertificate.Certificate IS  NULL
group by  [dbo].[tblDirector].DirectorName, tblCertificate.CertificateID, tblCertificate.Certificate
order by [dbo].[tblDirector].DirectorName 

/*films with null certificate(Practise)*/
Select tblCertificate.Certificate ,[dbo].[tblFilm].FilmName, [dbo].[tblFilm].FilmCertificateID
from [dbo].[tblFilm]
left join [dbo].[tblCertificate]
on [dbo].[tblCertificate].CertificateID = [dbo].[tblFilm].FilmCertificateID
where tblCertificate.Certificate IS NULL


/*5. Select Films that does not make any box office and No value for Film budget*/

select [dbo].[tblFilm].FilmName , FilmBoxOfficeDollars ,FilmBudgetDollars
from [dbo].[tblFilm]
where FilmBoxOfficeDollars IS NULL AND FilmBudgetDollars IS NOT NULL
order by [dbo].[tblFilm].FilmName

/*5a. Select Films that does not make any box office*/

select [dbo].[tblFilm].FilmName , FilmBoxOfficeDollars ,FilmBudgetDollars
from [dbo].[tblFilm]
where FilmBoxOfficeDollars IS NULL
order by [dbo].[tblFilm].FilmName


/*6. Select customer together with the products that he bought*/
/*any way to group the 1 director and its list of movies only, not the repeated director name for each row*/
/*7. Select product names together with the name of corresponding category*/
/*8. Select orders together with the name of the shipping company*/
/*9. Select customers with id greater than 50 together with each order they made*/
/*10. Select employees together with orders with order id greater than 10400*/

-------------------------------------------------------2--------------------------------------------------------------------
/*1. Select the most expensive product*/

select [dbo].[tblFilm].FilmName
from [dbo].[tblFilm]
order by [dbo].[tblFilm].FilmBoxOfficeDollars Desc Limit 1

/*2. Select the second most expensive product*/
select [dbo].[tblFilm].FilmName
from [dbo].[tblFilm]
order by [dbo].[tblFilm].FilmBoxOfficeDollars Desc
Limit 1 OFFSET 1


