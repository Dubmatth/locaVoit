<?php
  $location= json_decode($_POST['location']);

  $pdo=new PDO('mysql:host=localhost; dbname=locavoit2016; charset=utf8',
               'root', '');

  $statement=$pdo->prepare("
    UPDATE locations
    SET dFinLoc= :dFinLoc, kmFinLoc= :kmFinLoc, prixLoc= :prixLoc, remLoc= :remLoc
    WHERE idLoc= :idLoc
      AND dFinLoc IS NULL AND dDebLoc <= :dFinLoc
      AND kmFinLoc IS NULL AND kmDebLoc <= :kmFinLoc
      AND :prixLoc >= 0
    ;
    ");
  $statement->bindParam(':idLoc', $location->idLoc, PDO::PARAM_INT);
  $statement->bindParam(':dFinLoc', $location->dFinLoc, PDO::PARAM_STR);
  $statement->bindParam(':kmFinLoc', $location->kmFinLoc, PDO::PARAM_INT);
  $statement->bindParam(':prixLoc', $location->prixLoc, PDO::PARAM_STR);
  $statement->bindParam(':remLoc', $location->remLoc, PDO::PARAM_STR);
  $statement->execute();

  echo $statement->rowCount();
  //echo $location->idLoc;
?>
