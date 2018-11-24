<?php
  $pdo=new PDO('mysql:host=localhost; dbname=locavoit2016; charset=utf8',
               'root', 'root');

  $statement=$pdo->prepare("
    SELECT idLoc, dDebLoc, DATEDIFF(CURDATE(),dDebLoc)+1 AS dureeLoc, kmDebLoc,
           idCli, nomCli, prenomCli,
           idVoit, modVoit, carbVoit,
           idCat, pxKmCat, pxJourCat
    FROM locations
      LEFT JOIN clients ON clientLoc = idCli
      LEFT JOIN voitures ON voitureLoc = idVoit
      LEFT JOIN categories ON catVoit = idCat
    WHERE dFinLoc IS NULL
    ;
    ");
  $statement->execute();
  $results=$statement->fetchAll(PDO::FETCH_ASSOC);
  $json=json_encode($results);

  echo $json;
?>
